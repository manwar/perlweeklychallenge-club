#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       the-weight-of-ham.pl
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
#         method:
#             We could brute force this, by creating a popcount() function and
#             incrementing until we circle around again. This sounds boring for
#             large numbers but I reserve the right to fall back on it.
# 
#             Mathematically, the number of 1s in a binary representation, or
#             population count, is known as the Hamming weight, or perhaps more
#             accurately a select case of the Hamming weight for binary numbers.
#             The Hamming weight counts the non-zero values, so the weight for
#             the number 43210 is 4, as 4 of the 5 digits are not zero.
# 
#             When we talk about "weight" here, or "Hamming weight" let it be
#             understood that we're always talking about binary strings, not a
#             more general case.
# 
#             The first thing we do is compare a bunch of binary numbers grouped
#             by their weight. Theres a pattern there, but exactly what that
#             pattern is is elusive, shall we say.
# 
#             Our first observation is that when we add one to a number, the
#             weight will increase if the number is even, which we don't want.
#             If the number is odd the last bit will carry and the number will
#             then become even. The carrying may or may not trigger a cascading
#             effect. Generally this reduces the weight, or leaves it the same.
# 
#             If the weight is reduced, we can always add 1 to it until the
#             weight arrives again at the desired value.
# 
#             So if we add 1 to any number it will either increase the weight or
#             trigger a carry which will either lower the weight or keep it the
#             same. This is true every time we increment the number. A single
#             bit carried forward into a 0 keeps the weight the same. We've
#             taken away a single 1 but also have added a 1 for a neutral
#             result. The only way to lower a weight is to trigger a cascade of
#             carries that flip a series of bits together, such as when we roll
#             over into a power of 2: 01111 + 1 = 10000
# 
#             Its not much but it's a start. Our plan is to jump ahead over any
#             values with larger weights, straight to a cascading event and then
#             if necessary build the weight up again. We want to avoid ever
#             increasing the weight when we are at weight already.
# 
#             When we add 1 to a number, we add to the least significant digit.
#             If that's a 1, then the number is odd and we're good, but if it's
#             a 0 the weight will ncrease, which is bad. So what if we add the 1
#             to the least significant 1 instead? This will trigger a carry and
#             the weight will remain the same or lower. If it is the same that
#             will be the next number with the same weight and if it is lower we
#             can build it up again.
# 
#             This plan indeed works. We construct a function to yield the
#             0-based least significant set bit, and if we add 2 to this power
#             then this triggers a carry.
# 
#             The result of this function is a number equal to or less than the
#             next number with the same Hamming weight, often skipping over a
#             range of values. We're homing in on it now. As we've carried the
#             least significant set bit, the number will now end in a sequence
#             of 0s, one more than before. We now need to add as many 1s to that
#             space as required to get the weight correct. Again we could
#             increment the number and that would eventually work. But if we
#             take the difference between the Hamming weight of the new carried
#             value and our target weight we get the quantity of 1s neccessary
#             to equalize the two. We can then construct a new value from binary
#             1s and add that to make up the difference.
# 
#             The smallest value containinga set number of 1s is a string of 1s
#             of the required length, and the way to construct this number is to
#             raise 2 to the required 1s and then subtract 1:
# 
#                 2^4 - 1 = 1111
# 
#             This corrects the weight difference. Our function to find the next
#             number with the same number of 1s in its binary representation is
#             to first trigger a carry in the lowest significant set bit and
#             then add a number composed of enough 1s to make up any difference.
            
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw(sum);

for (1..32) {
    say sprintf "%-8d  %-d", $_,  next_hamming_weight($_);
}



sub next_hamming_weight( $num ) {
    my $ham  = hamming( $num );
    my $trip = trip_carry($num);
    my $next = $trip + ones( $ham - hamming($trip) );
    return $next;
}

sub hamming ($num) {
## given number, returns count of 1s in binary representation
    my $bin  = sprintf "%b", $num;
    my $bits = sum (split //, $bin);
    return $bits;
}

sub trip_carry ($num) {
## given a number, trip the carry on the lowest significant set bit
## 10101000 -> 10110000
    my $ls   = lowsig($num);
    my $trip = 2**$ls;
    return $num + $trip;
}

sub lowsig ($num) {
# returns lowest significant set bit position, 0-based
    return 0 if ! $num;
    my $pos = 0;
    while ( !( $num & 1) ) {
        $num >>= 1;
        $pos++;
    }
    return $pos;
}

sub ones ($count) {
## returns decimal value of binary string composed from $count x 1s 
## ->(3) = 0b111 = 7
    return 2**$count - 1;
}
















# use Test::More;
# 
# is 
# 
# done_testing();
