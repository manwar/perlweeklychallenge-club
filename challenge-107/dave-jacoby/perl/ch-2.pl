#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

for my $k ( sort keys %Calc:: ) {
    say $k;
}

package Calc;

use strict;
use warnings;

sub new { bless {}, shift; }
sub add { }
sub mul { }
sub div { }

1;
