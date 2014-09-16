# encoding: utf-8
require 'active_record'

class ActiveRecord::Base

  unless self.method_defined? 'clean!'
 
    def clean! opts=nil

        opts ||= default_clean_options
        opts[:max_level] ||= 3
        return if opts[:max_level] <= 0
      
        exceptions = Array(opts[:except] || []) + [:id, :create_at, :updated_at]
        includes = Array(opts[:includes] || []) # includes, caso queira incluir os campos excluidos por padrão: :id, :created_at e etc
        exceptions.reject! {|item| includes.include?(item) }

        all_attributes = self.attributes || {}

        all_associations = self.class.reflect_on_all_associations.map &:name
        all_associations.reject! {|item| exceptions.include?(item)}

        all_associations.each do |assoc_name|
          data = self.send(assoc_name)
          next unless data.present?
          Array(data).each do |obj|
            obj_opts = opts.deep_fetch(assoc_name, {}) 
            obj_opts[:max_level] = opts[:max_level] - 1
            obj.clean! obj_opts 
          end
        end

        all_attributes.each do |attr_name, attr_value|          
          attr_name = attr_name.to_sym
          next if exceptions.include?(attr_name) && attr_value == self.send(attr_name)
          value = exceptions.include?(attr_name) ? attr_value : nil
          self.send("write_attribute", attr_name, value) 
        end
        
        self

    end # clean!

    def default_clean_options
      {}
    end

  end 
end
  

