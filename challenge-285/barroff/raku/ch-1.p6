#!/usr/bin/env raku

use v6.d;

sub no-connection(@routes --> Str) {
    my %routes-dict;
    map({ %routes-dict{$_[0]} = $_[1] }, @routes);
    my $sources = Set(keys(%routes-dict));
    my $targets = Set(values(%routes-dict));
    keys($targets (-) $sources)[0];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is no-connection([["B","C"], ["D","B"], ["C","A"]]), "A", 'works for route one';
    is no-connection([["A","Z"],]), "Z", 'works for route two';
}

#| Take user provided list like B C D B C A
multi sub MAIN(*@routes where elems(@routes) mod 2 == 0) {
    my @pr;
    for @routes -> $source, $target {
        @pr.push([$source, $target]);
    }
    say no-connection(@pr);
}
