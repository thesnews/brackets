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

Running on latest Ubuntu LTS, fresh install.

First, upgrade packages:

```
apt update
apt dist-upgrade -y
```

Then install necessary packages for bundler and rake:

```
apt install ruby ruby-bundler ruby-dev
apt install make automake gcc zlib1g-dev libpq-dev libsqlite3-dev cmake
apt install postgresql
apt install nodejs npm
```

Install bower:

```
npm install -g bower
```

Set up your reverse proxy:

```
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:9292;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
        proxy_read_timeout 86400; # neccessary to avoid websocket timeout disconnect
        proxy_redirect off;
    }
}
```

Then, run through setup above and start your server:

```
rackup -Ilib config.ru -E production -D
```
