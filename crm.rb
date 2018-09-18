require_relative 'contact'
require "pry"

class CRM

  def initialize; end

  def self.create
    new_crm = CRM.new
  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts
    puts "<<<<<<<<<<NEW MENU SESSION>>>>>>>>>>"
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit_me
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    Contact.create(first_name, last_name, email, note)
    puts
    puts "Contact added to the Contact list"
    display_all_contacts
    puts
  end

  def modify_existing_contact
    if !Contact.all.empty?
      field = ""
      selection = ""
      value = ""
      id = 0
      # selecting the contact to modify
      display_all_contacts
      puts "Enter the id of the contact you'd like to modify: " # can be changed to name or other attribute
      id = gets.chomp.to_i
      puts "Great! Now what field would you like to change? Press 1 for name, 2 for surname, 3 - email, 4 - note..."
      selection = gets.chomp.to_i
      # binding.pry
      # case selection + integers input is a solution to avoid string input and eventual mistypes in the user iput
      case selection
      when 1 then field = "first_name"
      when 2 then field = "last_name"
      when 3 then field = "email"
      when 4 then field = "note"
      else abort("Wrong answer, exiting the program...")
      end
      puts "Good! Now what is the new value for *#{field}* field?"
      value = gets.chomp
      Contact.find(id).update(field, value)
      puts
      puts "Contact info successfully updated."
      display_all_contacts
      puts
    else
      puts
      puts "There are no contacts in the Contact list."
    end
  end

  def delete_contact
    if !Contact.all.empty?
      display_all_contacts
      print "Enter contact's id: " # can be changed to name or other attribute
      id = gets.chomp.to_i
      Contact.all.delete(Contact.find(id)) # using method from contact.rb
      puts
      puts "Contact successfully deleted!"
      if Contact.all.empty?
        puts "There are no contacts in the Contact list."
      else
        display_all_contacts
      end
      puts
    else
      puts
      puts "There are no contacts in the Contact list."
    end
    # working code adapted from find method in contact.rb
    # Contact.all.each do |item|
    # # binding.pry
    #     if item.id == id
    #       Contact.all.delete(item)
    #       # puts Contact.all.inspect
    #       puts "Contact deleted!"
    #     end
    # end
  end

  def display_all_contacts
    if !Contact.all.empty?
      puts
      puts "Below are all the contacts currently in the Contact list:"
      puts
      puts Contact.all.inspect
      puts
    else
      puts
      puts "There are no contacts in the Contact list."
    end
  end

  def search_by_attribute
    if !Contact.all.empty?
      field = ""
      selection = ""
      value = ""
      puts "What field would you like to perform a search on? Press 1 for name, 2 for surname, 3 - email, 4 - note..."
      selection = gets.chomp.to_i
      # binding.pry
      case selection
      when 1 then field = "first_name"
      when 2 then field = "last_name"
      when 3 then field = "email"
      when 4 then field = "note"
      else abort("Wrong answer, exiting the program...")
      end
      puts "Good! Now what do you want me to search for in *#{field}s*?"
      value = gets.chomp
      puts
      puts "Contact found:"
      Contact.find_by(field, value)
      puts
    else
      puts
      puts "There are no contacts in the Contact list."
    end
  end

  def exit_me
    abort("I'm out of it!")
  end

end

crm = CRM.create
crm.main_menu

at_exit do
  ActiveRecord::Base.connection.close
end
