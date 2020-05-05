#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

my $i;
my $k = 3;
my $head;
my $above;
my $below;

# create a linked list!
for my $i ( 1, 4, 3, 2, 5, 2 ) {
    add_node( \$head, $i );
}
say 'BEFORE';
display_list($head);
say '';

# undo first linked list, create before & after 
while ( defined $head ) {
    my $node = pop_head( \$head );
    my $l    = $node->value;
    if   ( $l < $k ) { add_node( \$below, $l ) }
    else             { add_node( \$above, $l ) }
}

# combine below and above
my $blast = get_last($below);
$blast->next($above);

say 'AFTER';
display_list($below);
say '';

exit;

sub pop_head ( $node ) {
    my $h = $$node;
    $$node = $$node->next;
    return $h;
}

sub add_node ( $node, $i ) {
    if ( defined $$node ) {
        my $last = get_last($$node);
        my $new  = Node->new($i);
        $last->next($new);
    }
    else {
        my $new = Node->new($i);
        $$node = $new;
    }
}

sub get_last( $node ) {
    return get_last( $node->next ) if $node->next;
    return $node;
}

sub display_list( $node ) {
    return if !defined $node;
    print $node->value if $node;
    if ( $node->next ) {
        print ' -> ';
        display_list( $node->next );
    }
    else { say '' }
}

######### ######### ######### ######### ######### ######### #########
# The same old Node code, but instead of left and right,
# it just has next

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}  = $value;
    $self->{next}   = undef;
    $self->{parent} = undef;
    return bless $self, $class;
}

sub value ( $self ) {
    return $self->{value};
}

sub is_root ( $self ) {
    return defined $self->{parent} ? 0 : 1;
}

sub is_leaf ( $self ) {
    return ( !defined $self->{left} && !defined $self->{right} )
        ? 1
        : 0;
}

sub next ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{next}   = $node;
        $node->{parent} = $self;
    }
    else {
        return $self->{next};
    }
}

sub parent ($self ) {
    return $self->{parent};
}
