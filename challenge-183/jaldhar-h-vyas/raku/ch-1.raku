#!/usr/bin/raku

sub printUnique(@list) {
    say
        q{(},
        @list.unique(with => { $^a eqv $^b})
            .map({ q{[} ~ $_.join(q{,}) ~ q{]} })
            .join(q{, }),
        q{)};
}

sub MAIN() {
    my @list1 = ([1,2], [3,4], [5,6], [1,2]);
    printUnique(@list1);

    my @list2 = ([9,1], [3,7], [2,5], [2,5]);
    printUnique(@list2);
}
