#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Interval::Conflict::Naive;

    sub new { bless [], shift }

    sub add {
        my ($self, $interval) = @_;
        @$self = sort { $a <=> $b } @$self, @$interval;
    }

    sub is_conflicting {
        my ($self, $interval) = @_;
        for my $i (0 .. $#$self) {
            return 1
                if $interval->[0] <= $self->[$i]
                && $self->[$i] <= $interval->[1];

            my ($start, $edge) = @{ ([$i, 0], [$i - 1, 1])[$i % 2] };
            return 1
                if $self->[$start] <= $interval->[$edge]
                && $interval->[$edge] <= $self->[ $start + 1 ];
        }
        return 0
    }
}

{   package Interval::Conflict::Binary;
    use parent -norequire => 'Interval::Conflict::Naive';

    sub add {
        my ($self, $interval) = @_;
        my $i = $self->_locate($interval->[0]);
        splice @$self, $i, 0, @$interval;
    }

    sub is_conflicting {
        my ($self, $interval) = @_;
        my $i = $self->_locate($interval->[0]);
        return 0 if $i > $#$self;

        $i -= $i % 2;
        return 1
            if $interval->[0] <= $self->[$i]
            && $self->[$i] <= $interval->[1];

        my ($start, $edge) = @{ ([$i, 0], [$i - 1, 1])[$i % 2] };
        return 1
            if $self->[$start] <= $interval->[$edge]
            && $interval->[$edge] <= $self->[ $start + 1 ];

        return 0
    }

    sub _locate {
        my ($self, $value) = @_;

        my ($from, $to) = (0, $#$self);
        while ($to - $from > 1) {
            my $middle = int(($from + $to) / 2);
            if ($value < $self->[$middle]) {
                $to = $middle;
            } else {
                $from = $middle;
            }
        }

        my $r;
        if (@$self && $value <= $self->[$from]) {
            $r = $from;
        } else {
            $r = $to < 0 ? 0
                         : $to + ($self->[-1] < $value);
        }

        return $r
    }
}

sub conflict_intervals {
    my ($class, @intervals) = @_;
    my $il = $class->new;
    my @conflicts;
    for my $interval (@intervals) {
        if ($il->is_conflicting($interval)) {
            push @conflicts, $interval;
        } else {
            $il->add($interval);
        }
    }
    return \@conflicts
}

use Test2::V0;
plan 3;

my $class;
sub test {
    conflict_intervals($class, @_);
}

for my $c ('Interval::Conflict::Naive',
           'Interval::Conflict::Binary',
) {
    subtest $c => sub {
        plan 7;
        $class = $c;

        is test([1, 4], [3, 5], [6, 8], [12, 13], [3, 20]),
            [[3, 5], [3, 20]],
            'Example 1';

        is test([3, 4], [5, 7], [6, 9], [10, 12], [13, 15]),
            [[6, 9]],
            'Example 2';

        is test([10, 12], [1, 3], [8, 11], [2, 4],
                [2, 11], [0, 1], [12, 14], [4, 9], [0, 15]),
                    [[8, 11], [2, 4], [2, 11], [0, 1], [12, 14], [0, 15]],
                    'Cover all';

        is test([2, 4], [6, 8], [10, 12], [14, 16], [5, 13]),
            [[5, 13]],
            'Cover some';

        is test([2, 4], [1, 5]),
            [[1, 5]],
            'Cover single';

        is test([2, 5], [3, 4]),
            [[3, 4]],
            'Inside';

        is test([2, 5], [2, 5], [6, 8], [6, 7], [9, 11], [10, 11]),
            [[2, 5], [6, 7], [10, 11]],
            'Exact';
    };
}

use Benchmark qw{ cmpthese };

say {*STDERR} 'seed ', srand($$ + time);
my @L = map { my $x = int rand 1000; [$x, $x + 1 + int rand 10] } 1 .. 2000;

is conflict_intervals('Interval::Conflict::Naive', @L),
    conflict_intervals('Interval::Conflict::Binary', @L),
    "naive same as binary";

cmpthese(-3, {
    naive  => sub { conflict_intervals('Interval::Conflict::Naive', @L) },
    binary => sub { conflict_intervals('Interval::Conflict::Binary', @L) },
});
