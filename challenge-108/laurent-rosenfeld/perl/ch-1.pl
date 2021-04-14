use strict;
use warnings;
use feature "say";

my $i = 42;
my $ref = \$i;
my $addr = $1 if $ref =~ /\((0x\w+)/;
say $addr;
