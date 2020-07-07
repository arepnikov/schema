module Schema
  module Controls
    module AttributeDifferences
      def self.example
        differences = ::Schema::Compare::Difference::Attributes.new

        differences.add(
          Entry.attr_name,
          Entry.control_value,
          Entry.attr_name,
          Entry.compare_value
        )

        differences
      end

      module Entry
        def self.attr_name
          Attribute::Name.some_attribute
        end

        def self.control_value
          Attribute::Value.some_attribute
        end

        def self.compare_value
          Attribute::Value::Alternate.example
        end
      end

      module Mapped
        def self.example
          differences = ::Schema::Compare::Difference::Attributes.new

          differences.add(
            Entry.control_attr_name,
            Entry.control_value,
            Entry.compare_attr_name,
            Entry.compare_value
          )

          differences
        end

        module Entry
          def self.control_attr_name
            Attribute::Name.some_attribute
          end

          def self.control_value
            Attribute::Value.some_attribute
          end

          def self.compare_attr_name
            Attribute::Name.some_other_attribute
          end

          def self.compare_value
            Attribute::Value.some_other_attribute
          end
        end
      end
    end
  end
end
