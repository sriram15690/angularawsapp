class ParticipantsController < ApplicationController

  before_filter :authenticate_user!
  def index
    @participants = Participant.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {results: @participants }}
    end
  end

  def get_all_participants
    @participants = Participant.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {results: @participants }}
    end
  end
  
  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  def create
    @participant  = Participant.new(participant_params)
    @participant.status  = "Active"
    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render json: @participant , status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end
  
   # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @participant = Participant.find(params[:id])
    respond_to do |format|
      if @participant.update_attributes(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render json: @participant }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end
  
   # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to participants_path }
      format.json { head :no_content }
    end
  end

  def generate_rudram_report
    #  raise params.inspect
    respond_to do |format|
      format.xlsx do
      #{send_data Participant.generate_distribution_list, filename: 'excel-file.xls'}
      #send_file "#{Rails.root}/public/excel-file.xls"
        send_data Participant.generate_distribution_list(params[:list_type]), :filename => "yourfile.xls", :type =>  "application/vnd.ms-excel"
      end
    end
  end

  def generate_letters
    #  raise params.inspect
    pdf = Prawn::Document.new
    participants = Participant.limit(10)
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
      puts (Date.today + 3.months).inspect
      puts  participant.renewal_date
      puts (Date.today + 3.months) > participant.renewal_date
      if( (Date.today + 3.months) > participant.renewal_date )
        pdf.text " We bring to your kind notice that your Sankalpa Ubhayam is due for renewal from #{participant.renewal_date.strftime("%d/%m/%Y")}", :align => :left, :size => 12
        pdf.move_down 7
      end
      pdf.text " Please favour us with Rs.#{params[:annual_fees]}/-(ø) by cash or cheque.", :align => :left, :size => 12
      pdf.move_down 7
      pdf.text "If you have already renewed, please ignore this letter.", :align => :left, :size => 12
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
    send_file filename, :filename => "x.pdf", :type => "application/pdf"
  end
  private

  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def participant_params
    params.require(:participant).permit(:address1,:address2, :city, :pincode, :state, :gothram, :nakshatram, :rasi, :reference_name, :roll_num, :receipt_num,:receipt_date , :renewal_date, :status, :title_name ,:telephone,:sno, :contact_id)
  end
end
