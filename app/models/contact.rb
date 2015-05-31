class Contact < ActiveRecord::Base
  require 'csv'
  require 'roo'
  require 'spreadsheet'
  require 'fileutils'

  #attr_accessible :city, :membership, :mobile_num, :name,:email, :status
  
  validates :mobile_num, :uniqueness => {:message => "already Exists in Our Database."} 
  
  after_create :send_application_acceptance_email
 
  def send_application_acceptance_email
    if !self.email.blank?
      SamajamMailer.registrationMail(self).deliver!
    end
  end
  
  def excel_import
    spreadsheet =  Roo::Spreadsheet.open('./public/samajam_mobile_numbers.ods', extension: :ods)
    header = spreadsheet.row(1) # Reading First row to get column names.
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      contact=  Hash[[header, spreadsheet.row(i)].transpose] 
      #Creating a hash of header-row columns as keys and data-row columns as values.
      new_contact = Contact.new(mobile_num: contact["MobileNumber"].round, name: contact["Name"], status: "Active", city: "Hyderabad", membership: "Not Available" )
      new_contact.save!
    end
  end
  
  def excel_participants_import
    spreadsheet =  Roo::Spreadsheet.open('./public/samajam_rudrabhishekam_list.xlsx', extension: :xlsx)
    header = spreadsheet.row(1) # Reading First row to get column names.
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      participant =  Hash[[header, spreadsheet.row(i)].transpose]
      
      address 
      #Creating a hash of header-row columns as keys and data-row columns as values.
      new_participant = Participant.new(sankalpam_name: participant["SHORTNAME"], :address => participant["ADD1"],:pincode => participant["PINCODE"],:gothram => participant["GOTHRAM"],:rasi => participant["RASI"])
      new_participant.save!
    end
  end
  
end
