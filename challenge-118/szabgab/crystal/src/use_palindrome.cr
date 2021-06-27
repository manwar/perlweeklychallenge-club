require "./palindrome"

if ARGV.size == 0
  puts "Usage: #{PROGRAM_NAME} [NUMBERs]"
  exit 1
end

ARGV.each {|number|
  puts %[#{number} #{palindrome?(number.to_i) ? "Yes" : "No"}]
}
