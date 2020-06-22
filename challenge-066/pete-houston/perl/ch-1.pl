#
#===============================================================================
#
#        FILE: 6601.t
#
#  DESCRIPTION: Divide two integers and truncate.
#
#      AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
#
#===============================================================================

use strict;
use warnings;

use Test::More tests => 3;
use POSIX 'floor';

sub intdiv {
    my ($num, $den) = @_;
    my $ans = exp (log (abs ($num)) - log (abs ($den)));
    my $neg = ($num < 0 xor $den < 0);
    return floor $neg ? -$ans : $ans;
}

is intdiv ( 5,  2),  2;
is intdiv (-5,  2), -3;
is intdiv (-5, -2),  2;
