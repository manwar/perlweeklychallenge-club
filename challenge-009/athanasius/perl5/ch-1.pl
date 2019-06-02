use strict;
use warnings;
use utf8;
use Const::Fast;

const my $DIGITS => 5;
const my $START  => int sqrt(10 ** ($DIGITS - 1));

for (my $n = $START; ; ++$n)
{
    my $sq = $n * $n;

    my %digits;
     ++$digits{$_} for split //, $sq;

    if (scalar keys %digits >= $DIGITS)
    {
        print "\nThe first square number that has at least $DIGITS distinct " .
                "digits is:\n$n² = $sq\n";
        last;
    }
}

