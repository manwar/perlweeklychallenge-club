#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @results;

    for @ints.permutations -> $perm {
        my $squareful = True;

        for 1 .. @$perm.end -> $n {
            if sqrt(@$perm[$n - 1] + @$perm[$n]) % 1 != 0 {
                $squareful = False;
                last;
            }
        }

        if $squareful {
            @results.push(q{(} ~ @$perm.join(q{, }) ~ q{)});
        }
    }

    @results.unique.join(q{, }).say;
}
