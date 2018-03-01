require 'pesel'

class PeselValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || :invalid_pesel) unless Pesel.new(value).valid?
  end
end