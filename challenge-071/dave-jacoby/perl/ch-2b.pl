#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Getopt::Long;
my $n = 1;
GetOptions( 'number=i' => \$n, );

my $start = Node->new('0');
for my $i ( 1 .. 5 ) {
    my $last = get_last($start);
    $last->next( Node->new($i) );
}

# show_list($start->next); #so we don't get the start node
trim_list( $start, $n );

exit;

sub trim_list ( $link, $n = 1 ) {

    # how big is the linked list?
    my $i = 0;
    my $s = $link;

    while ( defined $s ) {
        $i++;
        $s = $s->{next};
    }
    my $stop = $i - $n;
    $stop = $stop < 1 ? 1 : $stop;

    my $k = 1;
    $s = $link;
    while ( $s->next ) {
        if ( $stop == $k ) {
            $s->remove_next;
            last;
        }
        $s = $s->next;
        $k++;
    }
    show_list( $start->next );
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

######### ######### ######### ######### ######### ######### #########
# Now a singly-linked list, meaning no pointing back to the start

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value} = $value;
    $self->{next}  = undef;

    # $self->{parent} = undef;
    return bless $self, $class;
}

sub value ( $self ) {
    return $self->{value};
}

# sub is_root ( $self ) {
#     return defined $self->{parent} ? 0 : 1;
# }

sub is_leaf ( $self ) {
    return ( !defined $self->{left} && !defined $self->{right} )
        ? 1
        : 0;
}

sub next ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{next} = $node;

        # $node->{parent} = $self;
    }
    else {
        return $self->{next};
    }
}

# sub parent ($self ) {
#     return $self->{parent};
# }

sub remove_next( $self ) {
    my $next = $self->{next};
    if ( defined $next ) {
        $self->{next} = $next->{next};
    }
}
