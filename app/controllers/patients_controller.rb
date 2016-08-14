class PatientsController < ApplicationController
  # before_filter :authorize

  def new
  end

  def create
    patient = Patient.new(patient_params)
    patient_hash = PatientService.get_from_guid(patient.code)
    patient.email = patient_hash[:email]
    patient.first_name = patient_hash[:first_name]
    patient.last_name = patient_hash[:last_name]
    patient.phone = patient_hash[:phone]

    if patient.ssn == patient_hash[:ssn] && patient.save
      session[:patient_id] = patient.id
      redirect_to root_path
    else
      redirect_to '/signup'
    end
  end

def show
  @appointments = Appointment.find_by_patient_id(params[:id])
end

  private

  def patient_params
    # what are we getting from the form and what we are storing
    params.require(:patient).permit(:password, :password_confirmation, :code, :ssn)
  end


end
