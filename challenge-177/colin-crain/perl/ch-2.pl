#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       primetime-one-eye.pl
#
#       Palindromic Prime Cyclops
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Palindromic Prime Cyclops
#         Numbers.
# 

#         A cyclops number is a number with an odd number of digits that
#         has a zero in the center only.
# 
# 
#         Output
#         101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
#         1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
#         1360631, 1390931, 1490941, 1520251
# 
#       Analysis:
# 
#         This is a good problem to solve constructivly rather than
#         mathematically.
#         
#         lets divide it into 3 cases, for each odd number of digits. For
#         each class it is straightforward to calculate the constraints on
#         every solution that can exist. 
#         
#         One Digit: (one number)
#         
#             0
#         
#         Three Digits: (nine numbers)
#         
#             x0x     | 0 < x ≤ 9
#         
#         Five Digits: (ninety numbers)
#         
#             xy0yx   | 0 < x ≤ 9
#                     | 0 ≤ y ≤ 9

#         For each class we observe the ordering is entirely determined by
#         the left-hand side of the number, and
# 
#         Furthermore, there will only be one palindromic number created
#         for each left-hand side, so the mirrored right-hand side is
#         therefore inconsequential to the ordereing.
# 
#         Essentally we get an ordered lst of palindromes by counting
#         incrementally upwards from the smallest valid left-hand component
#         annd then concatenating a 0 followed by the reverse of the seed
#         value. The furthest left digit will be in the range 1-9 and all
#         others 0-9.
# 
#         One additional constraint is added by the primality criteium.
#         Because the right side is the left reversed, we note the last
#         digit must be odd, so therefore the first must be the same. This
#         limits the leftmost digit to the odd numbers. 
        
        
        
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


use ntheory qw( is_prime );

my @out;
my $tail_digits = 0;

while ( @out < 200 ) {
    for my $head ( 1, 3, 5, 7, 9 ) {
        my $start = "0" x $tail_digits;
        my $end   = "9" x $tail_digits;
        for my $tail ($start .. $end) {
            my $candidate =  "$head$tail" . 0 . reverse "$head$tail";
            push @out, $candidate if is_prime( $candidate );
        }
    }
    $tail_digits++;
}


say for @out;


