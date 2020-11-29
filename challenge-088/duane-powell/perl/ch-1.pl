#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/ TASK #1
# You are given an array of positive integers @N.
# Write a script to return an array @M where $M[i] is the product of all elements of @N except the index $N[i].

my @N = @ARGV;

my @M;
my $i = 0;
foreach ( @N ) {
	my @temp = @N;
	splice @temp, $i, 1;
	push @M, \@temp;
	$i++;
}

my @total;
foreach my $array_ref ( @M ) {
	my $total = 1;
	$total *= $_ foreach (@{$array_ref});
	push @total, $total;
}	

my $out;
say "Input:";
$out = join(', ',@N);
say "\t\@N = ($out)";

say "Output:";
$out = join(', ',@total);
say "\t\@M = ($out)\n";

$i = 0;
foreach my $array_ref ( @M ) {
	$out = "\t\$M[$i] = " . join(' x ', @{$array_ref}) . " = " . $total[$i];
	say $out;
	$i++;
}


__END__

./ch-1.pl 5 2 1 4 3
Input:
        @N = (5, 2, 1, 4, 3)
Output:
        @M = (24, 60, 120, 30, 40)

        $M[0] = 2 x 1 x 4 x 3 = 24
        $M[1] = 5 x 1 x 4 x 3 = 60
        $M[2] = 5 x 2 x 4 x 3 = 120
        $M[3] = 5 x 2 x 1 x 3 = 30
        $M[4] = 5 x 2 x 1 x 4 = 40


./ch-1.pl 2 1 4 3
Input:
        @N = (2, 1, 4, 3)
Output:
        @M = (12, 24, 6, 8)

        $M[0] = 1 x 4 x 3 = 12
        $M[1] = 2 x 4 x 3 = 24
        $M[2] = 2 x 1 x 3 = 6
        $M[3] = 2 x 1 x 4 = 8
