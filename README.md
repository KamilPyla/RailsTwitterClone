# Ruby on Rails App Twitter Clone

Twitter Clone is a web app build the base on the book [The Ruby on Rails tutorial](https://3rd-edition.railstutorial.org/book/frontmatter) written by Michale Hartl.<br>
This service works like Twitter. You can create your own account, make posts with or without photos and following other users.

## Requirements:

* Ruby version 3.0.0

* Rails version 6.1.4

* ImageMagick [how to install](https://imagemagick.org/index.php)

* Bundler 2.2.24

* PostgreSQL version 9.3

## Setup

### Clone the repository

```bash
$ git clone https://github.com/KamilPyla/RailsTwitterClone.git 
$ cd RailsTwitterClone
```
### Copy the config file and fill it

```bash
$ cp config/database.yml.example config/database.yml
```
##### Do not forget to fill this file (username and password in database)

# Startup

```bash
$ bundle install
$ rails db:setup
$ rails server
```
now you can visit the site with the URL http://localhost:3000

### Database command

##### If you want to:
  * Reset database
  ##### before you run command below make sure that rails server and rails console are closed
  ```bash
  rails db:migrate:reset
  ```

  * generate data on the base on 
  ##### db/seeds.rb
  ```bash
  rails db:seed
  ```

Check how to write [seeds.rb](https://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html) file

## Admin panel
##### To login as an admin click on [Log in](http://localhost:3000/login) and then click on [admin](http://localhost:3000/admin/login) link below the login form.<br>Default admin user has the following data:<br>
  - email: admin@user.com
  - password: password
##### If you want you can change default data in db/seeds.rb

### As admin you can:
- create/destroy users
- create post as other user
- create/delete relation between users
- delete users
- delete posts

other functionalities come soon.
