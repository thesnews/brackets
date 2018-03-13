chron brackets
==============
This is the site for the Duke Chronicle's annual March Madness bracket
challenge. It is a Ruby on Rails application.

Setup
-----
This rails application has been verified to work with ruby 2.3.0.
[Bower][bower] is also required. Once ruby and bower have been set up:
- Install dependencies: `bundle install`
- Run database migrations: `rake db:migrate`
- Install frontend dependencies: `rake bower:install`

The server can be run locally with `rails server`.

At this point, the database should be empty. You can load seed data with `rake
db:seed`, which loads data from [`db/seeds.rb`][seeds]. Alternatively, you can
create an account and create data manually. It's easiest to create an account
through the app. The user can be made an admin user in the rails console, like:
```ruby
$ rails c
2.3.0 :001 > user = User.first
  User Load (0.2ms)  SELECT  "users".* FROM "users"  ORDER BY "users"."id" ASC LIMIT 1
 => #<User id: 1, email: "hello@example.com", encrypted_password: "...", reset_password_token: nil, ...>
2.3.0 :002 > user.update(role: 'admin')
 => true
```
The admin console at `/admin` can be accessed when signed in as a user with an
`admin` role.

Deployment
----------
This application is currently deployed through Heroku. Contact [Michael
Lai][mlai] to get access to the app used in production. We use a [slightly
modified buildpack][ruby-bower-buildpack] for ruby apps with bower, which has
already been set up in production.

[bower]: https://bower.io/
[mlai]: https://github.com/themichaellai
[ruby-bower-buildpack]: https://github.com/themichaellai/heroku-buildpack-ruby-bower
[seeds]: https://github.com/dukechronicle/brackets/blob/60d7aa3926ecbc012afd54ca6ede0189cb97103a/db/seeds.rb
