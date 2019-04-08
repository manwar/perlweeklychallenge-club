use strict;
use warnings;
use 5.10.0;
sub is_hamming { 
    my $num =shift;
    $num = $num / 2 while $num % 2 == 0 ;
    $num = $num / 3 while $num % 3 == 0 ;
    $num = $num / 5 while $num % 5 == 0 ;
    return $num == 1;
}
# this func checks if the number is a hamming number 
# a humming number is a number of the form 
#of the form 
#H = 2^i x 3^j x 5^k
#Where i, j, k ≥ 0
# also is a  5-smooth number as none of its prime factors is greater than 5
# for ex : 18 = 2^1 * 2^3 * 5^0 so it is a hamming number 
# but 42 equals  2^1 * 3^1 * 7^1
# so it's not a hamming number
# we simply check if it's a hamming number in the `is_hamming` fuc. by checking it's prime factors 
sub hamming_seq {
     for (1..$_[0]){say $_ if is_hamming($_)}
}
hamming_seq(20);
# gives all hamming numbers in the range 1..20
