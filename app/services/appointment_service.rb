class AppointmentService
  HEADER = {"Authorization"=>"Bearer #{ENV['CC_ACCESS_TOKEN']}"}
  END_POINT = "https://external-api-gateway.development.carecloud.com/v2".freeze

  def self.create_appointment(appointment)
    appointment_poster = new(appointment)
    appointment_poster.post_appointment
  end

  attr_reader :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def appointment_params
    {
        "appointment" => {
            "appointment_status_id" => "1",
            "start_time" => "#{appointment.start_time.to_time + 4.hours}",
            "end_time" => "#{appointment.end_time.to_time + 4.hours}",
            "location_id" => "19669",
            "provider_id" => "17138",
            "visit_reason_id" => "54562",
            "resource_id" => "16627",
            "patients" => [{
                             "id" => "#{appointment.patient.code}",
                             "comments" => "#{appointment_link}"
                         }]
        }
    }
  end

  def appointment_link
    "https://cloud-appointments.herokuapp.com/provider/start/#{appointment.room.sessionId}"
  end

  def post_appointment
    HTTParty.post("#{END_POINT}/appointments", {headers: HEADER, body: appointment_params.to_json})
  end


end
