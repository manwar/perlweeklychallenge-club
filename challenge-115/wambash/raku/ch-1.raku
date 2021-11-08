#!/usr/bin/env raku


sub string-chain-iter (@a,@s) {
    @a
    andthen .map: { |$_ X, (@s.Bag ∖ $_).keys.grep: -> $x { $x.starts-with: .tail.comb.tail} }\
    andthen .map: *.Slip
}

sub string-chain (+@s) {
    my &iter = &string-chain-iter.assuming(*,@s);
    [@s.head], *.&iter ... *
    andthen .[@s.end]
    andthen .first: { .cache; .head.starts-with: .tail.comb.tail  }
}


multi MAIN (*@s) {
    say +so string-chain @s
}

multi MAIN (:test($)!) {
    use Test;
    is-deeply string-chain-iter(('abc',), ('dea','cd','cec')).any, ('abc','cd') & ('abc','cec');
    is-deeply string-chain-iter(('abd','dea',), ('dea','abd')), (('abd','dea'),  ('dea','abd'));
    is string-chain('abc', 'dea','cd','cec'),('abc','cec','cd','dea');
    is string-chain('abc', 'dea','cd',), ('abc','cd','dea');
    is string-chain('ade', 'fgh','cbd',), Nil;
    done-testing;
}
