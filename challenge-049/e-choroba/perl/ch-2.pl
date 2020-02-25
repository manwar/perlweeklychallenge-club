#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Cache::LRU;
    use enum qw( CAPACITY HASH ARRAY );
    use enum qw( POS VALUE );

    sub new {
        my ($class, $capacity) = @_;
        bless [$capacity, {}, []], $class
    }

    sub capacity { $_[0][CAPACITY] }

    sub _last { $#{ $_[0][ARRAY] } }

    sub _value { $_[0][HASH]{ $_[1] }[VALUE] }

    sub _pos :lvalue { $_[0][HASH]{ $_[1] }[POS] }

    sub _move_to_start {
        my ($self, $key, $value, $size) = @_;
        $value //= $self->_value($key);
        my $pos = exists $self->[HASH]{$key}
                ? $self->_pos($key)
                : 1 + $self->_last;
        @{ $self->[HASH]{$key} }[POS, VALUE] = (0, $value);
        splice @{ $self->[ARRAY] }, $pos, 1;
        unshift @{ $self->[ARRAY] }, $key;
        ++$self->_pos($_)
            for @{ $self->[ARRAY] }[1 .. $pos];
    }

    sub get {
        my ($self, $key) = @_;
        return undef unless exists $self->[HASH]{$key};

        $self->_move_to_start($key);
        return $self->_value($key)
    }

    sub set {
        my ($self, $key, $value) = @_;
        $self->_move_to_start($key, $value);
        delete $self->[HASH]{ pop @{ $self->[ARRAY] } }
            if $self->_last == $self->capacity;
    }

    sub inspect {
        reverse @{ $_[0][ARRAY] }
    }
}

use Test::More;

my $c = 'Cache::LRU'->new(3);
$c->set(1, 3);

$c->set(2, 5);

$c->set(3, 7);

is_deeply [$c->inspect], [1, 2, 3];

is $c->get(2), 5, 'get 2';

is_deeply [$c->inspect], [1, 3, 2];

is $c->get(1), 3, 'get 1';

is_deeply [$c->inspect], [3, 2, 1];

is $c->get(4), undef, 'get 4';

is_deeply [$c->inspect], [3, 2, 1];

$c->set(4, 9);

is_deeply [$c->inspect], [2, 1, 4];

is $c->get(3), undef, 'get 3';

done_testing();
