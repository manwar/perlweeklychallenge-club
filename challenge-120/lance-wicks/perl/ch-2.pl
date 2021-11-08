use strict;
use warnings;
use Modern::Perl;

use lib './lib';
use Clock;

my $clock = Clock->new;


say $clock->angle($ARGV[0]) . ' Degrees';
