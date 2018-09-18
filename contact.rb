class Contact

  @@contact_list = []
  @@next_id = 1
  @@test = []

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    @id = nil
  end

  # getters

  def first_name
    return @first_name
  end

  def last_name
    return @last_name
  end

  def email
    return @email
  end

  def note
    return @note
  end

  def id
    return @id
  end
  # setters

  def first_name=(first_name)
    @first_name = first_name
  end

  def last_name=(last_name)
    @last_name = last_name
  end

  def email=(email)
    @email = email
  end

  def note=(note)
    @note = note
  end

  def id=(id)
    @id = id
  end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    new_contact = self.new(first_name, last_name, email, note)
    new_contact.id = @@next_id # cannot use a @id counter bc it zeroes at every initialization
    @@next_id += 1
    @@contact_list << new_contact
    return new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    return @@contact_list
  end

  # This method should accept an id as an argument
  # and return the contact who has that id. Question: can a searchb or find be used? didn't succeed.
  def self.find(id_to_find)
    @@contact_list.each do |item|
      if item.id == id_to_find
        return item
      end
    end
  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute, new_value)
    self.send("#{attribute}=",new_value)
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty

  def self.find_by(attribute, attribute_value)
    # send is an analogue of indirect function in excel
    puts @@contact_list.select { |contact| contact.send(attribute) == attribute_value }.inspect
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contact_list.clear
  end

  # This method should return the full name of the contact
  def full_name
    return "#{first_name} #{last_name}"
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete
    @@contact_list.delete(self)
  end

  # Feel free to add other methods here, if you need them.

end

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
