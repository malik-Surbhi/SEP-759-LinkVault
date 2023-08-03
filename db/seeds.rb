# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Link.destroy_all
UserRole.destroy_all
Role.destroy_all

#Create an admin user
admin_user = User.create!(
  username: 'admin',
  email: 'admin@example.com',
  password: '1234',
  password_confirmation: '1234',
  bio: 'Hi this is admin and I have the admin rights of this app'
)

# Attach profile photo to the admin user
profile_photo_path = Rails.root.join('app', 'assets', 'images', 'admin_profile_photo.png')
admin_user.profile_photo.attach(io: File.open(profile_photo_path), filename: 'admin_profile_photo.png')

#Creating more users
users = User.create! [
                       {username: 'Surbhi', password: '1234', password_confirmation: '1234', email: 'surbhi@gmail.com', bio: 'Hey, this is Surbhi and this is my LinkTree'},
                       {username: 'TestUser', password: '1234', password_confirmation: '1234', email: 'testuser@gmail.com', bio: 'Hey, this is TestUser and this is my LinkTree'},
                       {username: 'Christine', password: '1234', password_confirmation: '1234', email: 'christine@gmail.com', bio: 'Hey, this is Christine and I enjoy reading books'},
                     ]

#Adding profile photos to the two users
surbhi = users[0];
testUser = users[1];
christine = users[2]

surbhi_photo_path = Rails.root.join('app', 'assets', 'images', '1.png')
surbhi.profile_photo.attach(io: File.open(surbhi_photo_path), filename: '1.png')

testUser_photo_path = Rails.root.join('app', 'assets', 'images', '13.png')
testUser.profile_photo.attach(io: File.open(testUser_photo_path), filename: '13.png')

christine_photo_path = Rails.root.join('app', 'assets', 'images', '3.png')
christine.profile_photo.attach(io: File.open(christine_photo_path), filename: '3.png')


#Adding Links to users
links = Link.create! [
                       {title: 'Instagram', url: 'https://instagram.com/Surbhi', description: 'This is the link for instagram of Surbhi', user_id: users.first.id},
                       {title: 'Facebook', url: 'https://facebook.com/Surbhi', description: 'This is the link for Facebook of Surbhi', user_id: users.first.id},
                       {title: 'Youtube', url: 'https://youtube.com/testUser', description: 'This is the link for Youtube of TestUser',  user_id: users.second.id},
                       {title: 'Ruby On Rails', url: 'https://rubyOnRails.com/admin', description: 'This is the link for Ruby on Rails of Admin',  user_id: admin_user.id},
                       {title: 'Youtube Vlog', url: 'https://youtube.com/admin', description: 'This is the link for my Youtube channel ',  user_id: admin_user.id},
                       {title: 'Medium Post', url: 'https://medium.com/new_post', description: 'This is the link for my Medium post on the latest dev work ',  user_id: admin_user.id},
                       {title: 'Reddit discussion', url: 'https://reddit.com/findings', description: 'Linking the latest reddit post in which we had discussion ',  user_id: christine.id},
                       {title: 'My Website', url: 'https://godaddy.com/christine', description: 'Welcome to my Website that I created recently! ',  user_id: christine.id}
                     ]

#Assigning roles to users
roles = Role.create! [
                       {name: 'admin'},
                       {name: 'user'}
                     ]

#Assigning the admin role
role = Role.find_by name: 'admin'
UserRole.create! [{user_id: admin_user.id, role_id: role.id}]
UserRole.create! [{user_id: christine.id, role_id: role.id}]

#Assigning User role
roleUser = Role.find_by name: 'user'
UserRole.create! [{user_id: surbhi.id, role_id: roleUser.id}]
UserRole.create! [{user_id: testUser.id, role_id: roleUser.id}]



