#!raku

#
# Perl Weekly Challenge 233
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-233/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ) } ) {
    my %sorting;
    for @nums -> $current {
	my $frequency = @nums.grep( * == $current ).elems;
	%sorting{ $frequency } //= Array.new;
	%sorting{ $frequency }.push: $current if ( ! %sorting{ $frequency }.grep( * == $current ) );
    }

    %sorting{ $_ }.sort.join( ',' ).say for %sorting.keys.sort;

}
