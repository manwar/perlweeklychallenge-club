#! /usr/bin/raku

use Test;

plan 3;

is-deeply(minindexsum(['Perl', 'Raku', 'Love'], ['Raku', 'Perl', 'Hate']), ['Perl', 'Raku'], 'example 1');
is-deeply(minindexsum(['A', 'B', 'C'], ['D', 'E', 'F']), [], 'example 2');
is-deeply(minindexsum(['A', 'B', 'C'], ['C', 'A', 'B']), ['A'], 'example 3');

sub v2hm(@a) {
    my %h;
    for (0..@a.end) -> $i {
        unless (%h{@a[$i]}:exists) {
            %h{@a[$i]} = $i;
        }
    }
    return %h;
}

sub minindexsum(@a, @b) {
    my %ah = v2hm(@a);
    my %bh = v2hm(@b);
    my @out;
    my $mi = @a.elems + @b.elems;
    for @a -> $w {
        if (%bh{$w}:exists) {
            my $mv = %ah{$w} + %bh{$w};
            if ($mv < $mi) {
                @out = ();
                $mi = $mv;
            }
            if ($mv == $mi) {
                @out.push($w);
            }
        }
    }
    return @out;
}
