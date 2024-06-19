class Post < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  # Additional methods or associations can go here

  # Ransack needs Post attributes explicitly allowlisted as
  # searchable. Define a `ransackable_attributes` class method in your `Post`
  # model, watching out for items you DON'T want searchable (for
  # example, `encrypted_password`, `password_reset_token`, `owner` or
  # other sensitive information).
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "content", "created_at", "updated_at"]
  end
end
