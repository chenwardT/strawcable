# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

chen = User.create(username: 'chen',
                   email: 'chen@google.com',
                   password: 'test1234')

p1 = Poll.create(question: 'Rain or snow?', user: chen)
p1.poll_options.create(text: 'Rain')
p1.poll_options.create(text: 'Snow')

p2 = Poll.create(question: 'Dre or Snoop?', user: chen)
p2.poll_options.create(text: 'Dre')
p2.poll_options.create(text: 'Snoop')
