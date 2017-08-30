memberships = { free: 5, premium: nil }

memberships.keys.each do |level_name|
	record = MembershipLevel.find_or_create_by(name: level_name.capitalize)
	record.update(daily_call_limit: memberships[level_name])
end
