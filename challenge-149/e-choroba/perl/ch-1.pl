#!/usr/bin/perl
use warnings;
use strict;

{   package Fibonacci::Digit::Sum;
    use Moo;

    use List::Util qw{ sum };
    use namespace::clean;

    has sequence_tail => (is      => 'ro',
                          default => sub { [0, 1] });
    has hash          => (is      => 'lazy',
                          builder => 1);

    sub is_fibonacci {
        my ($self, $n) = @_;
        return 1 if exists $self->hash->{$n};

        return if $n < $self->sequence_tail->[-1];

        $self->_extend($n);
        return $self->is_fibonacci($n)
    }

    sub fibonacci_digit_sum {
        my ($self, $size) = @_;
        my @results;
        my $n = 0;
        while (@results < $size) {
            my $s = sum(split //, $n);
            push @results, $n if $self->is_fibonacci($s);
            ++$n;
        }
        return \@results
    }

    sub _build_hash {
        my ($self) = @_;
        +{ map { $_ => undef } @{ $self->sequence_tail } }
    }

    sub _extend {
        my ($self, $n) = @_;
        while ($self->sequence_tail->[-1] < $n) {
            my $first = shift @{ $self->sequence_tail };
            push @{ $self->sequence_tail },
                sum($first, @{ $self->sequence_tail });
            $self->hash->{ $self->sequence_tail->[-1] } = undef;
        }
    }
}

use Test2::V0;
plan 2;

my $f = 'Fibonacci::Digit::Sum'->new;

is $f->fibonacci_digit_sum(20),
    [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44];

# We can use a generalised sequence with 3 elements, too.
# E.g. 1, 2, 3, 6, 11, 20, 37...

my $f2 = 'Fibonacci::Digit::Sum'->new(sequence_tail => [1, 2, 3]);
is $f2->fibonacci_digit_sum(20),
    [1, 2, 3, 6, 10, 11, 12, 15, 20, 21, 24,
     29, 30, 33, 38, 42, 47, 51, 56, 60];
