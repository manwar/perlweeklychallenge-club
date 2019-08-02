#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use 5.010;
use strict;
use warnings;
use utf8;

use List::Util qw(max);
use String::Pad qw(pad);

sub center {
    my (@lines) = @_;

    my $max_width = max map { length } @lines;
    return [ map { pad($_, $max_width, 'c') } @lines ];
}

say join qq|\n|, @{center('This', 'is', 'a test of the', 'center function')};

1;

__END__

$ perl ch2.pl
     This
      is
 a test of the
center function
