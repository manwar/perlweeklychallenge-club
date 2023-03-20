#!/bin/env raku

sub min-index-sum(@list1, @list2) {
    my %hash1 = @list1 Z=> ^+@list1;
    my %hash2 = @list2 Z=> ^+@list2;
    my @common = (%hash1.keys (&) %hash2.keys).keys;
    my $min-index = @common.map({ %hash1{$_} + %hash2{$_} }).min;

    @common.grep({ %hash1{$_} + %hash2{$_} == $min-index }).sort
}

multi MAIN('test') {
    use Test;

    is-deeply min-index-sum(<Perl Raku Love>, <Raku Perl Hate>), <Perl Raku>, 'example 1 matches';
    is-deeply min-index-sum(<A B C>, <D E F>), < >, 'example 2 matches';
    is-deeply min-index-sum(<A B C>, <C A B>), ('A',), 'example 3 matches';

    done-testing;
}

multi MAIN() {
    put min-index-sum(|$*IN.lines[0, 1].map({ .words.Array }));
}
