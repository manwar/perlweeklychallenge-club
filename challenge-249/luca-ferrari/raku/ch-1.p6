#!raku

#
# Perl Weekly Challenge 249
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
#

sub MAIN( *@nums where { @nums.elems %% 2 && @nums.grep( * ~~ Int ).elems == @nums.elems } ) {

    my %pair-elements;
    %pair-elements{ $_ }++ for @nums;
    my @pairs;
    for %pair-elements.keys.sort {
	my $how-many-pairs = %pair-elements{ $_ } / 2;
	next if $how-many-pairs < 1;
	@pairs.push: [ $_, $_ ] while ( $how-many-pairs-- > 1 );
    }

    @pairs.join( ", " ).say;
}
