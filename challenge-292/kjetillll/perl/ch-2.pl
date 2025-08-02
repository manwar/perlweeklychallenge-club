#https://theweeklychallenge.org/blog/perl-weekly-challenge-292/
#steps random insertions of random chars from hand into a random place of board
#and clear 3+ consecutive same color from board potetionally multiple time.
#Return minumum steps neede to clear board or -1 for failure to clear board.

use strict; use warnings; use List::Util 'uniq';

sub zuma_game_steps {
    my($board, $hand) = @_;
    my @try = ( [$board, $hand, 0] );
    my %tried;
    while( @try ){
	my($b, $h, $steps) = @{ shift @try };
	1 while $b =~ s/(.)\1\1+//g;
	return $steps if length($b)==0;
	for my $try_letter ( uniq( $h =~ /./g ) ){
	    for my $i ( 0 .. length $b ){
		my $h_try = $h =~ s/$try_letter//r;
		my $b_try = $b =~ s/^.{$i}\K/$try_letter/r;
		next if $tried{ $b_try, $h_try }++; #speedup
		push @try, [ $b_try, $h_try, $steps + 1 ];
	    }
	}
    }
    -1
}

@ARGV and print zuma_game_steps(@ARGV), "\n" and exit;

use Test::More;
is zuma_game_steps("WRRBBW", "RB")      => -1;
is zuma_game_steps("WWRRBBWW", "WRBRW") => 2;
is zuma_game_steps("G", "GGGGG")        => 2;
is zuma_game_steps("CCABCC","BABA")     => 4;
is zuma_game_steps("BAAC","BCBAC")      => 5;
is zuma_game_steps("ADCBBC","ABADCDA")  => 6;
done_testing;
