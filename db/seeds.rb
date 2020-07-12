
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#管理ユーザー作成
User.create!(name:  "arthur",
              email: "arthur5138@gmail.com",
              password:              "ohajiki1313",
             password_confirmation: "ohajiki1313",
              admin: true)
User.create!(name:  "oscar",
             email: "oscarwild13@gmail.com",
             password:              "ohajiki1313",
             password_confirmation: "ohajiki1313",
             admin: true)

#Categories
Category.create(name: "ginza")
Category.create(name: "shibuya")
Category.create(name: "aoyama")
Category.create(name: "product")
Category.create(name: "other")

if Rails.env.production?
else

#comments

#Users
30.times do
  User.create(email: Forgery('email').address, password: Forgery(:basic).password, name: Forgery('internet').user_name ,image_url: Faker::Avatar.image)
end

#Posts
users = User.order(:created_at).take(6)

image_path1 = File.join(Rails.root, "test/fixtures/images/sample.jpg")
image_path2 = File.join(Rails.root, "test/fixtures/images/sample2.jpg")
image_path3 = File.join(Rails.root, "test/fixtures/images/sample3.jpg")

5.times do
  users.each do |user|
  @post = user.posts.build(title: Faker::Lorem.sentence(5), user_id: '1', category_id: '1', content: Faker::Lorem.sentence(250), address: "shibuya")
    if @post.save
      # images.each do |a|
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path1))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path2))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path3))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path1))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path2))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path3))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path1))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path2))
        @post_attachment = @post.post_attachments.create!(picture: File.new(image_path3))
      # end
    end
  end
end

#Likes
 #30.times do
   #users.each do |user|
     #user.likes.create!(post_id: rand(90) + 1)
   #end
 #end
#Comments
 30.times do
   Commontator::Comment.create(creator_type: "User", creator_id: rand(30) + 1, thread_id: rand(90) + 1, body: Faker::Lorem.sentence(5))
 end
end
