#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    (n1, n2, sum) = line . strip() . tr('a-j', '0-9') 
                         . split(" ") . map {|x| x . to_i}
    puts (n1 + n2 == sum ? "true" : "false")
}
