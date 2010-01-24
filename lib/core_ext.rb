class Hash
  # Returns a hash that represents the difference between two hashes.
  #
  # Examples:
  #
  #   {1 => 2}.diff(1 => 2)         # => {}
  #   {1 => 2}.diff(1 => 3)         # => {1 => 2}
  #   {}.diff(1 => 2)               # => {1 => 2}
  #   {1 => 2, 3 => 4}.diff(1 => 2) # => {3 => 4}
  def diff(h2)
    self.dup.delete_if { |k, v| h2[k] == v }.merge(h2.dup.delete_if { |k, v| self.has_key?(k) })
  end unless self.new.respond_to?(:diff)
end

class Numeric
  # Turns a numneric value into an ordinal string used to denote the position in an
  # ordered sequence such as 1st, 2nd, 3rd, 4th.
  #
  # Examples:
  # 1.ordinalize # => "1st"
  # 2.ordinalize # => "2nd"
  # 1002.ordinalize # => "1002nd"
  # 1003.ordinalize # => "1003rd"
  def ordinalize
    number = self.to_i
    if (11..13).include?(number % 100)
      "#{number}th"
    else
      case number.to_i % 10
        when 1; "#{number}st"
        when 2; "#{number}nd"
        when 3; "#{number}rd"
        else "#{number}th"
      end
    end
  end unless self.new.respond_to?(:ordinalize)

end