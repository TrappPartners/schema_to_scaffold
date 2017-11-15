module SchemaToScaffold
  class Attribute

    attr_reader :name, :type

    def initialize(name, type)
      @name, @type = name, type
    end

    def to_script
      "#{name}:#{type}" unless ["created_at","updated_at"].include?(name)
    end

    def self.parse(attribute)
      match = attribute.match(/t\.(\w+)\s+"(\w+)"/)
      if match
        is_user = match.captures[1].sub(/_id$/, "") == "user"
        if is_user
          name = match.captures[1].sub(/_id$/, "")
          type = "references"
        else
          name = match.captures[1]
          type = match.captures[0]
        end
        Attribute.new(name, type)
      end
    end

  end
end
