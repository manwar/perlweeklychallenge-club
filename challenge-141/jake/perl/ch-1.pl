#!/usr/bin/env perl

use warnings;
use strict;
use feature 'say';

# number attributes
# num specifies the lowest number to start analysis
# div_required specifies for how many divisors we aiming at
# output specifies how many numbers will be displayed
my $num_atr = {
    num => '1',
    div_required => '8',
    output_required => '10'
};

# output
my $res = collect_numbers();
say join (' ', @$res);



# aggregate required amount of numbers according to output_required
sub collect_numbers {
    my @result = ();

    while ( $#result+1 < $num_atr->{output_required} ) {
        push @result, count_divisors( $num_atr, 0, 0 );
        $num_atr->{num}++;
    }
    return \@result;
}


sub count_divisors {
    my ( $spec_num, $div_cntr, $subtractor) = @_;

# divide num through all numbers <= num and count every time modulo is 0
# each time modulo is 0 we know it's a divisor
    while ( $subtractor != $num_atr->{num} ) {
        $div_cntr++ if $num_atr->{num} % ( $num_atr->{num} - $subtractor ) == 0;
        $subtractor++;
    }

# only return to sub collect_numbers if we hit the required amount of divisors
    if ( $div_cntr == $num_atr->{div_required} ) {
        return $num_atr->{num};
    }

# when ever the current num did not meet the required divisors we need to start over counting them for the next num
# in this case we must not return num to sub collect_numbers
    else {
        $num_atr->{num}++;
        return count_divisors( $num_atr, 0, 0 );
    }
}