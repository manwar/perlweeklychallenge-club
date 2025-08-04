#!raku

#
# Perl Weekly Challenge 333
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my @result;

    for @nums {
	@result.push: $_;
	@result.push: $_ if ( $_ == 0 );
    }

    @result[ 0 .. @nums.elems - 1 ].join( ', ' ).say;
}
