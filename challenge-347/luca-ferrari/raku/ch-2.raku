#!raku

#
# Perl Weekly Challenge 347
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
#

sub MAIN( Str $phone is copy ) {
    $phone .= subst( / \s+ /, '', :g );
    $phone .= subst( / <[-]> /, '', :g );
    my @groups = $phone.comb( :skip-empty ).rotor( 3, :partial );
    @groups .= map( *.join );

    if @groups[ * - 1 ].chars != 2|3 {
	my $adjust = @groups[ * - 2 ] ~ @groups[ * - 1 ];
	@groups.pop;
	@groups.pop;
	@groups.push: |$adjust.comb.rotor( 2 ).map( *.join );
    }

    @groups.join( '-' ).say;

}
