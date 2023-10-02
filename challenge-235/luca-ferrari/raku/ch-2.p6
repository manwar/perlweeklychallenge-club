#!raku

#
# Perl Weekly Challenge 235
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-235/>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {

    my @result;
    for 0 ..^ @nums.elems {
	# add the leading zero
	@result.push: 0  if @nums[ $_ ] == 0;
	# add the number, even if it is a zero, duplicated
	# from the row above
	@result.push: @nums[ $_ ];
    }

    @result[ 0 ..^ @nums.elems ].join( ',' ).say;
}
