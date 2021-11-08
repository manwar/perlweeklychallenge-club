#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated numbers> <space-separated numbers>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::Util qw(reduce zip);

sub runAvg($aref) {
    my @ar = zip [1..scalar @{$aref}], $aref;
    my $res = reduce { my @a = @{$a}; push @a, ($a[-1]*($b->[0]-1)+$b->[1])/$b->[0]; \@a } [0,], @ar;
    shift @{$res};
    return $res;
}

say qq!@{${\ do{runAvg(\@ARGV)}}}!;
