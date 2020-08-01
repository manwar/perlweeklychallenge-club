#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Getopt::Long;
my $n = 1;
GetOptions( 'number=i' => \$n, );

my $start;
for my $i ( 1 .. 5 ) {
    if ( !defined $start ) {
        $start = Node->new($i);
    }
    else {
        my $last = get_last($start);
        $last->next( Node->new($i) );
    }
}

trim_list( $start, $n );

sub trim_list ( $link, $n = 1 ) {

    # how big is the linked list?
    my $i = 0;
    my $s = $link;

    while ( defined $s ) {
        $i++;
        $s = $s->{next};
    }

    my $stop = $i - $n + 1;
    $stop = $stop < 1 ? 1 : $stop;

    $i = 1;
    $s = $link;
    while ( defined $s ) {

        $s->remove if $i == $stop;
        $s = $s->{next};
        $i++;
    }

    show_list($start);
}

sub show_list( $link ) {
    while ( defined $link ) {
        print $link->{value} || '';
        if ( defined $link->{next} ) {
            print ' -> '
                if defined $link->{next};
        }
        else { print "\n" if !defined $link->{next}; }
        $link = $link->{next};
    }
}

sub get_last( $node ) {
    return get_last( $node->next ) if $node->next;
    return $node;
}

# copied and pasted from my Challenge #59 code

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

# this one is added.
# because we cannot replace self, we must redefine
# $self and remove next when trying to remove first 
# element
sub remove ( $self ) {
    my $parent = $self->{parent};
    my $next   = $self->{next};

    if ( defined $parent && defined $next ) {
        $parent->{next} = $next;
        $next->{parent} = $parent;
    }
    elsif ( defined $parent ) {
        $parent->{next} = undef;
    }
    elsif ( defined $next ) {
        $self->{value} = $next->{value};
        $next->remove;
    }
}
