#!/usr/bin/env perl6

sub MAIN ( *@numbers where { $_.all ~~ Int } ) {

    if @numbers.elems == 0 { say "Usage: script <space-separated list of integers>"; exit; }

    @numbers = @numbers.sort;
    my Range @output;

    # Populate @output array with commandline numbers as Range objects
    for @numbers -> $n {
        my $i = @output.elems;
        if $i == 0 || $n > @output[$i-1].max+1 { @output[$i] = Range.new($n.Int, $n.Int); }
        elsif $n == @output[$i-1].max+1 { @output[$i-1] = Range.new( @output[$i-1].min, $n.Int ); };
    }


    # Print the ranges from the @output array
    for 0..(@output.elems-1) -> $i {

        FIRST { print 'Compact range representation: '; }

        if @output[$i].elems == 1 { print(@output[$i].min); }
        else { print(@output[$i].min, '-', @output[$i].max); }

        if $i < @output.elems-1 { print ', '; }
        else { say '.'; }
    }
}
