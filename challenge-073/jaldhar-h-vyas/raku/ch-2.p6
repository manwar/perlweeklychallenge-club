#!/usr/bin/perl6

sub MAIN(
    *@A #= list of integers
    where { @A.elems > 0; }
) {

    my @output;

    for (0 ..^ @A.elems) -> $i {
        my $lowest = @A[0 .. $i - 1].grep({ $_ < @A[$i]; }).min;
        @output.push($lowest == ∞ ?? 0 !! $lowest);
    }

    @output.join(q{ }).say;
}
