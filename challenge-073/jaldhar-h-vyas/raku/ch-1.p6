#!/usr/bin/perl6

sub MAIN(
    Int $S, #= size of sliding window
    *@A     #= list of integers
    where { @A.elems > 0; }
) {

    my @output;

    for (0 .. @A.elems - $S) -> $i {
        @output.push(@A[$i ..^ $i + $S].min);
    }

    @output.join(q{ }).say;
}
