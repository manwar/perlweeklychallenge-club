#!/usr/bin/perl6

sub MAIN(
    *@N #= a list of integers
) {
    my @positives =  @N.grep({ $_ >= 0}).sort;
    my $smallest = @positives[0];
    for 1 .. @positives.elems -> $i {
        if (@positives[$i] // Inf) - $smallest > 1 {
            $smallest++;
            last;
        } else {
            $smallest = @positives[$i];
        }
    }
    say $smallest;
}