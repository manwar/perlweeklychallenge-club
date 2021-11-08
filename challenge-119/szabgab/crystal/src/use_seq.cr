require "./seq"

if ARGV.size != 1
  abort("Usage: #{PROGRAM_NAME} NUM", 1)
end

puts seq(ARGV[0].to_i)
