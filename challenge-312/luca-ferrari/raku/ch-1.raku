#!raku

#
# Perl Weekly Challenge 312
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
#

sub MAIN( Str $typing ) {
    my $secs = 0;
    my $position = 0;
    my @letters = 'a' .. 'z';

    for $typing.lc.comb -> $current_letter {
	my $next_position = @letters.grep( * ~~ $current_letter, :k ).first().Int;
	my $clockwise = ( $next_position - $position ) % @letters.elems;
	my $anti_clockwise = abs( @letters.elems - $next_position + 1 );
	$position = $next_position;
	$secs += 1 + ( $clockwise, $anti_clockwise ).min;
    }

    $secs.say;
}
