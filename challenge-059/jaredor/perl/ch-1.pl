#!/usr/bin/env perl

use v5.012;
use warnings;
use Data::Dump qw(pp);
use Getopt::Long;
use List::Util qw(all);
use Scalar::Util qw(looks_like_number);

# PWC 059, TASK #1 : Linked List

# You are given a linked list and a value k. Write a script to partition the
# linked list such that all nodes less than k come before nodes greater than or
# equal to k. Make sure you preserve the original relative order of the nodes in
# each of the two partitions.

# For example:

# Linked List: 1 → 4 → 3 → 2 → 5 → 2

# k = 3

# Expected Output: 1 → 2 → 2 → 4 → 3 → 5.

# Linked list provided as a list of arguments on the command line.
#
# If I were to claim that a linked list is simply an array of numbers, then
# I could declare victory like this:
#
# given a value, $k, set by user option, via Getopt::Long, say, then the rest
# of the command line arguments are the linked list in the @ARGV array:
#
# print join(' ', (grep { $_ < $k } @ARGV), (grep { $_ >= $k } @ARGV)), "\n";
#
# But I will *not* submit that, I won't even run it, once, for a linked list
# must have at least one pointer in it ;-)

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions( 'k=f' => \( my $k ) );

die "The --k option must set a numeric value for the partitioning definition."
  unless looks_like_number $k;

die "The node values of the linked list must all be numeric."
  unless all { looks_like_number $_ } @ARGV;

die "No node values provided for the linked list."
  unless @ARGV;

# Create the Linked list:

sub get_node { return [ $_[0], [] ]; }

my $ll_head = get_node;
my $ll_curr = $ll_head;

# Load the linked list from the input arguments.

$ll_curr = ( $ll_curr->[1] = get_node $_ ) for @ARGV;
$ll_head = pop @$ll_head;

# Split the input linked list into "less than" and "greater than or equal"
# linked lists.

my ( $lt_head, $ge_head ) = ( get_node, get_node );
my ( $lt_curr, $ge_curr ) = ( $lt_head, $ge_head );

while ( defined $ll_head and @$ll_head) {
    my $curr_ptr = $ll_head->[0] < $k ? \$lt_curr : \$ge_curr;
    $ll_head = ( $$curr_ptr = ( $$curr_ptr->[1] = $ll_head ) )->[1];
}

undef $lt_head unless defined( $lt_curr->[0] ) and $lt_head = pop @$lt_head;
undef $ge_head unless defined( $ge_curr->[0] ) and $ge_head = pop @$ge_head;

$lt_curr->[1] = $ge_head and $ge_curr->[1] = [] if defined $ge_head;

my $ll_out = defined $lt_head ? $lt_head : defined $ge_head ? $ge_head : undef;

pp $ll_out;
