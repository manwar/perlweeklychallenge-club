def palindrome?(n : Int32)
  raise ArgumentError.new("Negative number not accepted") if n < 0
  binary = sprintf("%b", n)
  return binary == binary.reverse
end
