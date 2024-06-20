# Active Admin

A rails application using the Active Admin with docker.

Project created following this tutorial: https://activeadmin.info/documentation.html

**Obs.:** The application name used to create this tutorial is `active_admin`. Update to your application name.


## Docker configuration
Set the docker-compose file:
```yaml
version: '3'

services:
  active_admin:
    build:
      context: .
      dockerfile: Dockerfile.project
    container_name: active_admin
    ports:
      - "3000:3000"
    volumes:
      - .:/app

```

Set the Dockerfile.project with the following code:
```dockerfile

FROM ruby:3.3.1

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
  nodejs \
  libqt5webkit5-dev \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

# Precompile assets for production
# RUN bundle exec rake assets:precompile

# Specify the command to run the application
CMD ["rails", "server", "-b", "0.0.0.0"]
```

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

Run the application:  
`docker-compose up --build`

Get inside the container:  
`docker exec -it active_admin bash`

Now, run the installer:

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

## Using a Model
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

## Conclusion
You started an application and set active admin using docker. Keep learning and practicing.