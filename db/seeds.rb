# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Category.create( [{name: "First"}, {name: "Second"}, {name: "Third"}] )
User.create( [{username: "Mark"}, {username: "Fred"}, {username: "Bob"}] )
Post.create(url: "google.com", title: "My first post", description: "This is my first post", creator: User.first )
Post.create(url: "google.com", title: "My second post", description: "This is my second post", creator: User.first )
Comment.create(body: "This is my first comment", creator: User.first, post: Post.first )
Comment.create(body: "This is my second comment", creator: User.first, post: Post.find(2) )
Comment.create(body: "This is my third comment", creator: User.first, post: Post.find(2) )
PostCategory.create( post: Post.first, category: Category.first )
PostCategory.create( post: Post.first, category: Category.find(2) )
PostCategory.create( post: Post.find(2), category: Category.find(3) )
