#!raku

#
# Perl Weekly Challenge 205
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-205/>
#

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my @xors;
    for 0 ..^ @list.elems -> $left {
	for $left ^..^ @list.elems -> $right {
	    @xors.push: @list[ $left ] +^ @list[ $right ];
	}
    }

    @xors.max.say;
}
