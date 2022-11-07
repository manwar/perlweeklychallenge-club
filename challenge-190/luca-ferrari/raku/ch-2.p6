#!raku

# Perl Weekly Challenge 190

sub MAIN( Str $number where { $number ~~ / ^ \d+ $ / } ) {
    my %decode-table = ( 0 .. 9 ).map: { ( $_ + 1 ) => ( 'A' .. 'Z' )[ $_ ]  };
    my @decoded;
    for $number.comb -> $current {
	@decoded.push: %decode-table{ $current };
    }

    @decoded.join( '' ).say;
}
