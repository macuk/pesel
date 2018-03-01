require 'active_model'

class Model
  include ActiveModel::Validations

  attr_accessor :field
end
