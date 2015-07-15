json.array!(@phone_calls) do |phone_call|
  json.extract! phone_call, :id, :to, :from, :duration, :access_code, :result
  json.url phone_call_url(phone_call, format: :json)
end
