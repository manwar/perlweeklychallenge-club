#!/usr/bin/perl
use warnings;
use strict;

{   package My::Queue::Priority::Array;

    sub new { bless [], shift }

    sub is_empty { ! grep @{ $_ // [] }, @{ $_[0] } }

    sub insert_with_priority {
        my ($self, $element, $priority) = @_;
        push @{ $self->[$priority] }, $element;
    }

    sub pull_highest_priority_element {
        my ($self) = @_;
        my ($i) = grep @{ $self->[$_] || [] }, reverse 0 .. $#$self;
        shift @{ $self->[$i] }
    }
}

{   package My::Queue::Priority::Heap;
    use enum qw( ELEMENT PRIORITY );

    sub new { bless [], shift }

    sub is_empty { ! @{ $_[0] } }

    sub insert_with_priority {
        my ($self, $element, $priority) = @_;
        push @$self, [$element, $priority];
        my $i = $#$self;
        my $p = int(($i - 1) / 2);
        while ($p >= 0 && $self->[$p][PRIORITY] < $self->[$i][PRIORITY]) {
            @$self[$i, $p] = @$self[$p, $i];
            $i = $p;
            $p = int(($i - 1) / 2);
        }
    }

    sub pull_highest_priority_element {
        my ($self) = @_;
        my $element = shift(@$self)->[ELEMENT];
        my $new = ref($self)->new;
        $new->insert_with_priority(@$_) for reverse @$self;
        $_[0] = $new;
        return $element
    }
}

use Test::More tests => 2 * 14;

for my $class (qw(My::Queue::Priority::Array My::Queue::Priority::Heap)) {
    my $q = $class->new();
    ok $q->is_empty;

    $q->insert_with_priority(@$_)
        for [a => 10], [b => 4], [c => 2], [d=>8], [e => 4], [f => 3];
    ok ! $q->is_empty;

    is $q->pull_highest_priority_element, 'a';
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'd';
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'b';
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'e';
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'f';
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'c';
    ok $q->is_empty;
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    heap => sub {
        my $q = My::Queue::Priority::Heap->new;
        $q->insert_with_priority(@$_)
            for [a => 10], [b => 4], [c => 2], [d=>8], [e => 4], [f => 3];
        $q->pull_highest_priority_element for 1 .. 6;
    },
    array => sub {
        my $q = My::Queue::Priority::Array->new;
        $q->insert_with_priority(@$_)
            for [a => 10], [b => 4], [c => 2], [d=>8], [e => 4], [f => 3];
        $q->pull_highest_priority_element for 1 .. 6;
    }

});
