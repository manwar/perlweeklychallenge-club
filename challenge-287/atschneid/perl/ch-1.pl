use strict;
use warnings;

use v5.38;

use List::Util qw( max );

sub password_distance( $password ) {
    # needed to meet length min of 6
    my $needed = max( 6 - length $password, 0 );

    if ( $needed > 0 ) {
	if ( $password =~ /(.)\1{4}/ ) {
	    $needed = 2;
	}
    } else {
	# changes neede to break up threes
	$needed = () = $password =~ /(.)\1\1/g;
    }
    
    # changes needed for satisfying
    # lowercase, uppercase, digit
    my $lud = ( $password !~ /[a-z]/ ) + ( $password !~ /[A-Z]/ ) + ( $password !~ /[0-9]/ );

    return max( $needed, $lud );
}

my @inputs = (
    'a',
    'aB2',
    'PaaSW0rd',
    'Paaasw0rd',
    'abcde',
    'aaaaa',
    'aaa',
    'aaaaaaaaaaaaa',
    '',
    );
for my $input (@inputs) {
    say $input . ' => ' . password_distance( $input );
}
