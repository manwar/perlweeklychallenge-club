#!/usr/bin/env perl
#
=head1 Task 2: Seven Segment 200

Submitted by: Ryan J Thompson

A seven segment display is an electronic component, usually used to display
digits. The segments are labeled 'a' through 'g' as shown:

       a
    +-----+
   f|     |b
    |  g  |
    +-----+
   e|     |c
    |  d  |
    +-----+

    Seven Segment

The encoding of each digit can thus be represented compactly as a truth table:

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

For example, $truth[1] = 'bc'. The digit 1 would have segments 'b' and 'c'
enabled.

Write a program that accepts any decimal number and draws that number as a
horizontal sequence of ASCII seven segment displays, similar to the following:

    -------  -------  -------
          |  |     |  |     |
          |  |     |  |     |
    -------
    |        |     |  |     |
    |        |     |  |     |
    -------  -------  -------

To qualify as a seven segment display, each segment must be drawn (or not
drawn) according to your @truth table.

The number "200" was of course chosen to celebrate our 200th week!

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [200, <<'EOD'],
 -----  -----  ----- 
      ||     ||     |
      ||     ||     |
 -----               
|      |     ||     |
|      |     ||     |
 -----  -----  ----- 
EOD
];

package Diginum
{
    #  0123456
    #     a
    #0  -----
    #1 |b    |f
    #2 |  d  |
    #3  -----
    #4 |c    |g
    #5 |  e  |
    #6  -----

    my $segments = {
        a => {
            char => '-',
            coords => [
                [1, 0],
                [2, 0],
                [3, 0],
                [4, 0],
                [5, 0],
            ],
        },
        b => {
            char => '|',
            coords => [
                [0, 1],
                [0, 2],
            ],
        },
        c => {
            char => '|',
            coords => [
                [0, 4],
                [0, 5],
            ],
        },
        d => {
            char => '-',
            coords => [
                [1, 3],
                [2, 3],
                [3, 3],
                [4, 3],
                [5, 3],
            ],
        },
        e => {
            char => '-',
            coords => [
                [1, 6],
                [2, 6],
                [3, 6],
                [4, 6],
                [5, 6],
            ],
        },
        f => {
            char => '|',
            coords => [
                [6, 1],
                [6, 2],
            ],
        },
        g => {
            char => '|',
            coords => [
                [6, 4],
                [6, 5],
            ],
        },
    };

    my $numbers = [
        [qw/a b c e f g/],   # 0
        [qw/f g/],           # 1
        [qw/a f d c e/],     # 2
        [qw/a f d g e/],     # 3
        [qw/b d f g/],       # 4
        [qw/a b d g e/],     # 5
        [qw/a b d c e g/],   # 6
        [qw/a f g/],         # 7
        [qw/a b c d e f g/], # 8
        [qw/a b f d g/],     # 9
    ];

    sub new
    {
        my $class = shift;
        my $self = {
            _num => [],
        };
        return bless $self, $class;
    }

    sub add_digit
    {
        my $self = shift;
        my $num = $self->{_num};
        my $digit = shift // 8;

        my $startcol = defined $num->[0] ? $num->[0]->@* : 0;
        for my $row (0 .. 6) {
            push $num->[$row]->@*, (' ') x 7;
        }

        for my $d ($numbers->[$digit]->@*) {
            my $char = $segments->{$d}->{char};
            for my $c ($segments->{$d}->{coords}->@*) {
                $num->[$c->[1]]->[$c->[0]+$startcol] = $char;
            }
        }
    }

    sub add_pad
    {
        my $self = shift;
        my $num = $self->{_num};
        my $chr = shift // ' ';

        for my $row (0 .. 6) {
            push $num->[$row]->@*, $chr;
        }
    }

    sub print_num
    {
        my $self = shift;
        my $num = $self->{_num};

        for my $row (0 .. 6) {
            print join('', $num->[$row]->@*), "\n";
        }
    }

    sub get_num
    {
        my $self = shift;
        my $num = $self->{_num};

        my $ret;
        for my $row (0 .. 6) {
            $ret .= join('', $num->[$row]->@*) . "\n";
        }
        return $ret;
    }
}

sub seven_segment
{
    my $num = shift;

    my $diginum = Diginum->new();
    for my $n (split '', $num) {
        $diginum->add_digit($n);
    }
    $diginum->print_num();
    return $diginum->get_num();
}

for (@$cases) {
    is(seven_segment($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
