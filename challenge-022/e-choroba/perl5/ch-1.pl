#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Primes;

    sub new { bless [2], shift }

    sub is_prime {
        my ($self, $n) = @_;

        $self->extend_to($n) if $n > $self->[-1];
        return grep $_ == $n, @$self
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
}

my $p = 'My::Primes'->new;
my @sexy;
my $i = 3;
while (@sexy < 10) {
    push @sexy, [$i, $i + 6] if $p->is_prime($i) && $p->is_prime($i + 6);
    $i += 2;
}
say "@$_" for @sexy;
