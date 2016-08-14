class SessionsController < ApplicationController
  # before_filter :authorize

  def new
  end

  def create
     #we will be findng by other params
      patient = Patient.find_by_email(params[:email])
      # If the patient exists AND the password entered is correct.
      if patient && patient.authenticate(params[:password])
        # Save the patient id inside the browser cookie. This is how we keep the patient
        # logged in when they navigate around our website.
        session[:patient_id] = patient.id
        redirect_to patient_appointments_path(current_patient)
      else
      # If patient's login doesn't work, send them back to the login form.
        redirect_to '/login'
      end
    end

    def destroy
      session[:patient_id] = nil
      redirect_to '/login'
    end
end
