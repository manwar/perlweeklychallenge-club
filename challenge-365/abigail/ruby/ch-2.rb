#!/opt/homebrew/opt/ruby/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-365
#
 
ARGF . each_line {
    |line|
    valid = 0
    line . strip() . split(" ") . each {
        |token|
        if token =~ /^([a-z]+(-[a-z]+)?)?[!,.]?$/
            valid = valid + 1
        end
    }
    puts valid
}
