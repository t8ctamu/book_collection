require "rails_helper"

RSpec.describe "Books", type: :request do
  it "lists stored books" do
    Book.create!(title: "The Hobbit")
    get books_path, as: :json
    expect(response).to have_http_status(:ok)
    expect(response.parsed_body.map { |book| book["title"] }).to include("The Hobbit")
  end

  it "creates a book" do
    expect {
      post books_path, params: { book: { title: "Dune" } }, as: :json
    }.to change(Book, :count).by(1)
    expect(response).to have_http_status(:created)
    expect(Book.last.title).to eq("Dune")
  end

  it "updates a book" do
    book = Book.create!(title: "Old title")
    patch book_path(book), params: { book: { title: "New title" } }, as: :json
    expect(response).to have_http_status(:ok)
    expect(book.reload.title).to eq("New title")
  end

  it "deletes a book" do
    book = Book.create!(title: "Dune")
    expect {
      delete book_path(book), as: :json
    }.to change(Book, :count).by(-1)
    expect(response).to have_http_status(:no_content)
  end
end
