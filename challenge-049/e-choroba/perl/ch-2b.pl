#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Linked::List;

    use enum qw( KEY VALUE PREV NEXT );

    sub new {
        my ($class, $key, $value) = @_;
        my $self = [];
        @$self[KEY, VALUE, PREV, NEXT] = ($key, $value, $self, $self);
        bless $self, $class
    }

    sub extract {
        my ($self) = @_;
        my $prev = $self->[PREV];
        my $next = $self->[NEXT];
        $prev->[NEXT] = $next;
        $next->[PREV] = $prev;
        @$self[PREV, NEXT] = ($self, $self);
    }

    sub prepend_to {
        my ($self, $list) = @_;
        return unless $list;
        $self->extract if $self->[PREV] != $self;
        $self->[NEXT] = $list // $self;
        $self->[PREV] = $list->[PREV] // $self;
        $list->[PREV][NEXT] = $self;
        $list->[PREV] = $self;
    }

    # Prevent memory leaks.
    sub demolish {
        $_[0][NEXT] = $_[0][PREV] = undef;
    }

    sub key  { $_[0][KEY] }
    sub prev { $_[0][PREV] }
    sub next { $_[0][NEXT] }
    sub value :lvalue { $_[0][VALUE] }
}

{   package Cache::LRU;

    use enum qw( CAPACITY HASH FIRST );

    sub new {
        my ($class, $capacity) = @_;
        my $self = [];
        @$self[CAPACITY, HASH, FIRST]
            = ($capacity, {}, undef);
        bless $self, $class
    }

    sub get {
        my ($self, $key) = @_;
        return unless exists $self->[HASH]{$key};

        my $element = $self->[HASH]{$key};
        if ($element != ($self->[FIRST] // -1)) {
            $element->extract;
            $element->prepend_to($self->[FIRST]);
            $self->[FIRST] = $element;
        }
        return \$element->value
    }

    sub set {
        my ($self, $key, $value) = @_;

        my $element;
        if (exists $self->[HASH]{$key}) {
            $element = $self->[HASH]{$key};
        } else {
            $element = 'Linked::List'->new($key, $value);
            $self->[HASH]{$key} = $element;
        }
        $element->prepend_to($self->[FIRST])
            unless $element == ($self->[FIRST] // -1);
        $self->[HASH]{$key}->value = $value;
        $self->[FIRST] = $element;
        if (keys %{ $self->[HASH] } > $self->[CAPACITY]) {
            my $last = $self->[FIRST]->prev;
            $last->extract;
            delete $self->[HASH]{ $last->key };
            $last->demolish;
        }
    }

    sub inspect {
        my ($self) = @_;
        my $element = $self->[FIRST];
        my @keys;
        for (keys %{ $self->[HASH] }) {
            unshift @keys, $element->key;
            $element = $element->next;
        }
        return [@keys]
    }
}


use Test::More;

my $c = 'Cache::LRU'->new(3);
$c->set(1, 3);
$c->set(2, 5);
$c->set(3, 7);

is_deeply $c->inspect, [1, 2, 3];

is ${ $c->get(2) }, 5, 'get 2';

is_deeply $c->inspect, [1, 3, 2];

is ${ $c->get(1) }, 3, 'get 1';

is_deeply $c->inspect, [3, 2, 1];

is $c->get(4), undef, 'get 4';

is_deeply $c->inspect, [3, 2, 1];

$c->set(4, 9);

is_deeply $c->inspect, [2, 1, 4];

is $c->get(3), undef, 'get 3';

done_testing();
