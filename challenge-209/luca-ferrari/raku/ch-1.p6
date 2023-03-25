#!raku

#
# Perl Weekly Challenge 209
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-209/>
#

sub MAIN( *@bits where { @bits.grep( * ~~ any(1, 0) ).elems == @bits.elems } ) {
    my @chars = @bits.rotor( 2, :partial ).map(
	                                        {
						       given ( $_.join ) {
						           when '10' { 'b' }
						           when '11' { 'c' }
						           when '0'  { 'a' }
						           default   { 'z' }
						       }
                                                 } );

    '1'.say and exit if ( @chars[ * - 1 ] ~~ 'a' );
    '0'.say;
}
