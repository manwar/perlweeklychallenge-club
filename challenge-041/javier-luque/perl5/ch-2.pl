#!/usr/bin/perl
# test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

for my $i (1..20) {
    say "L($i) = " . leonardo($i);
}

# Leonardo
sub leonardo {
    my $n = shift;
    return 1 if ($n == 0 or $n == 1);

    # Recursive
    return (
        leonardo($n-1) +  # l(n-1)
        leonardo($n-2) +  # l(n-2)
        1                 # 1
    );
}
