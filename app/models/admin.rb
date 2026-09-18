class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :uid, :email, presence: true
  validates :uid, uniqueness: true

  def self.from_google(auth)
    return unless auth&.provider == "google_oauth2" && auth.uid.present? && auth.info.email.present?

    # The Google strategy exposes only verified addresses in info.email.
    # Use Google's stable subject, not email, as the account identity.
    admin = find_or_initialize_by(uid: auth.uid)
    admin.update!(email: auth.info.email, full_name: auth.info.name)
    admin
  end
end
