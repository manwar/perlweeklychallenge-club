#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    #
    # Parse input
    #
    if   line !~ /^([a-h])([1-8]) ([a-h])([1-8])$/
    then abort ("Cannot parse input")
    end

    #
    # Get the captures
    #
    f1, r1, f2, r2 = $1, $2, $3, $4

    #
    # Check parity
    #
    puts ((f1 . ord % 2 == r1 . ord % 2) ^
          (f2 . ord % 2 == r2 . ord % 2) ? "false" : "true")
}
