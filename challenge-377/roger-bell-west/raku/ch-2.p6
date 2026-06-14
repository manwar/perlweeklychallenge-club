#! /usr/bin/raku

use Test;

plan 5;

is(prefixsuffix(['a', 'aba', 'ababa', 'aa']), 4, 'example 1');
is(prefixsuffix(['pa', 'papa', 'ma', 'mama']), 2, 'example 2');
is(prefixsuffix(['abao', 'abab']), 0, 'example 3');
is(prefixsuffix(['abab', 'abab']), 1, 'example 4');
is(prefixsuffix(['ab', 'abab', 'ababab']), 3, 'example 5');

sub prefixsuffix(@a0) {
    my $tot = 0;
    my @a = @a0.sort({$^a.chars <=> $^b.chars});
    for 0 .. @a.elems - 2 -> $si {
        for $si + 1 .. @a.elems - 1 -> $li {
            with @a[$li].index(@a[$si]) -> $le {
                if ($le == 0) {
                    with @a[$li].rindex(@a[$si]) -> $ri {
                        if ($ri == @a[$li].chars - @a[$si].chars) {
                            $tot += 1;
                        }
                    }
                }
            }
        }
    }
    $tot;
}
