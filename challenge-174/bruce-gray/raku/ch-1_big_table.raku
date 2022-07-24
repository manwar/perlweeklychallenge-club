# Observe that, if we cache the "sum of powers of digits" calculation for every prior number,
# then (for example) 8880..8889 is just the cached value of 888,
# plus (0⁴, 1⁴, 2⁴, 3⁴, 4⁴, 5⁴, 6⁴, 7⁴, 8⁴, 9⁴).
# Since those @powers_of_last_digits are constant for all 4-digit numbers,
# they can be calculated just once per "generation".

# This finds .head(19) 7x faster than the is-Disarium() in ch-1.raku !
# However, it will run out of memory trying to find .head(20) .
constant @Disarium = gather {
    my @all = 0..9;
    .take for @all;

    for 2..22 -> $number_length {
        my @powers_of_last_digits = (0..9) X** $number_length;

        my $to_skip2 = 10 ** ($number_length - 2);
        my $to_skip1 = 10 ** ($number_length - 1);

        @all.append: @all.skip($to_skip2) X+ @powers_of_last_digits;

        .take for @all.keys.skip($to_skip1).grep: { @all[$_] == $_ };
    }
};

say @Disarium.head(19);

use Test;
plan 1;
constant @A032799 = 0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798,12157692622039623539;
is @Disarium.head(@A032799.elems - 1), @A032799.head(*-1),
    'https://oeis.org/A032799 (without final element)';
