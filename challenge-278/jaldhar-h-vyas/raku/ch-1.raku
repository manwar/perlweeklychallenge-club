#!/usr/bin/raku

sub MAIN(
    $str
) {
    my %order;

    for $str.words -> $w {
        my ($word, $pos) = $w.match(/ (.+)(\d+) /).List;
        %order{$pos} = $word;
    }

    %order.keys.sort.map({ %order{$_} }).join(q{ }).say;
}