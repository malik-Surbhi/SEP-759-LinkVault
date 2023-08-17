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
admin = User.create!(
  username: 'admin',
  email: 'admin@gmail.com',
  password: '123456',
  password_confirmation: '123456',
  bio: 'Hi this is admin and I have the admin rights of this app'
)

# Attach profile photo to the admin user
profile_photo_path = Rails.root.join('app', 'assets', 'images', 'admin_profile_photo.png')
admin.profile_photo.attach(io: File.open(profile_photo_path), filename: 'admin_profile_photo.png')

#Creating more users
users = User.create! [
                       {username: 'Sumalik', password: '123456', password_confirmation: '123456', email: 'surbhimalik@gmail.com', bio: 'Hey, this is Surbhi and this is my LinkTree'},
                       {username: 'Tester', password: '123456', password_confirmation: '123456', email: 'tester@gmail.com', bio: 'Hey, this is TestUser and this is my LinkTree'},
                       {username: 'Inertia', password: '123456', password_confirmation: '123456', email: 'inertia@gmail.com', bio: 'Hey, this is Inertia and I enjoy reading books'},
                       {username: 'LinkVault', password: '123456', password_confirmation: '123456', email: 'linkvaultapp6@gmail.com', bio: 'Hey, this is LinkVault and this is my gmail account'}
                     ]

#Adding profile photos to the two users
sumalik = users[0];
tester = users[1];
inertia = users[2]
linkvaultapp = users[3]

surbhi_photo_path = Rails.root.join('app', 'assets', 'images', '1.png')
sumalik.profile_photo.attach(io: File.open(surbhi_photo_path), filename: '1.png')

testUser_photo_path = Rails.root.join('app', 'assets', 'images', '13.png')
tester.profile_photo.attach(io: File.open(testUser_photo_path), filename: '13.png')

inertia_photo_path = Rails.root.join('app', 'assets', 'images', '3.png')
inertia.profile_photo.attach(io: File.open(inertia_photo_path), filename: '3.png')

linkvaultapp_photo_path = Rails.root.join('app', 'assets', 'images', 'linkvault.png')
linkvaultapp.profile_photo.attach(io: File.open(linkvaultapp_photo_path), filename: 'linkvault.png')


#Adding Links to users
links = Link.create! [
                       {title: 'Instagram', url: 'https://instagram.com/Surbhi', description: 'This is the link for instagram of Surbhi', user_id: users.first.id},
                       {title: 'Facebook', url: 'https://facebook.com/Surbhi', description: 'This is the link for Facebook of Surbhi', user_id: users.first.id},
                       {title: 'Youtube', url: 'https://youtube.com/testUser', description: 'This is the link for Youtube of TestUser',  user_id: users.second.id},
                       {title: 'Ruby On Rails', url: 'https://rubyOnRails.com/admin', description: 'This is the link for Ruby on Rails of Admin',  user_id: admin.id},
                       {title: 'Youtube Vlog', url: 'https://youtube.com/admin', description: 'This is the link for my Youtube channel ',  user_id: admin.id},
                       {title: 'Medium Post', url: 'https://medium.com/new_post', description: 'This is the link for my Medium post on the latest dev work ',  user_id: admin.id},
                       {title: 'Reddit discussion', url: 'https://reddit.com/findings', description: 'Linking the latest reddit post in which we had discussion ',  user_id: inertia.id},
                       {title: 'My Website', url: 'https://godaddy.com/christine', description: 'Welcome to my Website that I created recently! ',  user_id: inertia.id},
                       {title: 'LinkVault App', url: 'https://linkvaultapp.com/link', description: 'Welcome to my Website that I created recently! ',  user_id: linkvaultapp.id}
                     ]

#Assigning roles to users
roles = Role.create! [
                       {name: 'admin'},
                       {name: 'user'}
                     ]

#Assigning the admin role
role = Role.find_by name: 'admin'
UserRole.create! [{user_id: admin.id, role_id: role.id}]
UserRole.create! [{user_id: inertia.id, role_id: role.id}]

#Assigning User role
roleUser = Role.find_by name: 'user'
UserRole.create! [{user_id: sumalik.id, role_id: roleUser.id}]
UserRole.create! [{user_id: tester.id, role_id: roleUser.id}]
UserRole.create! [{user_id: linkvaultapp.id, role_id: roleUser.id}]



