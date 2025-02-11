# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.create([
  { name: "T-Shirt", price: 500, size: "M", color: "Red" },
  { name: "Jeans", price: 1200, size: "L", color: "Blue" },
  { name: "Jacket", price: 2500, size: "XL", color: "Black" },
  { name: "Shoes", price: 3000, size: "10", color: "White" },
  { name: "Cap", price: 400, size: "Free", color: "Green" },
  { name: "Socks", price: 150, size: "L", color: "Gray" },
  { name: "Gloves", price: 600, size: "M", color: "Brown" },
  { name: "Shorts", price: 800, size: "S", color: "Yellow" },
  { name: "Sweater", price: 2000, size: "M", color: "Pink" },
  { name: "Scarf", price: 700, size: "Free", color: "Purple" }
])
