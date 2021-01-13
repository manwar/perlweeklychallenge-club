#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;
use List::Util qw/ sum max /;
use Test::More;

my @N1_t = ( 2, 1, 4, 1, 2, 5 );
my @N2_t = ( 3, 1, 3, 1, 1, 5 );
ok( water_trapped( \@N1_t ) == 6 );
ok( water_trapped( \@N2_t ) == 6 );
done_testing();

sub water_trapped {
    my $input_ref   = shift;
    my @input       = @{$input_ref};
    my $hist_width  = scalar @input;
    my $hist_height = max(@input);
    my $total_water_trapped;

    for my $row ( 2 .. $hist_height ) {
        my @row_array;
        for my $column ( 0 .. $hist_width - 1 ) {
            if ( $input[$column] >= $row ) {
                $row_array[$column] = 0;
            }
            else {
                $row_array[$column] = 1;
            }
        }
        if ( !( sum(@row_array) == $hist_width - 1 ) ) {
            while ( $row_array[0] == 1 ) {
                shift @row_array;
            }
            while ( $row_array[-1] == 1 ) {
                pop @row_array;
            }
            $total_water_trapped += sum(@row_array);
        }
    }
    return $total_water_trapped;
}

