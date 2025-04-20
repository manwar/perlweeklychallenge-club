#!/usr/bin/env raku

use v6.d;

sub acronyms(@array, Str $word --> Bool) {
    $word eq map({ ($_.comb)[0] }, @array).join;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is acronyms(["Perl", "Weekly", "Challenge"], "PWC"), True, 'works for "PWC"';
    is acronyms(["Bob", "Charlie", "Joe"], "BCJ"), True, 'works for "BCJ"';
    is acronyms(["Morning", "Good"], "MM"), False, 'works for "MM"';
}

#| Take user provided number like PWC Perl Weekly Challenge"
multi sub MAIN(Str $word, *@array) {
    say acronyms(@array, $word);
}
