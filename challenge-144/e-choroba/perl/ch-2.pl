#!/usr/bin/perl
use warnings;
use strict;

{   package Ulam::Sequence;
    use Moo;

    has u        => (is => 'ro',   requried => 1);
    has v        => (is => 'ro',   required => 1);
    has sequence => (is => 'lazy', builder  => 1);

    sub extend {
        my ($self, $l) = @_;
        $l //= 1 + @{ $self->sequence };

        my $n = $self->sequence->[-1];
        while ($l != @{ $self->sequence }) {
            while (++$n) {

                my %seen;
                @seen{ @{ $self->sequence } } = (1) x @{ $self->sequence };

                for my $s (@{ $self->sequence }) {
                    ++$seen{$n - $s} unless $n - $s == $s;
                }
                my $twice = grep 2 == $_, values %seen;
                if ($twice && $twice < 3) {
                    push @{ $self->sequence }, $n;
                    last
                }
            }
        }
    }

    sub _build_sequence {
        my ($self) = @_;
        return [ $self->u, $self->v ]
    }
}

use Test2::V0;
plan 4;

my $us1 = 'Ulam::Sequence'->new(u => 1, v => 2);
$us1->extend(10);
is $us1->sequence, [1, 2, 3, 4, 6, 8, 11, 13, 16, 18], 'Example 1';

my $us2 = 'Ulam::Sequence'->new(u => 2, v => 3);
$us2->extend(10);
is $us2->sequence, [2, 3, 5, 7, 8, 9, 13, 14, 18, 19], 'Example 2';

my $us3 = 'Ulam::Sequence'->new(u => 2, v => 5);
$us3->extend(10);
is $us3->sequence, [2, 5, 7, 9, 11, 12, 13, 15, 19, 23], 'Example 3';

my $us4 = 'Ulam::Sequence'->new(u => 1, v => 3);
$us4->extend(10);
is $us4->sequence, [1, 3, 4, 5, 6, 8, 10, 12, 17, 21], '(1,3)-U';
