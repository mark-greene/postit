# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Category.create( [{name: "First"}, {name: "Second"}, {name: "Third"}] )
User.create( [{username: "Mark"}, {username: "Fred"}, {username: "Bob"}] )
Post.create(url: "google.com", title: "My first post", description: "This is my first post", user_id: User.first.id )
Post.create(url: "google.com", title: "My second post", description: "This is my second post", user_id: User.first.id )
Comment.create(body: "This is my first comment", user_id: User.first.id, post_id: Post.first.id )
Comment.create(body: "This is my second comment", user_id: User.first.id, post_id: Post.find(2).id )
Comment.create(body: "This is my third comment", user_id: User.first.id, post_id: Post.find(2).id )
PostCategory.create( post_id: Post.first.id, category_id: Category.first.id )
PostCategory.create( post_id: Post.first.id, category_id: Category.find(2).id )
PostCategory.create( post_id: Post.find(2).id, category_id: Category.find(3).id )
