#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       disarmed-and-disoriented.pl
#
#       Disarium Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 19 Disarium Numbers.
# 

#         A disarium number is an integer where the sum of each digit
#         raised to the power of its position in the number, is equal to
#         the number.
# 
# 
#         For example,
# 
#         518 is a disarium number 
#             as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518


#         method:
# 
#             This is a really unusual take on what I regard as an already
#             unusual activity, that is reassigning value to the digits
#             that compose a number based on their position.
# 
#             Commonly this goes one way, removing the positional
#             information and summing hte remaining digits as their
#             independant values. In this case we are performing an
#             incantation on each digit again, considered as an independant
#             number in itself, but also raised to a power derived from its
#             positional information. But wait, get this: the positional
#             information is a counted value read left-to-right, starting
#             at 1. So the one's place has the higest value, and the
#             rightmost, highest decimal postion is given 1. Oh, and then,
#             I almost forgot, we're going to sum the result.
# 
#             Honestly relating numerical meaning to the way a number is
#             written by arcane rules that aren't the same as standard
#             notation is really getting into the realm of magick. Next
#             we're going to double the value if it's written in Helvetica,
#             and halve it if it's Lucidia Grande.
# 
#             Am I being unnecesarily cranky? It's just that without any
#             context these excursions do seem rather arbitrary. Read
#             right-to-left the exponent would be the same as that in the
#             decimal multiplier, and in that case we are applyihg the
#             exponent to the digit instead of 10. That's weird enough but
#             is in essence one change: making the decimal expansion
#             different in a defined way.
# 
#             But reading from left-to-right, indexed from 1, seems quite
#             arbitrarily different. I can't relate that to anything. I am
#             very curious how Disarium came to this conclusion, that this
#             is what he wanted to do. 

#             Note that the definition does not say positive integer, but
#             just integer, so I will take that as inclusive of 0, but not
#             negative numbers as I would have no idea how to handle the
#             negation sign. Does it hold a position ion this arbitrary
#             scheme? There is no guidance because the position seems based
#             on strings or text not numbers. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $res;
my $test = 0;
my @dis = ();

while (@dis < 19) {
    $res = disarium($test);
    push @dis, $test if $res == $test;
    $test++;
}

say $_ for @dis;

sub disarium ($num, $sum = 0) {
    $sum += (substr $num, $_-1, 1) ** $_ for (1..length $num);
    $sum;
}


