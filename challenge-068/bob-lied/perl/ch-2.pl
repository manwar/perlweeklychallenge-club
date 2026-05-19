#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 068 Task 2 Reorder List
#=============================================================================
# You are given a singly linked list $L as below:
#   L0 →  L1 →  … →  Ln-1 →  Ln
# Write a script to reorder list as below:
#   L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 →
# You are ONLY allowed to do this in-place without altering the nodes’ values.
#   Example Input:  1 →  2 →  3 →  4
#           Output: 1 →  4 →  2 →  3
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;

GetOptions("verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

use feature 'class'; no warnings 'experimental::class';
class Node42 {
    field $val :reader :writer :param;
    field $next :reader :writer;

    # Insert a new node after self
    method insert($node) {
        $node->set_next($next);
        $next = $node;
        return $node;
    }

    # Remove the node that follows self
    method remove() {
        my $gone = $next;
        $next = $gone->next;
        return $gone;
    }

    # Count nodes starting from self
    method length() {
        my $n = 1;
        my $p = $self;
        while ( $p = $p->next() ) { $n++ }
        return $n;
    }

    # Return reference to penultimate node.
    sub penultimate($self)
    {
        my $p = my $prev = $self;
        while ( $p->next() )
        {
            $prev = $p;
            $p = $p->next;
        }
        return $prev;
    }

};


##############
package main;

my @Input = @ARGV;
die "Need some arguments" unless @ARGV;

my $head = Node42->new( val => '_');

my $ptr = $head;
for my $n ( @Input )
{
    $ptr = $ptr->insert( Node42->new(val => $n) );
}

sub showList($p)
{
    $logger->debug("Length: ", $p->length());
    say '(', join(", ", asArray($p)->@*), ')';
}

sub asArray($p)
{
    my @array = $p->val();
    push @array, $p->val() while ( $p = $p->next() );
    return \@array;
}

showList($head->next());

if ( $head->next()->length() <= 2 )
{
    showList($head);
    exit 0;
}

my $fwd = $head->next();    # First real node in list.
my $bwd = $fwd->penultimate();
my $n = int($head->length() / 2);
while ( $fwd != $bwd )
{
    $bwd = $bwd->remove();
    $fwd = $fwd->insert($bwd)->next();
    $bwd = $fwd->penultimate();
}
showList($head->next());
