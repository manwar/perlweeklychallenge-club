#!raku

#
# Perl Weekly Challenge 226
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-226/>
#

sub MAIN( *@numbers is copy where { @numbers.grep( * ~~ Int && * >= 0 ).elems == @numbers.elems } ) {
    my $moves;

    while ( @numbers.grep( * == 0 ).elems != @numbers.elems ) {
	my $removing = @numbers.grep( * > 0 ).min;
	$moves++;
	for 0 ..^ @numbers.elems {
	    next if ! @numbers[ $_ ];
	    @numbers[ $_ ] -= $removing;
	}
    }

    $moves.say;
}
