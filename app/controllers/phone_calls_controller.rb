class PhoneCallsController < ApplicationController
  before_action :authenticate_user!, except: [:callback, :conference]
  skip_before_action :verify_authenticity_token, only: [:callback, :conference]

  before_action :set_phone_call, only: [:show, :edit, :update, :destroy, :redial]
  before_action :check_for_phone_number
  before_action :authorize_call, only: [:redial, :create]
  # GET /phone_calls
  # GET /phone_calls.json
  def index
    @phone_calls = PhoneCall.where(user_id: current_user.id).
      group(:id, :to, :access_code).
      order(created_at: :desc).
      limit(5)
    @phone_call = PhoneCall.new
  end

  # GET /phone_calls/1
  # GET /phone_calls/1.json
  def show
  end

  # GET /phone_calls/new
  def new
    @phone_call = PhoneCall.new
  end

  # GET /phone_calls/1/redial
  def redial
    @new = PhoneCall.create(
        to: @phone_call.to,
        access_code: @phone_call.access_code,
        user_id: current_user.id,
        from: '+' + Rails.application.secrets.twilio_num.to_s
      )
    redirect_to phone_call_path(@new)
  end

  # POST /phone_calls
  # POST /phone_calls.json
  def create
    @phone_call = PhoneCall.new(phone_call_params)
    @phone_call.user_id = current_user.id
    @phone_call.from = '+' + Rails.application.secrets.twilio_num.to_s
    respond_to do |format|
      if @phone_call.save
        format.html { redirect_to @phone_call, notice: 'Phone call was successfully created.' }
        format.json { render :show, status: :created, location: @phone_call }
      else
        format.html { render :new }
        format.json { render json: @phone_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_calls/1
  # PATCH/PUT /phone_calls/1.json
  def update
    respond_to do |format|
      if @phone_call.update(phone_call_params)
        format.html { redirect_to @phone_call, notice: 'Phone call was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_call }
      else
        format.html { render :edit }
        format.json { render json: @phone_call.errors, status: :unprocessable_entity }
      end
    end
  end

  def conference
    # initiates conference

    @phone_call = PhoneCall.find_by_uuid(params[:uuid])
    @phone_call.update(status: params['CallStatus'])
    @phone_call.update(twilio_sid: params['CallSid']) if @phone_call.twilio_sid.nil?

    # build up a response
    response = Twilio::TwiML::Response.new do |r|
      r.Pause 1
      # r.Play 'https://' + Rails.application.secrets.domain_name + '/audio/ding2.mp3'
      r.Say 'Joining conference now', voice: 'man'
      r.Play 'https://' + Rails.application.secrets.domain_name + '/audio/ding1.mp3'
      r.Dial callerId: '+1'+@phone_call.user.phone, action: 'https://' + Rails.application.secrets.domain_name +
        '/phone_calls/' + @phone_call.uuid + '/callback'  do |d|
        # d.Number sendDigits: @phone_call.access_code+'#', '+1'+@phone_call.to
        d.Number '+1'+@phone_call.to, sendDigits: @phone_call.access_code + '#'
        d.Pause 1
        d.Play digits: '#'
      end
    end

    render xml: response.text
  end

  def callback
    # received after call
    @phone_call = PhoneCall.find_by_uuid(params[:uuid])
    @phone_call.update(
        duration: params['DialCallDuration'],
        status: params['DialCallStatus']
      )
    # {"AccountSid"=>"AC30c3b77fac162fe15a8aae3569b6ccb1", "ToZip"=>"94107", "FromState"=>"MD", "Called"=>"+15105164120", "FromCountry"=>"US", "CallerCountry"=>"US", "CalledZip"=>"94107", "Direction"=>"outbound-api", "FromCity"=>"BRANDYWINE", "CalledCountry"=>"US", "CallerState"=>"MD", "DialCallDuration"=>"105", "CallSid"=>"CA1e4a28ddd137dc4d7645c4282c44f4b7", "CalledState"=>"CA", "From"=>"+13015794120", "CallerZip"=>"20601", "FromZip"=>"20601", "CallStatus"=>"in-progress", "DialCallSid"=>"CAb3b0a806d403463a5a1266d43da60a69", "ToCity"=>"SAN FRANCISCO", "ToState"=>"CA", "To"=>"+15105164120", "ToCountry"=>"US", "DialCallStatus"=>"completed", "CallerCity"=>"BRANDYWINE", "ApiVersion"=>"2010-04-01", "Caller"=>"+13015794120", "CalledCity"=>"SAN FRANCISCO", "uuid"=>"7b11362f-3b7a-485c-acab-2545c8b6326c"}

    response = Twilio::TwiML::Response.new do |r|
      r.Pause 1
      r.Say 'Your conference call is ending now. Goodbye!', voice: 'man'
    end

    render xml: response.text
  end

  # DELETE /phone_calls/1
  # DELETE /phone_calls/1.json
  def destroy
    @phone_call.destroy
    respond_to do |format|
      format.html { redirect_to phone_calls_url, notice: 'Phone call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_call
      @phone_call = PhoneCall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_call_params
      params.require(:phone_call).permit(:to, :access_code, :scheduled_at)
    end

    def check_for_phone_number
      if user_signed_in? and current_user.phone.blank?
        flash[:notice] = 'Please provide your phone number to make calls.'
        redirect_to user_path and return 
      end
    end

    def authorize_call
      recent_calls = PhoneCall.where('user_id = ? and created_at > ?',
        current_user.id, Time.zone.now - 1.day)
      if recent_calls.size >= 5
        flash[:error] = 'Sorry, your account type is limited to 5 calls per day.'
        redirect_to root_url
      end
    end
end
