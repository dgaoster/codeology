# == Schema Information
=begin
# Table name: users
#
# id              :integer          not null, primary key
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.boolean  "is_admin",               default: false
    t.integer  "curr_week",              default: 0
    t.integer  "next_week",              default: 0
    t.integer  "interviewing_curr_week", default: 0
    t.integer  "interviewing_next_week", default: 0
    t.integer  "interviewing_limit",     default: 2
    t.string   "activation_digest"
    t.boolean  "activated",              default: false
    t.datetime "activated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
=end

class User < ApplicationRecord
  attr_accessor :activation_token
  before_create :create_activation_digest
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 8 }, allow_nil:true

  # scope :leadership_team, -> { where(is_officer: true) }

  # Call this once the registration activation link has been clicked to
  # set activated and clear the confirmation token
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
    # update_attribute(:activated,    true)
    # update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # is_admin controls whether this user should have website administration capabilities
  # i.e. toggling admin for other people, changing account information, etc.
  def toggle_admin
    self.is_admin = !self.is_admin
    save!(:validate => false)
  end

  # Checks if a token has been authenticated (useful for remember, account activation, and PW reset tokens)
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Checks if token has expired
  def expired?(attribute, token)
    sent_at = send("#{attribute}_sent_at")
    sent_at < 3.hours.ago
  end

  private

    # Creates a token and its digest and sent time
    def create_activation_digest
        self.activation_token = User.new_token
        update_attribute(:activation_digest, User.digest(activation_token))
        update_attribute(:activation_sent_at, Time.zone.now)
    end

    # Generates new token
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
end
