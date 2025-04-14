#!/usr/bin/env raku

use v6.d;

sub circular(@list --> Bool) {
    for 0..@list.elems - 2 {
        return False if @list[$_].comb[* - 1] ne @list[$_ + 1].comb[0];
    }

    return True;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is circular(["perl", "loves", "scala"]), True,
        'works for ["perl", "loves", "scala"]';
    is circular(["love", "the", "programming"]), False,
        'works for ["love", "the", "programming"]';
    is circular(["java", "awk", "kotlin", "node.js"]), True,
        'works for ["java", "awk", "kotlin", "node.js"]';
}

#| Take user provided strings like Perl Weekly Challenge
multi sub MAIN(*@list) {
    say circular(@list);
}
