#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Primes;

    sub new { bless [2, 3], shift }

    sub is_prime {
        my ($self, $n) = @_;

        $self->grow until $self->[-1] >= $n;

        return !! grep $_ == $n, @$self
    }

    sub grow {
        my ($self) = @_;
        my $candidate = $self->[-1];
        my $is = 0;
      PRIME:
        until ($is) {
            $candidate += 2;
            my $i = 0;
            $is = 1;
            while ($self->[$i] <= sqrt $candidate) {
                $is = 0, next PRIME if 0 == $candidate % $self->[$i++];
            }
        }
        push @$self, $candidate;
    }

    sub last_prime {
        $_[0][-1]
    }
}

my $p = 'My::Primes'->new;
my (@strong, @weak, @balanced);
while (@strong < 10 || @weak < 10) {
    $p->grow;
    push @{
        (\@balanced, \@strong, \@weak)[$p->[-2] <=> ($p->[-3] + $p->[-1]) / 2]
    }, $p->[-2];
}

say for "Strong: @strong[0 .. 9]",
        "Weak: @weak[0 .. 9]",
        "Balanced: @balanced";
