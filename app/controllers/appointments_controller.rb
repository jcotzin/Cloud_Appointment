class AppointmentsController < ApplicationController
  before_filter :authorize

  def new
    @appointment = Appointment.new
  end

  def create
    @new_room = Room.new
    @appointment = Appointment.create(appointment_params)
    @appointment.patient_id = current_patient.id
    if @appointment.save
      AppointmentService.create_appointment(@appointment)
      @new_room.sessionId = session.id
      redirect_to appointments_path
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @appointments = Appointment.all
  end

  private
    def appointment_params
      params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :provider_id, :patient_id)
    end
end
