gem 'activerecord', '=4.2.10'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base # inherits properties from ActiveRecord
  # every time we create a new Contact record, it will automatically be inserted into the contacts database table.

  field :first_name, as: :string
  field :last_name,  as: :string
  field :email,      as: :string
  field :note,       as: :text

  # This method should return the full name of the contact
  def full_name
    return "#{first_name} #{last_name}"
  end

end

Contact.auto_upgrade!

# jim = Contact.create("Jim", "Hacker", "jim.hacker@daa.co.uk", "Minister")
# humphrey = Contact.create("Humphrey", "Appleby", "humphrey.appleby@civilservice.co.uk", "Permanent Secretary")
# bernard = Contact.create("Bernard", "Woolley", "bernard.woolley@civilservice.co.uk", "Private Secretary")
# puts "The class now contains:"
# puts Contact.all.inspect
# puts humphrey.delete #returns memory pointer of the deleted item
# puts jim.full_name
# # Contact.delete_all
# # puts "The class now contains:"
# # puts Contact.all.inspect
# puts Contact.find(3)
# puts Contact.find_by("last_name", "Woolley")
# puts jim.update("first_name", "James")
# puts Contact.all.inspect
