# Base class for all ActiveRecord models. Ensures common functionality.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
