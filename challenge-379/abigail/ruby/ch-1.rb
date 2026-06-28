#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    1 while (line . sub!(/(.)(\n.*)/, '\2\1'))
    puts line . sub(/\n/, "")
}
