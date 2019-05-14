use strict;
use warnings;
use Const::Fast;

const my $FIRST =>  0;
const my $LAST  => 50;

for my $n ($FIRST .. $LAST)
{
    next if $n == 0;    # Because 0/0 is undefined

    my $sum  = 0;
       $sum += $_ for split //, $n;

    print "$n\n" if $n % $sum == 0;
}

