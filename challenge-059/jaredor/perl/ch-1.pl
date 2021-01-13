#!/usr/bin/env perl

use v5.012;
use warnings;
use Getopt::Long;
use List::Util qw(all);
use Scalar::Util qw(looks_like_number);

# PWC 059, TASK #1 : Linked List

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions( 'k=f' => \( my $k ) );

die "The --k option must set a numeric value for the partitioning definition."
  unless looks_like_number $k;

die "The link values of the linked list must all be numeric."
  unless all { looks_like_number $_ } @ARGV;

die "No link values provided for the linked list."
  unless @ARGV;

# Convenience constructs.

use constant NULL => [];
sub make_link { return [ $_[0], NULL ]; }

# Create the linked list from the input arguments.

my $ll_input = make_link;
my $ll_curpt = $ll_input;

$ll_curpt = ( $ll_curpt->[1] = make_link $_ ) for @ARGV;
$ll_input = pop @$ll_input;

# Split the input linked list into "<" and ">=" linked lists.
# This is a destructive rearrangement of the $ll_input linked list.

my ( $lt_subll, $ge_subll ) = ( make_link, make_link );
my ( $lt_curpt, $ge_curpt ) = ( $lt_subll, $ge_subll );

while (@$ll_input) {
    my $curr_ptr = $ll_input->[0] < $k ? \$lt_curpt : \$ge_curpt;
    $ll_input = ( $$curr_ptr = ( $$curr_ptr->[1] = $ll_input ) )->[1];
}

( $lt_curpt->[1], $ge_curpt->[1] ) = ( NULL, NULL );
( $lt_subll, $ge_subll ) = ( pop @$lt_subll, pop @$ge_subll );

# Attach the ">=" linked list to the "<" list if "<" exists.

$lt_curpt->[1] = $ge_subll if defined $lt_subll->[0];

# Create output re-linked list.

my $ll_ltge = defined $lt_subll->[0] ? $lt_subll : $ge_subll;

# Print linked list data from head to tail.
# This is a non-destructive walk of the $ll_ltge linked list.

my ( $ll_print, $delim, @outlist ) = ( $ll_ltge, ' -> ', );

( $outlist[@outlist], $ll_print ) = @$ll_print while @$ll_print;

say join( $delim, @outlist );
