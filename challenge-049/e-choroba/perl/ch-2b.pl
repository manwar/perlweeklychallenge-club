#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Linked::List;
    use enum qw( PREV NEXT KEY VALUE );

    sub new {
        my ($class, $args) = @_;
        my $self = [];

        $self->[PREV] = $self->[NEXT] = $self;

        $self->[KEY]   = $args->{key};
        $self->[VALUE] = $args->{value};

        bless $self, $class
    }

    sub prepend {
        my ($self, $list) = @_;
        $self->[NEXT][PREV] = $self->[PREV];
        $self->[PREV][NEXT] = $self->[NEXT];
        @$self[NEXT, PREV] = ($list, $list->[PREV]);
        $list->[PREV][NEXT] = $self;
        $list->[PREV] = $self;
    }

    sub remove_last {
        my ($self) = @_;
        my $last = $self->last;
        $last->[PREV][NEXT] = $self;
        $self->[PREV] = $last->[PREV];
        undef $_ for @$last[PREV, NEXT], $last;
    }


    sub next { $_[0][NEXT] }
    sub last { $_[0][PREV] }
    sub key { $_[0][KEY] }
    sub value { $_[0][VALUE] }
}

{   package Cache::LRU;
    use enum qw( CAPACITY HASH HEAD );

    sub new {
        my ($class, $capacity) = @_;
        bless [$capacity, {}, undef], $class
    }

    sub capacity { $_[0][CAPACITY] }

    sub value { $_[0][HASH]{$_[1]}->value }

    sub head { $_[0][HASH]{ $_[0][HEAD] } }

    sub move_to_start {
        my ($self, $key) = @_;

        $self->[HEAD] = $key
            unless defined $self->[HEAD];

        my $head = $self->head;
        my $moving = $self->[HASH]{$key};
        return if $head == $moving;

        $moving->prepend($head);
        $self->[HEAD] = $key;
    }

    sub get {
        my ($self, $key) = @_;
        return undef unless exists $self->[HASH]{$key};

        $self->move_to_start($key);
        return $self->value($key)
    }

    sub set {
        my ($self, $key, $value) = @_;
        $self->[HASH]{$key}
            //= 'Linked::List'->new({key => $key, value => $value});

        $self->move_to_start($key);

        if (keys %{ $self->[HASH] } > $self->capacity) {
            my $last = $self->head->last;
            my $last_key = $last->key;
            $self->head->remove_last;
            delete $self->[HASH]{ $last_key };
        }
    }

    sub inspect {
        my ($self) = @_;
        my %refs_to_keys = reverse %{ $self->[HASH] };

        my $element = $self->head;
        my @ordered_keys;
        while ($refs_to_keys{$element}) {
            unshift @ordered_keys, $refs_to_keys{$element};
            delete $refs_to_keys{$element};
            $element = $element->next;
        }
        return \@ordered_keys
    }
}

use Test::More;

my $c = 'Cache::LRU'->new(3);
$c->set(1, 3);
$c->set(2, 5);
$c->set(3, 7);

is_deeply $c->inspect, [1, 2, 3];

is $c->get(2), 5, 'get 2';

is_deeply $c->inspect, [1, 3, 2];

is $c->get(1), 3, 'get 1';

is_deeply $c->inspect, [3, 2, 1];

is $c->get(4), undef, 'get 4';

is_deeply $c->inspect, [3, 2, 1];

$c->set(4, 9);

is_deeply $c->inspect, [2, 1, 4];

is $c->get(3), undef, 'get 3';

done_testing();
