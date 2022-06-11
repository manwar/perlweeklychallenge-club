#!/usr/bin/env perl
#
# ch-2.pl - Happy Numbers
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use List::Util qw< sum >;

sub is_happy(_);

my $count = pop // 8;

# Output the first $count Happy Numbers
for (local $_ = 1; $count > 0 ; $_++) {
    next unless is_happy;
    say;
    $count--;
}

# Return true if $_ is a happy number
sub is_happy(_) {
    my $n = shift;

    my %seen;
    for (my $c = $n; $c != 1; $c = sum map { $_*$_ } split //, $c) {
        return if $seen{$c}++;
    }

    return 1
}
