#! /usr/bin/env perl

use strict;
use feature 'say';
use Getopt::Long;
use List::Util 'min';
use Perl6::Junction 'all';

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

die 'Specify $S and @A' unless @ARGV;

my ($S, @A) = @ARGV;

die '$S must be an integer >= 1' unless int($S) == $S && $S >= 1;
die '@A must contain integers only' unless all(@A) == qr/^\d+$/;

map { say ": (" . join(", ", @A[$_ .. $_ + $S -1]) . ") min -> " . min @A[$_ .. $_ + $S -1] }
(0 .. @A - $S) if $verbose;

say "(",
    join (", ", map { min @A[$_ .. $_ + $S -1] } (0 .. @A - $S)),
    ")";
