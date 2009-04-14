module ResourcefulParenting; module ActionController; module Base;

  def self.included(klass)
    klass.class_eval do
      include InstanceMethods
      helper_method :polymorphic_p_url, :polymorphic_p_path
    end
    super
  end

  module InstanceMethods

    #
    # Analogous to Rails' polymorphic_url, but add all parents to call
    #
    def polymorphic_p_url(record_or_hash_or_array, options = {})
      record_or_hash_or_array = [record_or_hash_or_array] unless record_or_hash_or_array.is_a?(Array)
      record_or_hash_or_array = parents + record_or_hash_or_array
      polymorphic_url(record_or_hash_or_array, options)
    end

    #
    # Analogous to Rails' polymorphic_path, but add all parents to call
    #
    def polymorphic_p_path(record_or_hash_or_array, options = {})
      polymorphic_p_url(record_or_hash_or_array, options.merge(:routing_type => :path))
    end

    #
    # Returns an array of parent objects
    #
    def parents
      parse_parents.map do |info|
        instance_from_parent_info(info)
      end
    end

    #
    # Returns a parent object extracted from a nested URL
    # Takes an array index of depth (how far up parents to get) - defaults to -1 (most immediate)
    # Returns nil if no such parent exists
    #
    def parent(level = -1)
      info = parse_parents[level]
      instance_from_parent_info(info)
    end

    private

    #
    # Returns an array of hashes
    # Each hash is an info block (opaque as far as you're concerned) about a single parent in the lineage
    #
    def parse_parents

      if !@_parents_info

        #
        # Populate @_parents_info
        #
        @_parents_info = []
        request.path_parameters.each do |key, value|
          next unless key =~ /^(.+)_id$/
          singular = $1.singularize
          @_parents_info << {
            :order    =>  nil,
            :singular =>  singular,
            :class    =>  singular.classify.constantize,
            :id       =>  value,
            :instance =>  nil
          }
        end

        #
        # Properly sort it
        #
        path_parts = request.path.split("/")
        path_parts.each_with_index do |part, i|
          next unless part =~ /^[a-z_]+$/
          singular = part.singularize or next
          info = @_parents_info.detect{|p| p[:singular] == singular}
          info[:order] = i if info
        end
        @_parents_info = @_parents_info.sort_by{|i| i[:order]}

      end

      return @_parents_info

    end

    def instance_from_parent_info(info)
      return nil unless info
      if !info[:instance]
        if info[:class].respond_to?(:from_param)
          info[:instance] = info[:class].from_param(info[:id])
        else
          info[:instance] = info[:class].find(info[:id])
        end
      end
      info[:instance]
    end

  end # module InstanceMethods

end;end;end

ActionController::Base.class_eval do
  include ResourcefulParenting::ActionController::Base unless include?(ResourcefulParenting::ActionController::Base)
end
