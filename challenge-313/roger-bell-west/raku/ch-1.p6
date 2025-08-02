#! /usr/bin/raku

use Test;

plan 4;

is(brokenkeys('perl', 'perrrl'), True, 'example 1');
is(brokenkeys('raku', 'rrakuuuu'), True, 'example 2');
is(brokenkeys('python', 'perl'), False, 'example 3');
is(brokenkeys('coffeescript', 'cofffeescccript'), True, 'example 4');

sub brokenkeys($name, $typed) {
    my @nt = $name.comb;
    my @tt = $typed.comb;
    my $ni = 0;
    my $ti = 0;
    loop {
        if (@nt[$ni] ne @tt[$ti]) {
            return False;
        }
        if ($ti == @tt.end) {
            last;
        }
        if ($ni < @nt.end && @nt[$ni + 1] eq @nt[$ni]) {
            $ni++;
        } else {
            while ($ti < @tt.elems && @tt[$ti] eq @nt[$ni]) {
                $ti++;
            }
            if ($ti == @tt.elems) {
                last;
            }
            $ni++;
        }
    }
    True;
}
