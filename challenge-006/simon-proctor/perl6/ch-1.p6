#!/usr/bin/env perl6

use v6;

class GrowableRange {
    has Int $.min;
    has Int $.max;

    submethod BUILD( Int :$!min, Int :$!max ) {}

    method next() { $!max + 1 }

    method grow() { $!max++; return self }

    method gist() { $!min == $!max ??
                    $!min.Str !! $!max == $!min+1 ??
                                 "{$!min},{$!max}"
                              !! "{$!min}-{$!max}" }

    method Str() { self.gist }
}

sub USAGE { say $*USAGE }

#| Display Help file
multi sub MAIN ( Bool :h($help) where *.so ) { USAGE(); }

#| Get the shortend list of a CSV string
multi sub MAIN (
    Str $number-string where * ~~ /^ \d+ [ ',' \d+ ]* $/ #= Comma seperated list of numbers
) {
    my Int @in = [$_.Int for $number-string.split(",")].sort( * <=> * );
    say process-list( @in );
}

#| Get the shorted list of a space seperated list of number
multi sub MAIN (
    *@numbers where { all($_) ~~ IntStr } #= List of integers
) {
    my Int @in = [$_.Int for @numbers].sort( * <=> * );
    say process-list( @in );
}

sub process-list( Int @numbers ) {
    my $current;
    my @out;
    
    for @numbers -> $number {
        if @out.elems == 0 || @out[*-1].next != $number {
            @out.push( GrowableRange.new( min => $number, max => $number ) );
        } else {
            @out[*-1].grow;
        }
    }
    
    return @out.join(",");
}
