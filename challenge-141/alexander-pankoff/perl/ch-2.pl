use strict;
use warnings;
use feature qw'say signatures';
no warnings 'experimental::signatures';

use List::Util qw(reduce);

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    my $m = prompt_for_integer('m');
    my $n = prompt_for_integer('n');

    my @possible_integers = numbers_from_digits($m);
    my @divisible_by_n    = grep { $_ % $n == 0 } @possible_integers;

    explain( $m, $n, \@possible_integers, \@divisible_by_n ) if DEBUG;
    say scalar @divisible_by_n;
}

sub explain ( $m, $n, $possible_integers, $divisible_by_n ) {

    say "Possible integers created using the digits of $m are:";
    say join( ', ', sort { $a <=> $b } @$possible_integers );

    say "There are "
      . scalar(@$divisible_by_n)
      . " integers divisible by $n such as:";
    say join( ', ', sort { $a <=> $b } @$divisible_by_n );
}

sub numbers_from_digits($x) {
    my @digits  = split( '', $x );
    my $numbers = reduce(
        sub {
            my $digit = $digits[$b];
            return [
                @$a,    #
                $digit,
                ( grep { length $_ < @digits } map { $_ . $digit } @$a ),
            ];
        },
        [],
        0 .. $#digits
    );

    return @$numbers;
}

sub prompt_for_integer($name) {
    say "Enter positive integer '$name'";
    chomp( my $number = <STDIN> );

    if ( $number !~ m/^\d+$/ || $number < 1 ) {
        say "Invalid integer.";
        return prompt_for_integer($name);
    }

    return $number;
}
