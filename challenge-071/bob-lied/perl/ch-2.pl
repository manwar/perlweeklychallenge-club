#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 71 Task #2 > Trim Linked List 
#=============================================================================

use strict;
use warnings;
use feature qw(say);

use Getopt::Long;

##########
package Node;

use Moo;

has val  => (is => 'rw', required => 1);
has next => (is => 'rw', default => undef );

# Constructor with value and previous node to link from
sub newlink
{
    my $self = shift;
    my ($val, $from) = @_;

    return $from->next(Node->new(val => $val));
}

##########
package SLList;

use Moo;

has size => (is => 'rw', default => 0);
has head => (is => 'rw', default => undef); # Pointer to first node

sub init
{
    my $self = shift;
    my @valList = @_;

    my $node = $self->{head} = Node->new(val => shift @valList);
    $self->{size} = 1;
    for my $val ( @valList )
    {
        $node = Node->newlink($val, $node);
        $self->_bigger(1);
    }
    return $self;
}

sub _bigger
{
    my $self = shift;
    my ($howMuch) = @_;
    $self->{size} += $howMuch;
}

sub _smaller
{
    my $self = shift;
    my ($howMuch) = @_;
    $self->{size} -= $howMuch;
}

sub removeNodeAfter
{
    my $self = shift;
    my ($node) = @_;

    my $removed = $node->next;
    if ( $removed )
    {
        $node->{next} = $removed->next;
        $self->_smaller(1);
    }
    return $removed;
}

sub trim
{
    my $self = shift;
    my ($n) = @_;

    my $walkThisFar = $self->size - $n;
    if ( $walkThisFar <= 0 )
    {
        $self->{head} = $self->head->next();
        $self->_smaller(1);
        return;
    }

    my $node = $self->head();
    while ( $walkThisFar-- > 1 )
    {
        $node = $node->next();
    }
    $self->removeNodeAfter($node);
}

# Convert to simple array, for test and debug
sub _asList
{
    my $self = shift;
    my @result;

    my $node = $self->head();
    while ( $node )
    {
        push @result, $node->val;
        $node = $node->next();
    }
    return @result;
}

sub show
{
    my $self = shift;
    return join('->', $self->_asList());
}

##########
package main;

sub Usage { "Usage: ch-2.pl 'x->y->z' N\n\t'x->y->z' is a linked list\n\tN > 1\n"; }

my $doTest;
GetOptions("test!" => \$doTest);

exit(!runTest()) if $doTest;

die Usage unless @ARGV == 2;

my $StrList = $ARGV[0];

my $N = $ARGV[1];
die Usage unless $N >= 1;

sub trimList
{
    my ($strList, $n) = @_;

    $strList =~ s/\s*//g;
    my @list = split(/->/, $strList);

    my $sllist = SLList->new->init(@list);

    $sllist->trim($n);

    return $sllist->show();
}

say trimList($StrList, $N);

sub runTest
{
    use Test::More;

    is( trimList('1->2->3->4->5', 1), '1->2->3->4', "n = 1" );
    is( trimList('1->2->3->4->5', 2), '1->2->3->5', "n = 2" );
    is( trimList('1->2->3->4->5', 3), '1->2->4->5', "n = 3" );
    is( trimList('1->2->3->4->5', 4), '1->3->4->5', "n = 4" );
    is( trimList('1->2->3->4->5', 5), '2->3->4->5', "n = 5" );
    is( trimList('1->2->3->4->5', 6), '2->3->4->5', "n = 6" );

    my ($result) = (done_testing())[0];
    return $result;
}
