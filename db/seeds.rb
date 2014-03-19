# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create( [{username: "Mark", password: "mark"}, {username: "Fred", password: "fred"}, {username: "Bob", password: "bob"}] )
Category.create( [{name: "First"}, {name: "Second"}, {name: "Third"}] )
Post.create(url: "google.com", title: "My first post", description: "This is my first post", creator: User.first ).category_ids = [1, 2]
Post.create(url: "cnn.com", title: "My second post", description: "This is my second post", creator: User.first ).category_ids = [2, 3]
Post.create(url: "gotealeaf.com", title: "My third post", description: "This is my third post", creator: User.first ).category_ids = [3]
Comment.create(body: "This is my first comment", creator: User.first, post: Post.first )
Comment.create(body: "This is my second comment", creator: User.first, post: Post.find(2) )
Comment.create(body: "This is my third comment", creator: User.first, post: Post.find(2) )
