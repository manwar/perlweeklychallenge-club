#!/usr/bin/env perl
use feature 'say';
my $n = $ARGV[0] || 35;
my @unspecial; # An integer is special when all of its digits are unique.
my $count = 0;
foreach (1 .. $n) {
    if (is_special($_)) {
	$count++;
    } else {
	push @unspecial, $_;
    }
}
sub is_special() {
    my $num = shift;
    my @digits = split //, $num;
    my @freq;
    for (0 .. 9) {
	foreach my $d (@digits) {
	    $freq[$_]++ if ($d == $_);	
	}
    }
    for (0 .. 9) {
	return 0 if ($freq[$_] > 1);
    }
    return 1;
}
say "Input: \$n = $n";
say "Output: $count as except for {@unspecial} all others are special.";
