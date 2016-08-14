class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_patient
    @current_patient ||= Patient.find(session[:patient_id]) if session[:patient_id]
  end
  helper_method :current_patient

  def logged_in?
    current_patient
  end
  helper_method :logged_in?

  def authorize
    redirect_to '/login' unless current_patient
  end


end
