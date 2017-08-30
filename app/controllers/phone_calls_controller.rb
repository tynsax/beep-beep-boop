class PhoneCallsController < ApplicationController
  before_action :authenticate_user!, except: [:callback, :conference]
  skip_before_action :verify_authenticity_token, only: [:callback, :conference]

  before_action :set_phone_call, only: [:show, :edit, :update, :destroy, :redial]
  before_action :check_for_phone_number
  before_action :authorize_call, only: [:redial, :create]

  FREE_CONF_LINES = ['+16417153300'].freeze

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
    @phone_call.update(status: params['CallStatus'],
                       answered_by: params['AnsweredBy'],
                       twilio_sid: params['CallSid'])

    send_digits = @phone_call.access_code.gsub(/\#$/, '') + '#'
    send_digits = 'wwww' + send_digits + '1w#' if FREE_CONF_LINES.include?(@phone_call.to)
    # build up a response
    response = Twilio::TwiML::Response.new do |r|
      # r.Play 'https://' + Rails.application.secrets.domain_name + '/audio/ding8.mp3'
      r.Say 'Connecting you now', voice: 'alice'

      # r.Play 'https://' + Rails.application.secrets.domain_name + '/audio/ding1.mp3'
      r.Dial callerId: @phone_call.user.phone, action: 'https://' + Rails.application.secrets.domain_name +
                                                       '/phone_calls/' + @phone_call.uuid + '/callback' do |d|
        
        # d.Play 'https://' + Rails.application.secrets.domain_name + '/audio/ding1.mp3'
        d.Number @phone_call.to, sendDigits: send_digits
        d.Pause 1
        
        d.Play digits: '#'
      end
    end

    render xml: response.text
  end

  def callback
    # received after call
    logger.info "params " + params.inspect

    @phone_call = PhoneCall.find_by_uuid(params[:uuid])
    @phone_call.update(
        duration: params['DialCallDuration'],
        status: params['DialCallStatus']
      )

    response = Twilio::TwiML::Response.new do |r|
      r.Pause 1
      r.Say 'Your conference call is ending now. Goodbye!', voice: 'alice'
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
        flash[:error] = 'Please provide your phone number to make calls.'
        redirect_to user_path and return 
      end
    end

    def authorize_call
      unless current_user.remaining_calls_today?
        flash[:error] = "Sorry, your membership level is limited to " \
                        "#{current_user.membership_level.daily_call_limit} " \
                        "calls per day."
        redirect_to root_url
      end
    end
end
