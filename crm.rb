require './contact.rb'

class CRM


  def initialize
    @contacts = []
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.chomp.to_i
      call_option(user_selected)
    end
  end
  def print_main_menu
    clean
    puts "[ 1 ] Add a new contact to the system"
    puts "[ 2 ] Modify an existing contact in the system"
    puts "[ 3 ] Delete a contact in the system"
    puts "[ 4 ] Display all the contacts in this system"
    puts "[ 5 ] Search by attribute in this system"
    puts "[ 6 ] Exit"
    puts "Please enter a number: "
  end


# These methods are class methods in the Contact class.
# They could have been in this class, then multiple methods should have been implemented twice.
# So they went to the Contact class. I feel sorry for them,
# because I wanted this CRM class, to be able to manage multiple instances of CRM.

  def call_option(selected)
    case selected
    when 1
      Contact.add_contact
    when 2
      Contact.modify
    when 3
      Contact.delete_versions
    when 4
      Contact.display_contacts
    when 5
      Contact.search_by_attribute
    when 6
      puts "Bye bye Sasha..."
      exit
    end

  end
  def clean
    puts "\e[H\e[2J"
  end






  # def display_CRM_contacts
  #   @contacts.each do |cc|
  #     puts "ID: #{ cc.id }, First Name: #{ cc.first_name }, Last Name: #{ cc.last_name }, Email: #{ cc.email }, Note: #{ cc.note }."
  #   end
  #   return @contacts
  # end

  # def search_by_attribute
  #   # input = "first_name"
  #   # contact = Contact.new
  #   # contact.send(input) == contact.first_name
  #   # case input
  #   # when 1
  #   #   @contacts.each do |i|
  #   #     i.name
  #   #   end
  #   # end
  # end
end
