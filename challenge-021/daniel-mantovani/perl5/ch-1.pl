# Write a script to calculate the value of e, also known as Euler’s number and Napier’s constant.
# Please checkout wiki page for more information.

use strict;
use warnings;
use v5.10;

# As Perl already has a "exp" function (see https://perldoc.perl.org/5.30.0/functions/exp.html)
# we could just use it like:
#
# say exp(1);
#
# but I'm pretty sure this was not the intent of the challenge :)
#
# So we will are going to calculate the series formula:
#
# e = 1 + 1/1 + 1/(1 *2) + 1/(1 * 2 * 3) + 1/(1 * 2 * 3 * 4) + ... +
#
# until our sum don't grow anymore, and that will be our approximation to the result
#
# Note that each term could be calculated dividing the former term by a growing integer
#
my $e = 1; # this will be our final value. We already have the first "1" on it
my $n = 1; # this will be the term number, incrementing after we add a new term
my $t = 1; # this is current term. It will be divided by $n to get following one

# we will stop calculation when $t is so small it is considered as a 0 by Perl internal
# math
while ($t) {
    $t /= $n++;    # calculate new term. Also we increment $n for next step
    $e += $t;      # and just keep adding new terms
}
say $e;
