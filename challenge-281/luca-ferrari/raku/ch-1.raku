#!raku

#
# Perl Weekly Challenge 281
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-281>
#

sub MAIN( Str $coordinates where { $coordinates ~~ / ^ <[a .. h]> <[ 1 .. 8 ]> $/ } ) {
    my %chessboard;
    my $value = False;
    for 1 .. 8 -> $row {
	$value = $row %% 2 ?? True !! False;
	for 'a' .. 'h' -> $column {
	    %chessboard{ $column ~ $row } = $value;
	    $value = ! $value;
	}
    }

    %chessboard{ $coordinates }.say;

}
