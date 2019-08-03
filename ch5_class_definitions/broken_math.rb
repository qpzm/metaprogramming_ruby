class Integer
  alias_method :old_plus, :+

  def +(n)
    old_plus n
    .old_plus 1
  end
end

puts 1 + 1
