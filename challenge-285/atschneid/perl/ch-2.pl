use warnings;
use strict;

use v5.38;

sub make_change_v1( $amount ) {
    my @dynamic_arr = (1) x ( $amount + 1 );
    my @coins = (5, 10, 25, 50);
    for my $coin_amount (@coins) {
	for my $idx ($coin_amount..$amount) {
	    $dynamic_arr[ $idx ] += $dynamic_arr[ $idx - $coin_amount ];	    
	}
    }
    return $dynamic_arr[ -1 ];
}

sub make_change_v2( $amount ) {
    # uses the fact that all coins not pennies are divisible by 5 to be 5 x more efficient
    $amount = int( $amount / 5 );
    return 1 if $amount == 0;
    
    my @dynamic_arr = (1) x ( $amount + 1 );
    my @coins = (1, 2, 5, 10);
    for my $coin_amount (@coins) {
	for my $idx ($coin_amount..$amount) {
	    $dynamic_arr[ $idx ] += $dynamic_arr[ $idx - $coin_amount ];	    
	}
    }
    return $dynamic_arr[ -1 ];
}

my @inputs = (
    9, 15, 100
    );
for my $input (@inputs) {
    say $input . ' => ' . make_change_v1( $input );
}
for my $input (@inputs) {
    say $input . ' => ' . make_change_v2( $input );
}
