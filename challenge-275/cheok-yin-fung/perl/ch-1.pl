# The Weekly Challenge 275
# Task 1 Broken Keys
use v5.30.0;
use warnings;

sub bro_k {
    my $sentence = $_[0];
    my @words = split " ", $sentence;
    our @keys = map {lc $_} $_[1]->@*;
    my $ans = 0;
    sub typable {
        my $w = lc $_[0];
        for my $k (@keys) {
            return 0 if index($w,$k)>=0;
        }
        return 1;
    }
    for my $word (@words) {
        $ans++ if typable($word);
    }
    return $ans;
}

use Test::More tests=>4;
ok bro_k("Perl Weekly Challenge", ['l', 'a']) == 0;
ok bro_k("Perl and Raku", ['a']) == 1;
ok bro_k("Well done Team PWC", ['l','o']) == 2;
ok bro_k("The joys of polyglottism", ['T']) == 2;
