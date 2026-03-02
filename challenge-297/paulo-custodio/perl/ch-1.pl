#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums...\n";
say max_len(@ARGV);

sub max_len {
    my(@digits) = @_;
    my @zeros = grep {$_==0} @digits;
    my @ones  = grep {$_==1} @digits;
    return min(scalar(@zeros), scalar(@ones))*2;
}
