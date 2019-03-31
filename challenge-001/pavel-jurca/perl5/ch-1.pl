use 5.010.1;

use strict;
use warnings;

my $string = q(Perl Weekly Challenge);
my $times = scalar $string =~ s/e/E/g;

printf qq("%s"\n%d substitutions made\n), $string, $times;
