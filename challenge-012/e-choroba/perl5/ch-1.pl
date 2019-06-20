#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ product };

{   package My::Primes;

    sub new { bless [2], shift }

    sub is_prime {
        my ($self, $n) = @_;

        $self->extend_to($n) if $n > $self->[-1];
        return grep $_ == $n, @$self
    }

    sub is_prime2 {
        my ($self, $n) = @_;

        if ($n > $self->[-1]) {
            $self->extend_to($n);
            return $self->[-1] == $n

        } else {
            my ($from, $to) = (0, $#$self);
            while ($from != $to) {
                my $between = int(($from + $to) / 2);
                if ($n > $self->[$between]) {
                    $from = $between + 1;
                } else {
                    $to = $between;
                }
            }
            return $self->[$from] == $n
        }
    }

    sub extend_to {
        my ($self, $n) = @_;
        for my $p ($self->[-1] + 1 .. $n) {
            my ($i, $is) = (0, 1);
            while ($self->[$i] <= sqrt $p) {
                $is = 0, last if 0 == $p % $self->[$i++];
            }
            push @$self, $p if $is;
        }
    }

    sub size { scalar @{ $_[0] } }
}

####

{   use Test::More;

    my $p = 'My::Primes'->new;

    ok $p->is_prime(2);
    ok $p->is_prime(101);

    $p->extend_to(2060);
    is $p->[-1], 2053;

    done_testing();
}

####

my $p = 'My::Primes'->new;
my $size = 1;
my $e = 3;
while ($p->is_prime($e)) {
    ++$size;
    $e = 1 + product(@$p[0 .. $size - 1]);
}

say $e;

