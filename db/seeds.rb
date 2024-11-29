# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


gods = %w[Zeus@olympus.com Athena@olympus.com Ares@olympus.com Aphrodite@olympus.com Demeter@olympus.com Hera@olympus.com]

gods.each do |god|
  User.create!(email: god, password: "123456", password_confirmation: "123456")
end
