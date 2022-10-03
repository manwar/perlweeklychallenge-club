#!raku

# Perl Weekly Challenge 185

sub MAIN( Str $input-mac-address
          where { $input-mac-address ~~ / ^ ( <[0..9a..f]> ** 4 <[.]> ) ** 2  <[0..9a..f]> ** 4 $ / } ) {

    my $output-mac-address = $input-mac-address.subst( /<[.]>/, '', :g );
    $output-mac-address.comb( :spit-empty ).rotor( 2 ).join( ':' ).subst( /\s+/, '', :g ).say;

}
