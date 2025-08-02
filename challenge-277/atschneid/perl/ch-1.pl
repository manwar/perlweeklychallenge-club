use strict;
use warnings;

use v5.38;

my @inputs = (
    [
     ["Perl", "is", "my", "friend"],
     ["Perl", "and", "Raku", "are", "friend"]
    ],
    [
     ["Perl", "and", "Python", "are", "very", "similar"],
     ["Python", "is", "top", "in", "guest", "languages"]
    ],
    [
     ["Perl", "is", "imperative", "Lisp", "is", "functional"],
     ["Crystal", "is", "similar", "to", "Ruby"]
    ]
    );
for (@inputs) {
    my @lines = @$_;
    my @words1 = @{$lines[0]};
    my @words2 = @{$lines[1]};
    say join ( ", ", @words1 ) . " cf. " .
	join ( ", ", @words2 ) . " :: " .
	common_count( @lines );
}

sub common_count ( $r1, $r2 ){
    no warnings 'uninitialized';

    my @words1 = @$r1; my @words2 = @$r2;
    my %word_hash1; my %word_hash2;
    grep { ++$word_hash1{ $_ } } @words1;
    grep { ++$word_hash2{ $_ } } @words2;

    return scalar grep {
	$word_hash1{ $_ } == 1 and
	    $word_hash2{ $_ } == 1 } keys %word_hash1;
}

