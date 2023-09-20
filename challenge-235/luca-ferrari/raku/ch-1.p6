#!raku

#
# Perl Weekly Challenge 235
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-235/>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {

    for 0 ..^ @nums.elems {
	my @current;
	@current.push: | @nums[ 0 .. $_ - 1 ] if $_ != 0;
	@current.push: | @nums[ $_ + 1 ..^ @nums.elems ];

	'true'.say and exit if @current ~~ @current.sort;
    }

    'false'.say;
}
