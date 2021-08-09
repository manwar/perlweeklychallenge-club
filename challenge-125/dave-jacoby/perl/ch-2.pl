#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use List::Util qw{ max };
use JSON;
my $json = JSON->new->space_after->canonical;

my %nodes;
for my $n ( 1 .. 10 ) {
    my $node = Node->new($n);
    $nodes{$n} = $node;
}

$nodes{1}->left( $nodes{2} );
$nodes{1}->right( $nodes{5} );
$nodes{2}->left( $nodes{3} );
$nodes{2}->right( $nodes{4} );
$nodes{5}->left( $nodes{6} );
$nodes{5}->right( $nodes{7} );
$nodes{7}->left( $nodes{8} );
$nodes{7}->right( $nodes{10} );
$nodes{8}->left( $nodes{9} );

my @diameters;
for my $node ( sort values %nodes ) {
    my $v = $node->value();
    my $l = $node->is_leaf();
    push @diameters, btd($node) if $l;
}

my $max = max map { scalar $_->@* } @diameters;
my $done;

@diameters =
    grep {
    my $s1 = join ' ', $_->@*;
    my $s2 = join ' ', reverse $_->@*;
    $done->{$s1}++;
    $done->{$s2}++;
    $done->{$s1} < 2;
    }
    grep { scalar $_->@* == $max }
    sort { scalar $b->@* <=> scalar $a->@* } @diameters;

say join "\n", map { join " ", ( scalar $_->@* ), ':', $_->@* }

    @diameters;

sub btd ( $node, $path = [] ) {
    my @output;
    my $v = $node->value();
    push $path->@*, $v;

    my @options;
    if ( defined $node->parent() ) {
        my $p  = $node->parent();
        my $pv = $p->value();
        my $is = grep /$pv/, $path->@* ? 1 : 0;
        if ( !grep /$pv/, $path->@* ) {
            push @options, 'parent';
        }
    }
    if ( defined $node->left() ) {
        my $p  = $node->left();
        my $pv = $p->value();
        my $is = grep /$pv/, $path->@* ? 1 : 0;
        if ( !grep /$pv/, $path->@* ) {
            push @options, 'left';
        }
    }
    if ( defined $node->right() ) {
        my $p  = $node->right();
        my $pv = $p->value();
        my $is = grep /$pv/, $path->@* ? 1 : 0;
        if ( !grep /$pv/, $path->@* ) {
            push @options, 'right';
        }
    }

    if (@options) {
        for my $option (@options) {
            if ( $option eq 'parent' ) {
                my $p = $node->parent();
                my $path2->@* = map { int } $path->@*;
                push @output, btd( $p, $path2 );
            }
            if ( $option eq 'left' ) {
                my $p = $node->left();
                my $path2->@* = map { int } $path->@*;
                push @output, btd( $p, $path2 );
            }
            if ( $option eq 'right' ) {
                my $p = $node->right();
                my $path2->@* = map { int } $path->@*;
                push @output, btd( $p, $path2 );
            }
        }
    }
    else {
        push @output, [ map { int } $path->@* ];
    }

    return @output;
}

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}      = $value;
    $self->{left}       = undef;
    $self->{right}      = undef;
    $self->{horizontal} = undef;
    $self->{parent}     = undef;
    return bless $self, $class;
}

sub value ( $self, $value = undef ) {
    if ( defined $value ) {
        $self->{value} = $value;
    }
    else {
        return $self->{value};
    }
}

sub is_root ( $self ) {
    return defined $self->{parent} ? 0 : 1;
}

sub is_leaf ( $self ) {
    return ( !defined $self->{left} && !defined $self->{right} )
        ? 1
        : 0;
}

sub left ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{left}   = $node;
        $node->{parent} = $self;
    }
    else {
        return $self->{left};
    }
}

sub right ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{right}  = $node;
        $node->{parent} = $self;
    }
    else {
        return $self->{right};
    }
}

sub horizontal ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{horizontal} = $node;
        $node->{parent}     = $self;
    }
    else {
        return $self->{horizontal};
    }
}

sub parent ($self ) {
    return $self->{parent};
}
