use warnings;
use strict;

use v5.38;

my @inputs = (
    ["a1", "f1"],
    ["g2", "a8"],
    ["g2", "h2"],
    ["a1", "h8"]
    );
for (@inputs) {
    my @keys = @$_;
    say "($keys[0], $keys[1])  => " . knight_path($keys[0], $keys[1]);
}

sub get_moves( $key ) {
    my @moves = (
	[2, 1], [1, 2], [-2, 1], [1, -2],
	[2, -1], [-1, 2], [-2, -1], [-1, -2]
	);

    my @idx = split '', $key;
    my @next_moves = ();
    for (@moves) {
	my @candidate = (
	    ord($idx[0]) + $_->[0],
	    ord($idx[1]) + $_->[1]
	    );
	if (
	    $candidate[0] >= ord('a') and
	    $candidate[0] <= ord('h') and
	    $candidate[1] >= ord('1') and
	    $candidate[1] <= ord('8')
	    ) {
	    push @next_moves, join '', map { chr( $_ ) } @candidate;
	}
    }
    return @next_moves;
}

sub knight_path( $start_key, $end_key ){
    my @queue = ($start_key);
    my %board;
    $board{ $start_key } = 0;

    while ( $#queue >= 0 ) {
	my $current = shift @queue;
	if ($current eq $end_key) {
	    return $board{ $current };
	}
	for ( get_moves( $current ) ) {
	    if ( !exists $board{ $_ } ) {
		push @queue, $_;
		$board{ $_ } = $board{ $current } + 1;
	    }
	}
    }
}
