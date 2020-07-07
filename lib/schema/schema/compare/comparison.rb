module Schema
  module Compare
    class Comparison
      include Initializer

      Error = Class.new(RuntimeError)

      Entry = Struct.new(
        :control_attr_name,
        :control_value,
        :compare_attr_name,
        :compare_value
      )

      def entries
        @entries ||= []
      end

      #def attr_names
      #  @attr_names ||= control_attributes.keys
      #end
      #attr_writer :attr_names

      #initializer :entries

      def self.build(control_attributes, compare_attributes, attr_names)
      #def self.build(control, compare, attr_names=nil)
        instance = new

        attr_names.each do |attr_name|
          entry = build_entry(attr_name, control_attributes, compare_attributes)
          instance.entries << entry
        end

        instance
      end

      def self.build_entry(attr_name, control_attributes, compare_attributes)
        control_value = control_attributes[attr_name]
        compare_value = compare_attributes[attr_name]

        entry = Entry.new(
          attr_name,
          control_value,
          attr_name,
          compare_value
        )

        entry
      end

      def entry(attr_name)
        entries.find do |entry|
          entry.control_attr_name == attr_name
        end
      end
      alias :[] :entry

      def add(control_attr_name, control_value, compare_attr_name, compare_value)
        entry = Entry.new(
          control_attr_name,
          control_value,
          compare_attr_name,
          compare_value
        )

        entries << entry

        entry
      end

      def different?(attr_name)
        entry = self[attr_name]

        if entry.nil?
          raise Error, "No attribute difference entry for #{attr_name.inspect}"
        end

        #entry.different?
        entry.control_value != entry.compare_value
      end
    end
  end
end
