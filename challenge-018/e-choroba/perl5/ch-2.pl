#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

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
    use enum qw( ELEMENT PRIORITY COUNTER );

    sub new { bless [], shift }

    sub is_empty { ! @{ $_[0] } }

    my $i = 1;
    sub insert_with_priority {
        my ($self, $element, $priority, $counter) = @_;
        push @$self, [$element, $priority, ($counter // ++$i)];
        my $i = $#$self;
        my $p = int(($i - 1) / 2);
        while ($p >= 0
               && ($self->[$p][PRIORITY] < $self->[$i][PRIORITY]
                   || ($self->[$p][PRIORITY] == $self->[$i][PRIORITY]
                       && $self->[$p][COUNTER] > $self->[$i][COUNTER]))
        ) {
            @$self[$i, $p] = @$self[$p, $i];
            $i = $p;
            $p = int(($i - 1) / 2);
        }
    }

    sub pull_highest_priority_element {
        my ($self) = @_;
        my $element = shift(@$self)->[ELEMENT];
        my $new = ref($self)->new;
        $new->insert_with_priority(@$_) for @$self;
        $_[0] = $new;
        return $element
    }
}

use Test::More tests => 2 + 2 * 14;

for my $class (qw(My::Queue::Priority::Array My::Queue::Priority::Heap)) {
    my $q = $class->new();
    ok $q->is_empty;

    $q->insert_with_priority(@$_)
        for [a => 10], [b => 4], [c => 2], [d=>8], [e => 4], [f => 3];
    ok ! $q->is_empty;

    is $q->pull_highest_priority_element, 'a', $class.$#$q;
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'd', $class.$#$q;
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'b', $class.$#$q;
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'e', $class.$#$q;
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'f', $class.$#$q;
    ok ! $q->is_empty;
    is $q->pull_highest_priority_element, 'c', $class.$#$q;
    ok $q->is_empty;
}

use Benchmark qw{ cmpthese };
use constant SIZE => 500;
my @data = map [('a' .. 'z')[rand 26], int rand 100], 1 .. SIZE;

my (@heap, @array);
my %dispatch = (
    array => sub {
        @array = ();
        my $q = My::Queue::Priority::Array->new;
        $q->insert_with_priority(@$_)
            for @data;
        push @array, $q->pull_highest_priority_element for 1 .. SIZE;
    },
    heap => sub {
        @heap = ();
        my $q = My::Queue::Priority::Heap->new;
        $q->insert_with_priority(@$_)
            for @data;

        push @heap, $q->pull_highest_priority_element for 1 .. SIZE;
    },
);
cmpthese(-3, \%dispatch);

my @sorted = map $_->[0], sort { $b->[1] <=> $a->[1] } @data;
$_->() for values %dispatch;

is_deeply \@heap, \@array, 'same head - array';
is_deeply \@sorted, \@array, 'same sorted - array';
