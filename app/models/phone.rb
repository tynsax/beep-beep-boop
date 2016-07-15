class Phone < ActiveRecord::Base
  belongs_to :user

  phony_normalize :numbers, :default_country_code => 'US'
  validates_plausible_phone :number, :normalized_country_code => 'US'
end
