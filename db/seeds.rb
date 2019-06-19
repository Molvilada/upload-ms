# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Image.create(image:'imagen.jpg', image_base64:Base64.encode64(open("http://www.formarte.edu.co/blog/wp-content/uploads/2016/07/La-Historia-800x500.jpg").read))