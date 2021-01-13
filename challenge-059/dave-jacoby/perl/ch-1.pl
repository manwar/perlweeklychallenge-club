#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

my $k     = 3;
my $input = [ 1, 4, 3, 2, 5, 2 ];

say display_ll($input);
my $output = task_1( $k, $input );
say display_ll($output);

# the "simple" version, not using actual linked lists
# but not doing anything you can't regularly due with 
# singly-linked lists, basically shift/remove-first
# and push/add-last. Adding the first element of the 
# second linked list to the end of the first linked 
# list makes it a longer linked list.

# I think I'll have to make my Node code into an actual
# linked list eventually

sub task_1 ( $k, $array ) {
    my $output = [];
    my @below ;
    my @above ;
    while ( $array->@* ) {
        my $l = shift $array->@*;
        if ( $l < $k ) {
            push @below, $l;
            next;
        }
        push @above, $l;
    }
    push $output->@*, @below, @above;
    return $output;
}

sub display_ll($array) {
    return join ' -> ', $array->@*;
}
