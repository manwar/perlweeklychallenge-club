#!/usr/bin/env perl

use feature qw{ say };
use strict;
use warnings;

# Too easy - sprintf gives us base conversion almost for free

for my $d ( 0 .. 50 ) {
    my $o = sprintf '%o', $d;
    say qq{Decimal $d = Octal $o};
}

