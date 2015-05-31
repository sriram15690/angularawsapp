class EventsController < ApplicationController
  def getExistingEvents
      @events = Event.all
      respond_to do |format|
       format.html # index.html.erb
        format.json { render json:  @events}
    end
  end
  
  def getEventInstances
    @eventsInstances = Eventinstance.where(:event_id => params[:id])
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json:  @eventsInstances}
    end
  end
  
  def generate_letters
    #  raise params.inspect
    pdf = Prawn::Document.new
    participants = Participant.where(:roll_num => params[:prasadam_list].split(",") )
    participants.each do |participant|
      pdf.move_down 5
      pdf.text "SRI SUBRAMANIA SAMAJAM (Regd.)", :align => :center, :size => 14
      pdf.move_down 5
      pdf.text "SUVARNA JAYANTHI MANDAPAM, 2-2-744/19/B,", :align => :center, :size => 12
      pdf.move_down 5
      pdf.text "NEW NALLAKUNTA, HYDERABAD - 500 044.", :align => :center, :size => 12
      pdf.move_down 5
      pdf.text "Phone: 040-27563963 Mobile: +91-9441884475(Sec.),9571089466(Manager)", :align => :center, :size => 12
      pdf.move_down 5
      pdf.text "Email : subramaniasamajam50@yahoo.co.in", :align => :center, :size => 12
      pdf.move_down 5
      pdf.text "Date #{params[:letter_date]}", :align => :right, :size => 12
      pdf.move_down 20
      pdf.text "#{participant.title_name} #{participant.sankalpam_name},", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "#{participant.address1},", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "#{participant.address2}", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "#{participant.city}", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "#{participant.state} - #{participant.pincode}", :align => :left, :size => 12
      pdf.move_down 20
      pdf.text "Dear #{participant.sankalpam_name},", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "Thank you very much for your continued sponsorship for Annual Rudrabhisheka Sankalpa Scheme.", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "Rudrabhishekam was performed on #{params[:current_event]}.We enclose the prasadam herewith.", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "Next Rudrabhishekam under this scheme is scheduled on #{params[:next_event]}.", :align => :left, :size => 12
      pdf.move_down 7
      if( (Date.today + 3.months) > participant.renewal_date )
        pdf.text " We bring to your kind notice that your Sankalpa Ubhayam is due for renewal from #{participant.renewal_date.strftime("%d/%m/%Y")}", :align => :left, :size => 12
        pdf.move_down 7
        pdf.text " Please favour us with Rs.#{params[:annual_fees]}/-(ø) by cash or cheque.", :align => :left, :size => 12
        pdf.move_down 7
        pdf.text "If you have already renewed, please ignore this letter.", :align => :left, :size => 12
      end
      pdf.move_down 15
      pdf.text " Thanking you,", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "for SRI SUBRAMANIA SAMAJAM (Regd.)", :align => :left, :size => 12
      pdf.move_down 15
      pdf.text " (ø)Revised w.e.f. #{params[:fees_revised_on]}", :align => :left, :size => 12
      pdf.start_new_page
    end
    filename = File.join(Rails.root, "public", "x.pdf")
    pdf.render_file filename
    send_file filename, :filename => "#{params[:current_event]}_Prasadam_List.pdf", :type => "application/pdf"
  end
  
end
