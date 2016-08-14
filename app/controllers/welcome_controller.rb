class WelcomeController < ApplicationController
  def home
  end

  def start_chat
    room = Room.find_by_sessionId(params[:session_id])
    appointment = room.appointment
    patient = appointment.patient
    redirect_to patient_appointment_path(patient, appointment)
  end
end
