
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

ActiveRecord::Base.connection.execute('TRUNCATE users CASCADE')
ActiveRecord::Base.connection.execute('TRUNCATE posts CASCADE')
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('posts')

names = ['Ali', 'Abdo', 'Neko', 'Zien', 'Amin']
5.times do |i|
  User.create!(username: "#{names[i]}", fullname: "#{names[i]}").tap do |user|
    5.times do |j|
      user.posts.create(content: "post number #{j} of user #{i}")
    end
  end
end
