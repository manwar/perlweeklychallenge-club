#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

# Stream is not an array. Stream is a source of values that can
# produce new values infinitely.

{   package Stream;
    use Moo::Role;

    requires qw{ first next_state };

    has state => (is => 'rw', predicate => 1);
    sub next_value {
        my ($self) = @_;
        $self->state($self->has_state
                     ? $self->next_state($self->state) : $self->first);
        return $self->value
    }
    sub value { $_[0]->state }
}

{   package Stream::Sequence::Arithmetic;
    use Moo::Role;
    use MooX::Role::Parameterized;

    with 'Stream';
    role {
        my ($params, $mop) = @_;
        $mop->method(first      => sub { $params->{first} });
        $mop->method(next_state => sub { $_[1] + $params->{difference} });
    };
}

{   package Stream::TenPlusTen;
    use Moo;

    'Stream::Sequence::Arithmetic'->apply({first      => 10,
                                           difference => 10});
}

{   package Stream::Fibonacci;
    use Moo;
    with 'Stream';

    sub first      { [0, 1] }
    sub next_state { [$_[1][1], $_[1][0] + $_[1][1]] }

    around value => sub { $_[1]->state->[-1] }
}

sub stream_average {
    my ($stream, $count) = @_;
    my $sum = 0;
    for my $tally (1 .. $count) {
        my $n = $stream->next_value;
        $sum += $n;
        say $tally, "\t$n\t$sum / $tally\t", $sum / $tally;
    }
}

say '10 + 10';
stream_average('Stream::TenPlusTen'->new(), 10);

say 'Fibonacci';
stream_average('Stream::Fibonacci'->new(), 10);
