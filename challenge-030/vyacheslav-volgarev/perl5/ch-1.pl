use strict;
use warnings;
use v5.10;

use constant {
	Sunday => 0,
	Wednesday => 3
};

my $day = Wednesday;

for ( 2020.. 2100 ) {
	say "25 Dec $_ is Sunday" if ( $day += $_ % 4 != 0 || ($_ % 100 == 0 && $_ % 400 != 0) ? 1 : 2 ) % 7 == Sunday;
}
