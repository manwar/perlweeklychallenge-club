#!raku

#
# Perl Weekly Challenge 228
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-228/>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my @current = @nums;
    my $moves = 0;

    while ( @current ) {
	my $swap = @current.shift;
	@current.push: $swap  if $swap > @current.min;
	$moves++;
    }

    $moves.say;
}
