#! /opt/local/bin/perl
#
#       basket-weaving.pl
#
#       TASK #2 › Reorder List
#             Submitted by: Mohammad S Anwar
#             You are given a singly linked list $L as below:
#
#                 L0 →  L1 →  … →  Ln-1 →  Ln
#             Write a script to reorder list as below:
#
#                 L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 →
#             You are ONLY allowed to do this in-place without altering
#             the nodes’ values.
#
#             Example
#                 Input:  1 →  2 →  3 →  4
#                 Output: 1 →  4 →  2 →  3
#
#
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @input = @ARGV;

## convert the input commandline array into a linked list
## $node points to beginning of the list
my ($node, $next);
while (scalar @input > 0) {
    my $value =  pop @input;
    $node = new Node($value, $next);
    $next = $node;
}

print_list($node);

## the moved node is inserted after the splice point
## $node is a working container
my ($start_node, $splicepoint);
$splicepoint = $start_node = $node;

while (defined $splicepoint->next) {

    ## when the splice point is second to last before the splice,
    ## last node is to be spliced into the same location
    ## we are done so jump out
    ## This happens only when the node count is even.
    last if not defined $splicepoint->next->next;

    ## temporarily go to the 2nd to last node
    while (defined $node->next->next) {
        $node = $node->next;
    }

    ## relink the last node:
    ##   set the last node next to the node after the splice point
    ##   update the splice point next to the last node
    ##   update the working node next to undef,
    ##     as it is now the last node
    $node->next->next($splicepoint->next);
    $splicepoint->next($node->next);
    $node->end;

    ## jump ahead 2 nodes and go again
    $node = $splicepoint = $splicepoint->next->next;

    print_list($start_node);
}

## ## ## ## ## SUBS:

sub print_list {
## given a linked list starting node, follows that list until the end,
## transferring the values to an array.
## the array is then printed
    my $node = shift;
    my @output;
    while (defined $node) {
        push @output, $node->value;
        $node = $node->next;
    }
    say join ' → ' , @output;
}

## ## ## ## ## PACKAGES:

package Node;

sub new {
    my ($class, $value, $next)  = @_;
    my $self     = { "value"    => $value,
                     "next"     => $next    };
    bless $self, $class;
    return $self;
}

sub value {
## removed ability to reset value for challenge
    return $_[0]->{value}
}

sub next {
    my ($self, $next ) = @_;
    $self->{next} = $next if defined $next;
    return $self->{next}
}

sub end {
    $_[0]->{next} = undef;
}
