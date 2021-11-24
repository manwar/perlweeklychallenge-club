use strict;
use warnings;
use feature qw'say signatures';
no warnings 'experimental::signatures';

use List::Util qw(max);

run() unless caller();

sub run() {
    my $a = prompt_for_binary('a');
    my $b = prompt_for_binary('b');

    say "Result:";
    say( add_binarys( $a, $b ) );

}

sub add_binarys ( $a, $b ) {

    my @a_digits = reverse split( '', $a );
    my @b_digits = reverse split( '', $b );

    # we walk the digits of the binary numbers starting with the least
    # significant digit, add the digits individually, carry the carry around
    # with us and build our result from the back
    my ( $out, $carry ) = ( '', 0 );
    for ( 0 .. max( $#a_digits, $#b_digits ) ) {
        my $res;
        ( $res, $carry ) =
          add_binary_digits( $a_digits[$_] // 0, $b_digits[$_] // 0, $carry );
        $out = $res . $out;
    }

    return $carry ? $carry . $out : $out;
}

sub add_binary_digits ( $a, $b, $carry ) {
    my $c = $a + $b + $carry;

    return $c >= 3 ? ( 1, 1 ) : $c == 2 ? ( 0, 1 ) : ( $c, 0 );

}

sub prompt_for_binary($name) {
    say "Enter binary number $name";
    chomp( my $number = <STDIN> );
    if ( $number !~ m/^[01]+$/ ) {
        say "Invalid binary number.";
        return prompt_for_binary($name);
    }

    return $number;
}
