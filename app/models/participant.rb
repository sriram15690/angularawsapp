class Participant < ActiveRecord::Base
  belongs_to :contact
  require 'csv'
  require 'roo'
  require 'spreadsheet'
  require 'fileutils'
  #require 'iconv'
    require "prawn"
  
   #accepts_nested_attributes_for :contacts, :allow_destroy => false
  
  def self.excel_participants_import
    spreadsheet =  Roo::Spreadsheet.open('./public/Rudrabhishekam_MAster_Books_List.xlsx', extension: :xlsx)
    header = spreadsheet.row(1) # Reading First row to get column names.
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      participant =  Hash[[header, spreadsheet.row(i)].transpose]
      #Creating a hash of header-row columns as keys and data-row columns as values.
      new_participant = Participant.new(sankalpam_name: participant["SHORTNAME"], :address1 => participant["ADD1"],:address2 => participant["ADD2"],:pincode => participant["PINCODE"],
      :city => participant["ADD3"],:nakshatram => participant["STAR"],:state => participant["STATE"], :gothram => participant["GOTHRAM"],
      :renewal_date => (Date.parse(participant["DUEDT"]) rescue Date.today), :rasi => participant["RASI"], :receipt_num => participant["RNO"], :receipt_date => (Date.parse(participant["RDT"]) rescue Date.today), :telephone => participant["TELE"], 
      :title_name => participant["TITLE"], :roll_num => participant["SNO"],:email => participant["EMAIL"],:mobile_num => participant["MOBILE"])
      new_participant.save!
    end
  end
  
  def  self.generate_distribution_list(list_type)
    spreadsheet = StringIO.new 
    Spreadsheet.client_encoding = 'UTF-8'
    participants = Participant.limit(10)
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => 'Distribution List'
    sheet.column(0).width = 20
    sheet.column(1).width = 40 
    sheet.column(2).width = 40
    sheet.column(3).width = 60 
     sheet.row(0).replace ["Roll Num","sankalpam_name","name","Reference Name","Renewal Date"]
    participants.each_with_index  { |participant, i|
       sheet.row((i+1)).replace [participant.roll_num,participant.sankalpam_name,participant.name,participant.reference_name,participant.renewal_date.strftime("%d/%m/%Y")]
    }  
     
    sankalpam_sheet = book.create_worksheet :name => 'Sankalpam List'
    sheet.column(0).width = 20
    sheet.column(1).width = 40 
    sheet.column(2).width = 20
    sheet.column(3).width = 40 
     sheet.row(0).replace ["Roll Num","Gothram","Nakshatram","Rasi","Sankalpam Name"]
    participants.each_with_index  { |participant, i| 
       sankalpam_sheet.row(i).replace [participant.roll_num,participant.gothram,participant.nakshatram,participant.rasi,participant.sankalpam_name]
    }  
    
   format = Spreadsheet::Format.new :color => :blue,
                                 :weight => :bold,
                                 :size => 18
   book.write spreadsheet
   return spreadsheet.string
  end
  
  

  def self.pdf_doc_generator
      
  end
  
  
end

