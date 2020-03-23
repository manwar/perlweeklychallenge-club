#!/usr/bin/perl
# Test: ./ch-2.pl 3
use strict;
use warnings;
use feature qw /say/;
use Algorithm::Combinatorics qw(variations_with_repetition);

my $size = $ARGV[0] || 5;
my @vowels = ('a', 'e', 'i', 'o', 'u');

my $iter = variations_with_repetition(\@vowels,$size);
while (my $v = $iter->next) {
    say join '', @$v
    	if (valid_combination($v));
}

# IS valid combination
sub valid_combination {
    my $word = shift;

    # Faster than a regex
    for (my $i = 0; $i < scalar(@$word) - 1; $i++) {
    	return 0 unless
    	_check_letters($word, $i, 'a', 'e', 'i') &&
    	_check_letters($word, $i, 'e', 'i') &&
    	_check_letters($word, $i, 'i', 'a', 'e', 'o', 'u') &&
    	_check_letters($word, $i, 'o', 'a', 'u') &&
    	_check_letters($word, $i, 'u', 'o', 'e');
    }

    return 1;
}

# Check the folowing letters
sub _check_letters {
    my ($word, $i, $letter, @checks) = @_;
    my $valid = 1;

    if ($word->[$i] eq $letter) {
    	$valid = 0;
    	for my $check (@checks) {
    		$valid = 1
    			if ($word->[$i + 1] eq $check);
    	}
    }

    return $valid;
}
