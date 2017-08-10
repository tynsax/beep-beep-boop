json.array!(@phones) do |phone|
  json.extract! phone, :id, :user_id, :name, :icon, :number, :confirmed_at
  json.url phone_url(phone, format: :json)
end
