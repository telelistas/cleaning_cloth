require 'activerecord'
class ActiveRecord::Base

  unless self.method_defined? 'clean_attributes!'
    
    def clean_attributes! opts={}
      opts[:except] = Array(opts[:except]) + [:id, :create_at, :updated_at]
      
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
          assoc_name = obj.name.to_sym
          next if opts[:except].include?(assoc_name) || !obj.respond_to?(assoc_name)
          obj_opts = opts.deep_fetch(:include, assoc_name)
          obj.clean! obj_opts
        end
      end

      self
    end

  end
  
end