#!/usr/bin/env perl
#
# ch-1.pl - Compactify list of numbers
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

my @list = split /[, ]+/, join(',', @ARGV); # Be flexible. 1,2, 3 4 ,,5 is OK

my ($last, $start);

my @compact;
for (@list, undef) {
    if ($last and $_ - $last == 1) {
        $start //= $last;
    } else {
        if ($start) {
            push @compact, "$start-$last";
            $start = undef;
        } else {
            push @compact, $last if $last;
        }
    }
    $last = $_;
}

say join(',', @compact);
