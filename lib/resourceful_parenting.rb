module ResourcefulParenting

  module ActionController; module Base;

    def self.included(klass)
      klass.class_eval do
        include InstanceMethods
      end
      super
    end

    module InstanceMethods

    end

  end;end

end

ActionController::Base.class_eval do
  include ResourcefulParenting::ActionController::Base unless include?(ResourcefulParenting::ActionController::Base)
end
