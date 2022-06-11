#! /usr/bin/perl
use warnings;
use strict;

{   package Pisano;
    sub new  {
        my ($class, $n) = @_;
        bless [$n, [1, 1]], $class
    }

    sub Next {
        my ($self) = @_;
        push @{ $self->[1] },
            ((my $f = shift @{ $self->[1] }) + $self->[1][0]) % $self->[0];
        return $f
    }
}

sub pisano_period {
    my ($n) = @_;
    my $f = 'Pisano'->new($n);
    my $period = "0";
    until ($period =~ /^(.+) \1/) {
        $period .= ' ' . ($f->Next);
    }
    my $length = split / /, $period;
    return $length / 2
}

use Test::More tests => 4;

is pisano_period(3), 8, 'pi(3)';
is pisano_period(2), 3, 'pi(2)';
is pisano_period(10), 60, 'pi(10)';
is pisano_period(50), 300, 'pi(50)';
