#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    puts /(.).?\1|(.)(.).*\3\2/ . match(line) ? "true" : "false"
}
