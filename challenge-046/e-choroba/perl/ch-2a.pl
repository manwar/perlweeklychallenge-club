#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

say join ' ', grep {
    my $door = $_;
    1 == (grep 0 == $door % $_, 1 .. 500) % 2
} 1 .. 500;
