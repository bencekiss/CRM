require './crm.rb'
require './contact.rb'


Contact.create("Bence", "Kiss", "bence@mail.com", "note")
Contact.create("Mina", "Mikhail", "mina@bitmaker.com", "instructor")
Contact.create("Joe", "Black", "incoming@mail.nl", "nothing to note")
Contact.create("Eddard", "Stark", "ihavenomail@winterfell.gb", "The winter is coming")



crm = CRM.new
crm.main_menu
