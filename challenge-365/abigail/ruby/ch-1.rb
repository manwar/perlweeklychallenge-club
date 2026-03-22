#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    word, count = line . strip("\n") . split(" ")

    #
    # Calculate the first digit sum
    #
    digit_sum = 0
    word . each_char {
        |ch|
        ord = ch . ord - "a" . ord + 1
        digit_sum += (ord / 10) . floor + ord % 10
    }

    #
    # Repeatedly calculate the subsequent digit sums
    #
    (2 .. count . to_i) . each {
        ds = 0
        while digit_sum > 0
            ds       +=  digit_sum % 10
            digit_sum = (digit_sum / 10) . floor
        end
        digit_sum = ds
    }
    puts digit_sum
}
