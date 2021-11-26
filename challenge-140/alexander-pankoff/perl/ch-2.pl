use strict;
use warnings;
use feature qw'say signatures';
no warnings 'experimental::signatures';

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    my $i = prompt_for_integer('i');
    my $j = prompt_for_integer('j');
    my $k = prompt_for_integer('k');

    my $matrix        = multiplication_matrix( $i, $j );
    my @sorted_matrix = sort_multiplication_matrix($matrix);
    my $res           = $sorted_matrix[ $k - 1 ];

    if (DEBUG) {
        say "Since the multiplication of $i x $j is as below:";

        say render_matrix($matrix);
        say "The sorted multiplication table:";
        say join( ' ', @sorted_matrix );

        say "Now the " . to_ordinal($k) . " element in the table is '$res'";

    }

    say $res;

}

sub multiplication_matrix ( $i, $j ) {
    [
        map {
            my $row = $_;
            [
                map {
                    my $col = $_;
                    $col * $row;

                } ( 1 .. $j )
            ];
        } ( 1 .. $i )
    ];
}

sub sort_multiplication_matrix($matrix) {
    sort { $a <=> $b } map { @$_ } @$matrix;
}

sub render_matrix($matrix) {
    my $max        = $matrix->[-1][-1];
    my $width      = length $max;
    my $format_str = "%$width" . 'd';

    join(
        "\n",
        map {
            join( " ", map { sprintf( $format_str, $_ ) } @$_ )
        } @$matrix
    );
}

sub to_ordinal($n) {
    return ( $n == 1 ) ? "1st" : $n == 2 ? "2nd" : $n == 3 ? "3rd" : $n . 'th';
}

sub prompt_for_integer($name) {
    say "Enter integer number $name greater or equal to 1.";
    chomp( my $number = <STDIN> );

    if ( $number !~ m/^\d+$/ || $number < 1 ) {
        say "Invalid integer.";
        return prompt_for_integer($name);
    }

    return $number;
}
