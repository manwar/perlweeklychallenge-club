#!/usr/bin/env perl6
#
#
#       the-weight-of-ham.raku
#
#         Higher Integer Set Bits
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
# 
#         Write a script to find the next higher integer having the same number
#         of 1 bits in binary representation as $N.
# 
#             Example
#             
#             Input: $N = 3
#             Output: 5
# 
#                 Binary representation of $N is 011. There are two 1 bits. So
#                 the next higher integer is 5 having the same the number of 1
#                 bits i.e. 101.
# 
#             Input: $N = 12
#             Output: 17
# 
#                 Binary representation of $N is 1100. There are two 1 bits. So
#                 the next higher integer is 17 having the same number of 1 bits
#                 i.e. 10001.
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Int $num where $num > 1 = 127) ;

say next_hamming_weight( $num );

sub next_hamming_weight( $num ) {
    my $trip = trip_carry($num);
    return $trip + ones( hamming($num) - hamming($trip) );
    
    sub ones ($count)  { 2**$count - 1 }
    sub hamming ($num) { $num.base(2)
                             .comb
                             .sum   }
}

sub trip_carry ($num) {
## given a number, trip the carry on the lowest significant set bit
## 10101000 -> 10110000
    my $ls   = lowsig($num);
    my $trip = 2**$ls;
    return $num + $trip;
    
    sub lowsig ($num is copy, $pos is copy = 0 ) {
    # returns lowest significant set bit position, 0-based
        until $num +& 1 { 
            $num +>= 1;
            $pos++;
        }
        $pos;
    }
}



