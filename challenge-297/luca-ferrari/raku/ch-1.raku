#!raku

#
# Perl Weekly Challenge 297
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
#

sub MAIN( *@bits where { @bits.grep( * !~~ any(0,1) ).elems == 0 } ) {
    my $max-length = 0;

    for 0 ..^ @bits.elems - 1 -> $start {
	for $start ^..^ @bits.elems -> $end {
	    next if @bits.[ $start .. $end ].grep( * ~~ 0 ).elems != @bits[ $start .. $end ].grep( * ~~ 1 ).elems;
	    $max-length = $end - $start + 1 if ( $end - $start + 1 > $max-length );
	}
    }

    $max-length.say;
}
