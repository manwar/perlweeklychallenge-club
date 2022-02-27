#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       factory-people-in-a-factory-world.pl
#
#       Factorions
#         Submitted by: Mohammad S Anwar
#         You are given an integer, $n.
# 
#         Write a script to figure out if the given integer is factorion.
# 
#         A factorion is a natural number that equals the sum of the
#         factorials of its digits.
# 
#         Example 1:
#             Input: $n = 145
#             Output: 1
# 
#             Since 1! + 4! + 5! => 1 + 24 + 120 = 145
# 
#         Example 2:
#             Input: $n = 123
#             Output: 0
# 
#             Since 1! + 2! + 3! => 1 + 2 + 6 <> 123

            
#         method:
# 
#             This is another example of a multi-part puzzle that at first
#             seems more complicated than it turns out to be in the end.
# 
#             Which is to say the factorial part may at first glance seem
#             daunting, but on further reflection we're only asking for the
#             factorial for any single digit. So there's ten of these, and
#             those are all the values we will ever need.
# 
#             In fact, if we make a 1:1 mapping of the digits to their
#             corresponding factorials, we can divide a number down into
#             its digits and substitute in the factorials before summing.
# 
#             At that point we only need to check for equality between the
#             value and its factorial digit-sum.
#
#             Because we only need the ten factorial values, it would make
#             sense to hard-code them into an array or hash lookup, indexed
#             against the digit values 0-9. But we're not going to do that;
#             we walk our own path in this crazy, mixed up world. Instead
#             we're going to make a short factorial function and calculate
#             the sequence from 0 through 9. Because YOLO that's why. Party
#             on, Garth, party on. 

#         observations:
# 
#             there are a grand total of 4 factorions: 1, 2, 145 and 40585
# 
#             there can be no factorials above 7 digits because the
#             smallest 8-digit number — 10,000,000 — is larger than the sum
#             of the largest 8-gigit number: 9! + 9! + 9! + 9! + 9! + 9! +
#             9! + 9! = 2,903,040
# 
#             So no 8-digit number can be large enough to sum to its own
#             value. By this same reasoning no larger number can either. So
#             having manually sifted through values up to 10,000,000 we can
#             state these are the only instances. 
# 
#             This is indeed the case, per listing in the OEIS:
#             
#             A014080		Factorions: equal to the sum of the factorials 
#                           of their digits in base 10
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



our @fact = (1);
push @fact, $fact[-1] * $_ for 1..9;

sub is_factorion($n = 145, $ds = 0) {
    $ds += $_ for map { $fact[$_] } split //, $n;

    return $ds == $n 
}


for (1..10000000) {
    say if is_factorion($_);
}

# say for grep { is_factorion($_) }  1..10_000_000 ;

# use Test::More;
# 
# is is_factorion(145), 1, 'ex-1';
# is is_factorion(123), 0, 'ex-2';
# 
# 
# done_testing();

# 362,880
