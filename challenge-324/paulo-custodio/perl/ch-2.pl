#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $$0 nums...\n";

my @nums = @ARGV;
my @sets = get_power_set(@nums);
my $sum = 0;
for (@sets) {
    $sum += xor_list(@$_);
}
say $sum;

sub get_power_set {
    my ($first, @rest) = @_;
    return ([]) unless defined $first;

    my @without_first = get_power_set(@rest);
    my @with_first    = map { [$first, @$_] } @without_first;

    return (@with_first, @without_first);
}

sub xor_list {
    my(@nums) = @_;
    my $xor = 0;
    for (@nums) {
        $xor ^= $_;
    }
    return $xor;
}
