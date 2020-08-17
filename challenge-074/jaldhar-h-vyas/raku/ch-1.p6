#!/usr/bin/perl6

sub MAIN(
    *@A     #= list of integers
    where { @A.elems > 0; }
) {
    my %count = @A.classify({ $_; });
    my $N = (@A.elems / 2).floor;

    (%count.keys.grep({ %count{$_} > $N; }) || (-1)).join(q{ }).say;
}