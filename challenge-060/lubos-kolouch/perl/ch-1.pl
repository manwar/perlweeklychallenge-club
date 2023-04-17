#!/usr/bin/perl
use strict;
use warnings;

sub number_to_excel_column {
    my $num    = shift;
    my $column = '';
    while ( $num > 0 ) {
        $num--;
        $column = chr( ( $num % 26 ) + ord('A') ) . $column;
        $num    = int( $num / 26 );
    }
    return $column;
}

sub excel_column_to_number {
    my $column = shift;
    my $num    = 0;
    for my $char ( split //, $column ) {
        $num = $num * 26 + ( ord($char) - ord('A') + 1 );
    }
    return $num;
}

my $input_number = 28;
print "Input Number: $input_number\n";
my $output_column = number_to_excel_column($input_number);
print "Output: $output_column\n";

my $input_column = "AD";
print "Input Column Name: $input_column\n";
my $output_number = excel_column_to_number($input_column);
print "Output: $output_number\n";
