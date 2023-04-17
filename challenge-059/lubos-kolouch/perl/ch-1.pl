#!/usr/bin/perl
use strict;
use warnings;

package LinkedList;

sub new {
    my ( $class, $value ) = @_;
    my $self = {
        value => $value,
        next  => undef,
    };
    bless $self, $class;
    return $self;
}

sub append {
    my ( $self, $value ) = @_;
    my $current = $self;
    while ( defined $current->{next} ) {
        $current = $current->{next};
    }
    $current->{next} = LinkedList->new($value);
}

sub partition {
    my ( $self, $k ) = @_;
    my $less_head;
    my $greater_head;
    my $less_tail;
    my $greater_tail;

    my $current = $self;
    while ( defined $current ) {
        if ( $current->{value} < $k ) {
            if ( defined $less_tail ) {
                $less_tail->{next} = $current;
            }
            else {
                $less_head = $current;
            }
            $less_tail = $current;
        }
        else {
            if ( defined $greater_tail ) {
                $greater_tail->{next} = $current;
            }
            else {
                $greater_head = $current;
            }
            $greater_tail = $current;
        }
        $current = $current->{next};
    }

    if ( defined $less_tail ) {
        $less_tail->{next} = $greater_head;
    }
    else {
        $less_head = $greater_head;
    }

    if ( defined $greater_tail ) {
        $greater_tail->{next} = undef;
    }

    return $less_head;
}

sub to_string {
    my $self    = shift;
    my $str     = '';
    my $current = $self;
    while ( defined $current ) {
        $str .= $current->{value} . ' → ';
        $current = $current->{next};
    }
    $str .= 'END';
    return $str;
}

package main;

my $list = LinkedList->new(1);
$list->append(4);
$list->append(3);
$list->append(2);
$list->append(5);
$list->append(2);

print "Original list: ", $list->to_string(), "\n";
my $k                = 3;
my $partitioned_list = $list->partition($k);
print "Partitioned list with k=$k: ", $partitioned_list->to_string(), "\n";
