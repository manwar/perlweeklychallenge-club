#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Lingua::EN::Numbers qw( num2en );

# You COULD try to make up a way to do this, but this wheel has been
# invented already and is sufficiently round.

my @numbers;
for my $i ( 0 .. 100 ) {
    my $e = num2en $i;
    next if $e =~ /e/mx;
    push @numbers, $i;
}
say join ', ', @numbers;
