# https://perlweeklychallenge.org/blog/a-new-week-a-new-challenge/
# Challenge #2
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1 through 20.
# However, any number divisible by 3 should be replaced by the word ‘fizz’ and any divisible by 5
# by the word ‘buzz’. Those numbers that are both divisible by 3 and 5 become ‘fizzbuzz’.


perl -e '
    map {
        print (
            (!($_ % 15)
                ? "fizzbuzz"
                : !($_ % 3)
                    ? "fizz"
                    : !($_ % 5)
                        ? "buzz"
                        : $_)
            . "\n"
        )
    } (1..20)
'

perl -e '
    map {
        print (
            (!($_ % 15)
                ? "fizzbuzz" : ""
            .!($_ % 3)
                ? "fizz" : ""
            .!($_ % 5)
                ? "buzz" : ""
            . $_)
            . $/
        )
    } (1..20)
'


perl -e '
    print join $/, map {
        my $d = $_;
        $_ = "fizz" unless ($d % 3);
        $_ = "buzz" unless ($d % 5);
        $_ = "fizzbuzz" unless ($d % 15);
        $_
    } (1..20)
'
