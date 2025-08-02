#!/usr/bin/env raku

use v6.d;

sub count-common(@words1, @words2 --> Int) {
    my $words1-bag = Bag(@words1);
    my $words2-bag = Bag(@words2);
    grep({ $words1-bag{$_} == 1 and $words2-bag{$_} == 1 }, keys($words1-bag)).elems;
}

#| Run test cases
sub MAIN() {
    use Test;
    plan 3;

    is count-common(
        ("Perl", "is", "my", "friend"), ("Perl", "and", "Raku", "are", "friend")
    ), 2, 'works for ("Perl", "is", "my", "friend") and ("Perl", "and", "Raku", "are", "friend")';
    is count-common(
        ("Perl", "and", "Python", "are", "very", "similar"), ("Python", "is", "top", "in", "guest", "languages")
    ), 1, 'works for ("Perl", "and", "Python", "are", "very", "similar") and ("Python", "is", "top", "in", "guest", "languages")';
    is count-common(
        ("Perl", "is", "imperative", "Lisp", "is", "functional"), ("Crystal", "is", "similar", "to", "Ruby")
    ), 0, 'works for ("Perl", "is", "imperative", "Lisp", "is", "functional") and ("Crystal", "is", "similar", "to", "Ruby")';
}
