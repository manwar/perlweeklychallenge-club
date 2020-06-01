#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

say rotate('xyxx') . ' rotations';

sub rotate {
    my $word = shift;
    my $copy = $word;

    # The total length of the word
    my $total_word_length = length($word);
    my $i = 0;

    do {
    	$i++;
    	my $position = $i % $total_word_length;
    	my $length   = $total_word_length - $position;

    	$copy = (substr $copy, $position, $length) .
    	        (substr $copy, 0, $position);

    	say "Rotation $i: $copy";
    } while ($copy ne $word);

    return $i;
}
