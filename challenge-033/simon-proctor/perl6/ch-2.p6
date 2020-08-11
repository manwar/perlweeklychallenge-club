#!/usr/bin/env perl6
 
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Print help text
multi sub MAIN( Bool :h($help) where so * ) {
    say $*USAGE;
}

#| Print the times table (default to 11)
multi sub MAIN(
    UInt $max = 11 #= Max number to print the table to
) {
    my &formater = format-row( $max );
    .say for get-header( $max, &formater );
    .say for (1..$max).map( { get-row( $max, &formater, $_) } );
}

sub format-row( UInt $max ) {
    my $max-width = ($max*$max).codes;
    my $row = " %{$max.codes}s |{" %{$max-width}s" x $max}";
    return sub ( *@data ) {
        sprintf $row, @data;
    }
}

sub get-header( UInt $max, &formater ) {
    my $max-width = ($max*$max).codes;
    ( &formater( "x", |(1..$max) ), "-" x ( 3 + $max.codes + ( $max * ($max-width+1) ) ) );
}

sub get-row(  UInt $max, &formater, UInt $val ) {
    &formater( $val, |( "" xx $val-1 ), |($val..$max).map( * * $val ) );
}
