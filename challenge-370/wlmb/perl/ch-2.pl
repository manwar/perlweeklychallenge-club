#!/usr/bin/env perl
# Perl weekly challenge 370
# Task 2:  Scramble String
#
# See https://wlmb.github.io/2026/04/20/PWC370/#task-2-scramble-string
use v5.36;
use List::Util qw(none);
for my ($word1, $word2)(@ARGV){
    say "$word1, $word2 -> ", check($word1, $word2)?"True":"False";
}
sub check($word1, $word2){
    return 1 if $word1 eq $word2;
    my %letters;
    ++$letters{$_} for split "", $word1;
    --$letters{$_} for split "", $word2;
    return 0 unless none {$_} values %letters;
    my $length = length $word1;
    for my $i(1..$length-1){
	return 1
	    if (check(substr($word1, 0, $i), substr($word2,0,$i))
		&& check(substr($word1,$i,$length-$i), substr($word2,$i,$length-$i)))
	    || (check(substr($word1, $i, $length-$i), substr($word2,0,$length-$i))
		&& check(substr($word1,0, $i), substr($word2,$length-$i,$i)))
	    ;
    }
    return 0;
}
