#!/usr/bin/env raku

sub count-even-digits(@ints) {
    my $even-digits-count =  0;

    for @ints -> $num {
        if $num.Str.chars %  2 ==  0 {
            $even-digits-count++;
        }
    }

    return $even-digits-count;
}

# Assert tests
use Test;
is count-even-digits(10,  1,  111,  24,  1000),  3, "Test Case  1: Count of integers with even number of digits";
is count-even-digits(111,  1,  11111),  0, "Test Case  2: Count of integers with even number of digits";
is count-even-digits(2,  8,  1024,  256),  1, "Test Case  3: Count of integers with even number of digits";
done-testing;
