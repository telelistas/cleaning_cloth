require 'active_record'

class ActiveRecord::Base

  unless self.method_defined? 'clean!'
    
    def clean! opts={}
      byebug
      define_non_cyclic_method(:jaca) {
      #return if self.instance_variable_get('@lock_clean')
      #begin
        #self.instance_variable_set('@lock_clean',true)
        opts ||= {}
        opts[:except] = Array(opts[:except] || []) + [:id, :create_at, :updated_at]
      
        all_attributes = self.instance_variable_get('@attributes')
        opts[:include] = opts[:include] || Array(all_attributes)

        all_attributes.each do |attr_name, attr_value|          
          attr_name = attr_name.to_sym
          self.send("write_attribute", attr_name, nil) unless opts[:except].include? attr_name
        end

        all_associations = self.class.reflect_on_all_associations.map &:name
        all_associations.each do |assoc_name|
          data = self.send(assoc_name)
          next unless data.present?
          Array(data).each do |obj|
            assoc_name = obj.class.name.downcase.to_sym
            next if opts[:except].include?(assoc_name) 
            obj_opts = opts.deep_fetch(:include, assoc_name)
            obj.clean! obj_opts 
          end
        end

        self
      }
      #ensure
       # self.instance_variable_set('@lock_clean',false)
      #end
#protected

    end # unless
        def define_non_cyclic_method(name, &block)
          return if self.method_defined?(name)
          define_method(name) do |*args|
            result = true; @_already_called ||= {}
            # Loop prevention for validation of associations
            unless @_already_called[name]
              begin
                @_already_called[name]=true
                result = instance_eval(&block)
              ensure
                @_already_called[name]=false
              end
            end

            result
          end
        end      
  end 
end
  

