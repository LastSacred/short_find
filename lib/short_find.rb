require "short_find/version"

module ShortFind
  class Error < StandardError; end
  class ShortFind
    @@back = false
    @@exit = false

    def self.use_back(boolean)
      @@back = boolean
    end

    def self.use_exit(boolean)
      @@exit = boolean
    end

    def self.outs(boolean)
      @@back = boolean
      @@exit = boolean
    end

    def self.object(objects, attr=:name)
      attr = attr.to_s
      r_format = "first"
      loop do
        input = get_input
        return if !input && @@back

        result = objects.select do |object|
          object.public_send(attr).downcase.gsub('ú', 'u').gsub(/[^a-z0-9]/,'').start_with?(input.downcase.gsub(/[^a-z0-9]/,''))
        end

        output = test_result(result, r_format, attr)
        return output if output
      end
    end

    def self.in_array(array)
      r_format = "first"
      attr = "to_s"
      loop do
        input = get_input
        return if !input && @@back

        result = array.select do |element|
          element.downcase.gsub('ú', 'u').gsub(/[^a-z0-9]/,'').start_with?(input.downcase.gsub(/[^a-z0-9]/,''))
        end

        output = test_result(result, r_format, attr)
        return output if output
      end
    end

    def self.in_hash(hash, by=:value)
      by = by.to_s
      r_format = "to_h"
      attr = "last"
      loop do
        input = get_input
        return if !input && @@back

        result = hash.select do |key, value|
          if by == "key"
            attr = "first"
            key.to_s.downcase.gsub('ú', 'u').gsub(/[^a-z0-9]/,'').start_with?(input.downcase.gsub(/[^a-z0-9]/,''))
          elsif by == "value"
            value.downcase.gsub('ú', 'u').gsub(/[^a-z0-9]/,'').start_with?(input.downcase.gsub(/[^a-z0-9]/,''))
          end
        end

        output = test_result(result, r_format, attr)
        return output if output
      end
    end

    private

    def self.get_input
      input = gets.strip
      return if input == "back" && @@back
      exit if input == "exit" && @@exit
      input
    end

    def self.test_result(result, r_format, attr)
      if result.count == 0
        puts ""
        puts "No match found"
        puts "Try again"
      elsif result.count == 1
          return result.public_send(r_format)
      else
        puts ""
        puts "Multiple matches found"
        puts ""
        result.each do |result|
          puts result.public_send(attr)
        end
        puts ""
        puts "Try again"
      end
    end

  end
end
