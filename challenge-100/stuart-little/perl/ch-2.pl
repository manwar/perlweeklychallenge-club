#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <space-separated array entries, right-to-left and top-to-bottom>

use feature qw(signatures);
no warnings qw(experimental::signatures);
use List::AllUtils qw(min zip_by);

sub mins($ar) {
    my @mins = ($ar->[0], (map {min $ar->[$_], $ar->[$_+1]} (0..(scalar @{$ar}-2))), $ar->[-1]);
    return \@mins;
}

sub redStep($sm,$bg) {
    my $size=scalar @{$sm};
    my @zipped = zip_by {$_[0] + $_[1]} mins($sm), [$bg->@[0..$size]];
    return [@zipped, $bg->@[$size+1..scalar @{$bg}-1]];
}

my $sm = [@ARGV[0,]];
my $bg = [@ARGV[1..$#ARGV]];
while ((scalar @$bg) > (my $size=scalar @$sm)) {
    my $processed = redStep($sm,$bg);
    $sm = [$processed->@[0..$size]];
    $bg = [$processed->@[$size+1..scalar @{$processed}-1]];
}

say min @$sm;
