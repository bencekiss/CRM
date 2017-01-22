require_relative './crm.rb'

class Contact
  attr_accessor :first_name, :last_name, :email, :note
  attr_reader :id
  @@all_contacts = []
  @@next_id = 1000


  def self.all
    @@all_contacts
  end

  def self.create(first_name, last_name, email, note)
    # 1. initialize a new contact w a unique id
    new_contact = self.new(first_name, last_name, email, note)
    # 2. add the new contact to the list of all contact
    @@all_contacts << new_contact
    # 3. Increment the next unique id
    @@next_id += 1
    new_contact
  end

  # adds a contact by getting its name from the user
  def self.add_contact
    puts "First name: "
    f = gets.chomp
    puts "Last name: "
    l = gets.chomp
    puts "Email: "
    e = gets.chomp
    puts "Note: "
    n = gets.chomp
  # using create instead of initialize helps
    c = self.create(f, l, e, n)

  end

# Display every contact in the respective CRM (Because there is only one).
# If there were multiple CRMs in the same time, it could display every contact that has ever been created.
  def self.display_contacts
    if @@all_contacts == []
      puts "Sorry, there is no contact in the system."
    else
      @@all_contacts.each do |cc|
        puts "ID: #{ cc.id }, First Name: #{ cc.first_name }, Last Name: #{ cc.last_name }, Email: #{ cc.email }, Note: #{ cc.note }."
      end
    end
    puts "[ Enter ] Get to the main menu"
    gets
    return @@all_contacts
  end

# initialize method, but create is a lot more effective
  def initialize(first_name, last_name, email, note)
    @id = @@next_id
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
    @email = email
    @note = note


  end

  def full_name
    "#{ first_name } #{ last_name }"
  end

# Since I always work with the @@all_contacts class variable,
# it made sense to make every method to be a class method.
#
# Modify method: finds a contact in the @@all_contacts and modifies it.

  def self.modify
    puts "Please enter the ID of the contact you want to modify"
    puts "If you want to go back to the main menu, hit #."
    input = gets.chomp
    if input == "#"
      return 0
    else
      input = input.to_i
    end

    @@all_contacts.each do |c|
      if c.id == input
# Modifies its attribute to be precise.
        self.modify_attribute(c)
        return c
      end
    end

  end

  # Attribute modifier method, who takes a Contact as an argument and modifies one of its state.

  def self.modify_attribute(c)
    puts "Please give me the number of the attribute you'd like to modify"
    puts "[ 1 ] First Name"
    puts "[ 2 ] Last Name"
    puts "[ 3 ] Email"
    puts "[ 4 ] Note"
    puts "[ # ] Previous screen"
    mod = gets.chomp
    if mod == "#"
      self.modify
    end
    mod = mod.to_i

# There is a way to make this work with the send command
# though since there is an escape route if user misclicks
# case is the choice. More coding...

    case mod
    when 1
      puts "Please type the new first name."
      puts "If you want to go back to the previous screen, hit #"
      fn = gets.chomp
      case fn
      when "#"
        self.modify_attribute(c)
      else
        c.first_name = fn
        puts "The new first name for contact #{ c.id } is #{ fn }."
      end
    when 2
      puts "Please type the new last name."
      puts "If you want to go back to the previous screen, hit #"
      fn = gets.chomp
      case fn
      when "#"
        self.modify_attribute(c)
      else
        c.last_name = fn
        puts "The new last name for contact #{ c.id } is #{ fn }."
      end
    when 3
      puts "Please type the new email address."
      puts "If you want to go back to the previous screen, hit #"
      fn = gets.chomp
      case fn
      when "#"
        self.modify_attribute(c)
      else
        c.email = fn
        puts "The new email for contact #{ c.id } is #{ fn }."
      end
    when 4
      puts "Please type the new note."
      puts "If you want to go back to the previous screen, hit #"
      fn = gets.chomp
      case fn
      when "#"
        self.modify_attribute(c)
      else
        c.note = fn
        puts "The new note for contact #{ c.id } is #{ fn }."
      end
    else
      puts "Please give me one of the numbers in the 1..4 range."
      self.modify_attribute(c)
    end
    return c
  end

# delete method, where the user can decide if the whole system has to be erased, or just one contact


  def self.delete
    puts "[ 1 ] Delete every contact that ever existed."
    puts "[ 2 ] Delete one contact"
    puts "[ # ] Go back"
    input = gets.chomp
    if input == "#"
      return 0
    end
    input = input.to_i
    case input
    when 1
      self.delete_all
    when 2
      self.delete_one
    end

    return @@all_contacts
  end

  def self.delete_all
    @@all_contacts.each do |contact|
      contact = nil
    end
    @@all_contacts = []

  end
  def self.delete_one
    puts "Do you know the ID of the item you want to delete?"
    puts "[ yes ]"
    puts "[ no ]"
    answer = gets.chomp.downcase
    if answer == "yes"
      puts "Please give me the ID of the contact you want to delete."
      id = gets.chomp.to_i

    else
      watch = self.search_by_attribute
      if watch
        id = watch.id
      else
        return nil
      end
    end

    @@all_contacts.each do |contact|
      if contact.id == id
# since the Contact class only keeps record of the instances in the @@all_contacts variable
# there is no need to erase every instance, only from that array
        @@all_contacts.delete(contact)
      end
    end
    self.display_contacts
    return @@all_contacts
  end


# Search by attribute method, in which the user can choose which attribute they want to search for

  def self.search_by_attribute

    puts "Give me an attribute you want to search for"
    puts "[ 1 ] First Name"
    puts "[ 2 ] Last Name"
    puts "[ 3 ] Email"
    puts "[ 4 ] Note"
    puts "[ # ] Back to Main Menu"
    search = gets.chomp
    if search == "#"
      return false
    end
    search = search.to_i
    case search
      when 1
        to_send = "first_name"
      when 2
        to_send = "last_name"
      when 3
        to_send = "email"
      when 4
        to_send = "note"
    end
    puts "Please give me the exact expression you want me to search in #{ to_send }s!"
    search_for = gets.chomp
    result = self.find(to_send, search_for)
    if result.empty?
      puts "Couldn't find it, try another search!"
      gets
      self.search_by_attribute
    else
      puts "Is the result among the above?"
      puts "[ yes ]"
      puts "[ no ]"
      among = gets.chomp.downcase
      if among == "yes"
        puts "Then give me the id of the contact you were looking for"
        id = gets.chomp.to_i

        result.each do |contact|
          if contact.id == id
            contact.display
            puts "[ Enter ] Get to the main screen"
            gets
            return contact
          end
        end
      else
        puts "[ Enter ] Then try another search!"
        gets
        self.search_by_attribute
      end
    end
  end

# find (attribute im searching in, phrase im looking for)
  def self.find(at, sf)
    contacts_true = []
    @@all_contacts.each do |contact|
      if contact.send(at) == sf
        contacts_true << contact
      end
    end
    if contacts_true.empty?
      puts "I'm sorry, but I couldn't find #{ sf } in the set of #{ at }."

    else
      contacts_true.each do |cc|
        cc.display
      end
    end

    return contacts_true
  end

  def display
    puts "ID: #{ id }, First Name: #{ first_name }, Last Name: #{ last_name }, Email: #{ email }, Note: #{ note }"
  end


end
