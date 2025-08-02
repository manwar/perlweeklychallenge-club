#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %ones;

    for @ints -> $i {
        %ones{$i} = $i.base(2).comb.grep({ $_ == 1 }).elems;
    }

    say q{(}, %ones.keys.sort({ %ones{$^a} <=> %ones{$^b} || $^a <=> $^b }).join(q{, }), q{)};
}