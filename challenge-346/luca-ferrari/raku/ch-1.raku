#!raku

#
# Perl Weekly Challenge 346
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-346>
#

sub MAIN( Str $string ) {
    my @chars = $string.comb;
    my %positions;
    my $level = 0;
    for 0 ..^ @chars.elems {
	if ( @chars[ $_ ] ~~ '(' ) {
	    %positions{ $level }<start> = $_;
	    $level++;
	}
	elsif ( @chars[ $_ ] ~~ ')' ) {
	    $level--;
	    %positions{ $level }<end> = $_;

	}
    }

    # now get the max pair
    my $max-length = 0;
    for %positions.keys {
	my $current = %positions{ $_ }<end> - %positions{ $_ }<start>;
	$max-length = $current if ( $current > $max-length );
    }

    $max-length.say;
}
