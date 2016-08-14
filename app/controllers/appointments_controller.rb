class AppointmentsController < ApplicationController
  before_filter :authorize

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.create(appointment_params)
    @appointment.patient_id = current_patient.id
    session = opentok.create_session
    new_room = Room.new
    new_room.sessionId = session.session_id
    new_room.save
    @appointment.room_id = new_room.id
    if @appointment.save
      AppointmentService.create_appointment(@appointment)
      redirect_to appointments_path
    else
      render 'new'
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @token = opentok.generate_token @appointment.room.sessionId
  end

  def index
    @appointments = Appointment.all
  end

  private

    def opentok
      @opentok ||= OpenTok::OpenTok.new ENV["TOKAPI"], ENV["TOKSECRET"]
    end

    def appointment_params
      params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :provider_id, :patient_id)
    end
end
