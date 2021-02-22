use strict;
use warnings;
use feature "say";

my $input = shift // "    Perl and   Raku are  part of the same family  ";
say join " ", reverse split /\s+/, $input;
