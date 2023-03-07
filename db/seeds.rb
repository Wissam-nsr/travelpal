# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
User.destroy_all
User.create!(username: "wissou", email:"bob@mail.com", password: "123456")
