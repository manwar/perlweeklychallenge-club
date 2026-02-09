#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 'nums...' x\n";
my($nums, $x) = @ARGV;
my @nums = split ' ', $nums;
my @x = split //, $x;
my @result = add(\@nums, \@x);
say join ", ", @result;

sub add {
    my($a, $b) = @_;
    my @a = reverse @$a;
    my @b = reverse @$b;
    my @x;
    my $carry = 0;
    for (my $i = 0; $i < @a || $i < @b || $carry != 0; $i++) {
        my $digit = ($a[$i]//0) + ($b[$i]//0) + $carry;
        push @x, $digit % 10;
        $carry = int($digit / 10);
    }
    return reverse @x;
}
