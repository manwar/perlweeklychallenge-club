#! /usr/bin/raku

use Test;

plan 3;

is(consecutivesequence([10, 4, 20, 1, 3, 2]), 4, 'example 1');
is(consecutivesequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]), 9, 'example 2');
is(consecutivesequence([10, 30, 20]), -1, 'example 3');

sub consecutivesequence(@a) {
    my @b = @a.sort({$^a <=> $^b});
    my $mxlen = 0;
    my $here = 0;
    loop {
        for ($here + 1) .. @b.end -> $there {
            if @b[$there] != $there - $here + @b[$here] {
                $mxlen = max($mxlen, $there - $here);
                $here = $there;
                last;
            }
            if $there == @b.end {
                $mxlen = max($mxlen, $there - $here + 1);
                $here = $there;
                last;
            }
        }
        if $here >= @b.end {
            last;
        }
    }
    if $mxlen < 2 {
        $mxlen = -1;
    }
    $mxlen;
}
