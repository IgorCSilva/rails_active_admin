# Active Admin

Project created following this tutorial: https://activeadmin.info/documentation.html


## Initialization

Add the active admin gem:
- Gemfile
```rb
# Active Admin.
gem "activeadmin", "~> 3.2.2"

# Sass.
group :assets do
  gem 'sassc-rails'
end
```

After install the new gem, run the installer.

- If you don’t want to use Devise, run it with --skip-users:  
`rails g active_admin:install --skip-users`

- If you want to customize the name of the generated user class, or if you want to use an existing user class, provide the class name as an argument:  
`rails g active_admin:install User`

- Otherwise, with no arguments we will create an AdminUser class to use with Devise:  
`rails g active_admin:install`

Let's run:  
`rails g active_admin:install --skip-users`

Now, migrate the database:
`rails db:migrate`

You can visit the `http://localhost:3000/admin` and login with the credentials:
- user: admin@example.com
- password: password

Generate a model:
`rails generate model Post title:string content:text`

Run the migration:  
`rails db:migrate`

Update the model file.
- app/models/post.rb
```rb
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
```

Now, get inside the rails console and you can manage posts:  
`rails console`

```rb
# Create a new post
post = Post.create(title: "My first post", content: "This is the content of my first post.")

# Read a post
post = Post.find(1)

# Update a post
post.update(title: "Updated title")

# Delete a post
post.destroy

```

Register a model:
`rails generate active_admin:resource Post`