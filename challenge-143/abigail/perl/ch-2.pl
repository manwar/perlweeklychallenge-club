#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Run as: perl ch-2.pl < input-file
#

#
# And for the fourth week in succession we're solving need the
# majority of the problem by getting the divisors of a number.
#
# Perhaps it is time to say:
#             "I'm completely out of ideas, let's skip this week".
#
# Big Yawn
#

use Math::Prime::Util qw [divisors];

while (my $n = <>) {
    # Put sum of divisor pairs in hash.
    my %s = map {$_ + $n / $_ => 1} divisors 0 + $n;
    # Any difference of 1?
    say grep ({$s {$_ - 1}} keys %s) ? 1 : 0;
}
