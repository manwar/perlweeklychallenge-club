#!/usr/bin/perl

use strict;
use warnings;

my @N;
my $A;

print "example 1: \n";
@N = ( 10, 8, 12, 15, 5 );
$A = 7;
print_output( has_pair( \@N, $A ) );

print "example 2: \n";
@N = ( 1, 5, 2, 9, 7 );
$A = 6;
print_output( has_pair( \@N, $A ) );

print "example 3:\n";
@N = ( 10, 30, 20, 50, 40 );
$A = 15;
print_output( has_pair( \@N, $A ) );

my $input = get_input();
print "Output: " . print_output( has_pair( $input->{arr}, $input->{val} ) );

sub get_input {

    print "\n\nenter comma seperates values as input array:\n";
    my $input_arr_str = <STDIN>;
    $input_arr_str =~ s/\s//g;
    my @input_arr = split( /,/, $input_arr_str );

    print "enter targes value\n";
    my $input_val = <STDIN>;
    $input_arr_str =~ s/\s//g;

    print "\n\nInput: \@N = ( " . join( ", ", @input_arr ) . " ) and \$A = $input_val\n";

    return { arr => \@input_arr, val => $input_val };
}

sub print_output {
    my ($calculation_obj) = @_;

    if ( $calculation_obj->{success} ) {
        print "1 as $calculation_obj->{minuend} - $calculation_obj->{subtrahend} = $calculation_obj->{target_value}\n";
    }
    else {
        print "0\n";
    }
}

sub has_pair {
    my ( $n, $a ) = @_;

    my @n = @{$n};

    for ( my $i = 0 ; $i < scalar @n - 1 ; $i++ ) {

        for ( my $j = $i + 1 ; $j < scalar @n ; $j++ ) {
            if ( $n[$i] - $n[$j] == $a && $i != $j ) {
                return { success => 1, target_value => $a, minuend => $n[$i], subtrahend => $n[$j] };
            }
            if ( $n[$j] - $n[$i] == $a && $i != $j ) {
                return { success => 1, target_value => $a, minuend => $n[$j], subtrahend => $n[$i] };
            }
        }
    }
    return { success => 0 };

}

