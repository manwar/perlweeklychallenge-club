#!/users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       your-next-pal.pl
#
#         next palindrome number
#         submitted by: mohammad s anwar
#         you are given a positive integer $n.
# 
#         write a script to find out the next palindrome number higher than the
#         given integer $n.
# 
#             example
#             
#             input: $n = 1234
#             output: 1331
# 
#             input: $n = 999
#             output: 1001
# 
#         method:
#             on first look. i thought this would be more comlicated than it was.
#             i even went over to pwc 095 and fetched my palindrome regex. armed
#             and ready, another look revealed i might not be needing it after
#             all.
# 
#             a palindromic number is constructed from a rigid set of rules, with
#             the least significant digits exactly mirroring the most. a central
#             pivot digit, if present, can be said to mirror and map to itself. if
#             we follow the rules in construction then there's no need to validate
#             it as we will already know it will conform.
# 
#             to construct the next number in a an ordered sequence of numbers, we
#             need to start with the least significant digits, lest we skip over
#             one of these values and find ourselves out-of-order.
# 
#             in a palindrome, however, the idea of which is the least significant
#             digit itself gets altered. The tail of the number is fixed by the
#             forward half, and any alterations to one requires a matching change
#             in the other. 

#             The smallest value, therefore, becomes immutably tied to the value
#             of the largest, and to find the next number in the sequence we
#             need to effect the smallest change possible, the smallest
#             increment.
# 
#             The least significant change to increment, should we
#             require this, is the central pivot digit, if present, or failing
#             that the two central digits, which must be increased together.
#             These are the smallest digits that will change between adjacent
#             palindromic numbers. 
# 
#             The first course of action, it seems, is to conform our base number
#             to palindrome status. We can do this by constructing a palindrome
#             by taking the front half of the number, mirroring a matching 
#             tail and gluing them
#             together. 

#             if this number is greater than the base value then that is already the
#             next larger palindrome and we are done. Any decrease in the
#             central pivot, or any higher valued digit position, will produce a
#             value smaller than the base. If the palindrom ewe produce is is
#             not, however, larger than the base we need a palindrome that is.
#             Now the same logic applies to increasing the pivot value: the base
#             must be lower in value than the new palindrome as one of the
#             central digits will be smaller and all digits composing the number
#             above that will be same.  

#             We will produce two routines, one to produce the simple palindrome
#             from the base, and one to produce the next palindrome. One will be
#             called and if necessary the second will follow. 
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $number = shift // 34987;
$number += 0;           ## numification is important

say "Input:  ", $number;
say "Output: ", get_next_palindrome($number);

sub get_next_palindrome ($num) {
    my $base = make_p($num);
    if ($base < $num) {
        return make_inc_p($num);
    }
    return $base;
}

sub make_p ($num) {
    my $len  = length $num;
    my $head = substr $num, 0, $len - int($len/2);
    my $tail = reverse substr $head, 0, $len/2;
    return $head . $tail;
}

sub make_inc_p ($num) {
    my $len  = length $num;
    my $head = substr $num, 0, $len - int($len/2);
    $head++;
    my $tail = reverse substr $head, 0, $len/2;
    return $head . $tail;
}

sub is_palin ($num) {
## from PWC 095, neat but ultimately not used
    return $num =~  m/^(.*).?(??{reverse($1)})$/;
}
