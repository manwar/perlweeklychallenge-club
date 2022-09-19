#!raku

# Perl Weekly Challenge 183

sub MAIN( Str $begin-date where { / \d ** 4 '-' \d ** 2 '-' \d ** 2 / }
          , Str $end-date where { / \d ** 4 '-' \d ** 2 '-' \d ** 2 / } ) {

    my @dates = Date.new( $begin-date )
                , Date.new( $end-date );

    my $days = abs( @dates[ 0 ].daycount - @dates[ 1 ].daycount );
    my $years = $days >= 365 ?? ($days / 365).Int !! 0;
    $days = $days >= 365 ?? $days % 365 !! $days;

    "$begin-date - $end-date = $years years and $days days".say;
}
