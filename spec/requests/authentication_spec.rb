require "rails_helper"

RSpec.describe "Google authentication", type: :request, unauthenticated: true do
  def google_identity
    OmniAuth::AuthHash.new(provider: "google_oauth2", uid: "google-123",
      info: { email: "reader@example.com", name: "Test Reader" })
  end

  around do |example|
    OmniAuth.config.test_mode = true
    example.run
  ensure
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  it "redirects signed-out visitors to Google sign-in" do
    get root_path
    expect(response).to redirect_to(new_admin_session_path)
    follow_redirect!
    expect(response.body).to include("Sign in with Google")
  end

  it "prevents signed-out visitors from creating, editing, or deleting books" do
    book = Book.create!(title: "Protected book")
    expect { post books_path, params: { book: { title: "Unauthorized" } } }.not_to change(Book, :count)
    expect(response).to redirect_to(new_admin_session_path)
    patch book_path(book), params: { book: { title: "Changed" } }
    expect(response).to redirect_to(new_admin_session_path)
    expect(book.reload.title).to eq("Protected book")
    expect { delete book_path(book) }.not_to change(Book, :count)
    expect(response).to redirect_to(new_admin_session_path)
  end

  it "signs in through Google's callback and signs out" do
    OmniAuth.config.mock_auth[:google_oauth2] = google_identity
    get admin_google_oauth2_omniauth_callback_path
    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("Successfully authenticated with Google", "reader@example.com", "Sign out")
    delete destroy_admin_session_path
    get root_path
    expect(response).to redirect_to(new_admin_session_path)
  end

  it "handles denied consent without creating a session" do
    OmniAuth.config.mock_auth[:google_oauth2] = :access_denied
    get admin_google_oauth2_omniauth_callback_path
    expect(response).to redirect_to(new_admin_session_path)
    expect(Admin.count).to eq(0)
    get books_path
    expect(response).to redirect_to(new_admin_session_path)
  end

  it "rejects a Google identity without a verified email" do
    auth = google_identity
    auth.info.email = nil
    OmniAuth.config.mock_auth[:google_oauth2] = auth
    get admin_google_oauth2_omniauth_callback_path
    expect(response).to redirect_to(new_admin_session_path)
    expect(Admin.count).to eq(0)
  end

  it "keeps one account when a Google user's email changes" do
    admin = Admin.from_google(google_identity)
    auth = google_identity
    auth.info.email = "updated@example.com"
    expect(Admin.from_google(auth).id).to eq(admin.id)
    expect(admin.reload.email).to eq("updated@example.com")
    expect(Admin.count).to eq(1)
  end
end
