#!/usr/bin/env perl
#
# ch-1.pl - Smallest base-10 multiple of $n using only 1 and 0
#
# Ryan Thompson <rjt@cpan.org>

use warnings;
use strict;

# For... illustrative purposes only
sub mult_brute {
    local ($_) = @_;
    $_ += $_[0] while /[^10]/;
    $_;
}

# 1,478,988% faster than mult_brute
sub mult_bfs {
    my $n = shift;

    my $cur;
    for (my (@r) = $cur = 1; $cur % $n; $cur = shift @r) {
        push @r, $cur . 0, $cur . 1;
    }
    $cur;
}

# 20-30% faster than mult_bfs
sub mult_sprintf {
    my $n = shift;

    for (my $i = 1; ; $i++) {
        my $cur = sprintf '%b', $i;
        return $cur if 0 == $cur % $n;
    }
}

for (1..100) {
    my $mult = mult_bfs($_);
    my $div  = $mult / $_;

    printf "%3d x %16d = %18d\n", $_, $div, $mult;
}
