#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(uniq);

@ARGV or die "usage $0 nums...\n";
say join ", ", rank(@ARGV);

sub rank {
    my(@nums) = @_;
    my @uniq = uniq sort {$a<=>$b} @nums;
    my %rank;
    for my $i (0 .. $#uniq) {
        $rank{$uniq[$i]} = $i+1;
    }
    my @rank = map {$rank{$_}} @nums;
    return @rank;
}
