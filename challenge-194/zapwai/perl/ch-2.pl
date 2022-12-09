#!/usr/bin/env perl
use feature 'say';
my $s = $ARGV[0] || 'abac';
my @word = split //, $s;
my @alph = split //, "abcdefghijklmnopqrstuvwxyz";
my %hash = map { $_ => 0 } @alph;
foreach my $letter (@word) {
    $hash{$letter}++;
}
my @freq;
my @letters;
my $letter;
foreach ( keys %hash ) {
    if ($hash{$_} != 0) {
	push @freq, $hash{$_};
	push @letters, $_;
    }
}
say "Input: \$s = \'$s\'";
my $ans;
$ans = "possible... remove $letter\n" if possible();
print "Output: ".$ans;
if (!$ans) {
    say "(Not possible.)"
}
sub possible {
    my ($min, $max) = ($freq[0],$freq[0]);
    foreach (1 .. $#freq) {
	if ($freq[$_] < $min) {
	    $min = $freq[$_];
	}
	if ($freq[$_] > $max) {
	    $max = $freq[$_];
	}
    }
    return 0 if (($max - $min > 1) || ($max - $min == 0)) ;
    my $index;
    my $index_counter = 0;
    foreach (0 .. $#freq) {
	if ($freq[$_] == $max) {
	    $index = $_;
	    $index_counter++;
	}
	return 0 if $index_counter > 1;
    }
    $letter = $letters[$index];
    return 1;
}
