#!/usr/bin/perl
use warnings;
use strict;

my $NO_X = qr/[^X] [^X] [^X]/;

sub lonely_x {
    my ($input) = @_;

    my ($previous, @check);
    my $count = 0;
    my $verify = sub {
        for my $ch (@check) {
            $count += substr($_[0], $ch - 2, 5) =~ $NO_X;
        }
    };

    open my $in, '<', \$input;
    while (<$in>) {
        $previous //= ' ' x length;
        $verify->($_);
        @check = ();

        while (/(?=[^X] X [^X])/g) {
            my $pos = pos;
            push @check, $pos + 2 if substr($previous, $pos, 5) =~ $NO_X;
        }
        $previous = $_;
    }
    $verify->(' ' x length $previous);

    return $count
}

use Test::More tests => 5;

is lonely_x(<< '__'),
[ O O X ]
[ X O X ]
[ X O O ]
__
0, 'None found';

is lonely_x(<< '__'),
[ O O X ]
[ X O O ]
[ X O O ]
__
1, 'Example 1';

is lonely_x(<< '__'),
[ O O X O ]
[ X O O O ]
[ X O O X ]
[ O X O O ]
__
2, 'Example 2';

is lonely_x(<< '__'),
[ O O O X O X X ]
[ X O O O O O O ]
[ O O O O X O X ]
[ O O X O O O O ]
[ O X O O X O O ]
[ X O O O X O X ]
__
5, 'Five';

is lonely_x(<< '__'),
[ X X X X O X O O O O O X X X X X O O O O O O X X X X O O X X X O O O O X O O ]
[ O O O O O O X O X O X O O O O X O X X X X O O X X X X O X O X O O X O O X X ]
[ O X O X X O O O O O O X X X O O O X O X O X X X O O X O O O O X O X X X O X ]
[ O X O X X O O O O X O X O O X X X O X O O X O X O X O O O X X O X O X X X X ]
[ O O X X X O O O X O X O O X O X O O X X O X O X X O X X O X X O O O O O O X ]
[ O O O X X X O O O O O O O X O X X O X O O O O O X X X O X X O O O O X O O O ]
[ O X X X X X O O X O X X O O X O X X X O X O O X O X O X X O X O O X X X X X ]
[ O O O X O X X X O O X X O X X O X O O O O X O X X X O X X O O X O O O X O O ]
[ X O X X X O O O O O X O X O O O O O O X X O X O O O O O X O O O X O X O O X ]
[ X X X O O O X O O O O X O X O X O X O O X X X O X X O O X X X O O O O O O O ]
[ X O X O X O X O X X O O X X X X X X X X X X X O X X O X O O O X O O O X O O ]
[ X O X O O X O X X O X O X O X X O X X O O X O O O X X X O O O X X X O X O X ]
[ O X O O X X X O X X O O O O O X O O O X O O O X X X X O X X O O X X O O X O ]
[ X O O O X O X X O O X O O O X X O X O O O X X X O X O X O O O X O X O X X O ]
[ X X X X X X X O X O X O O O X O O X O X X X X O O O O X X X O O O X X O X X ]
[ O X X O O X X X O O X X O X O O O X O X O X X O O X O O X O O O O O O O O X ]
[ O X O X O O O X O X O X O O O O X X X O X X O O X X O X X X O O X O X X O O ]
[ O O X O X O O X X X X O O X O X O O X O X O X X X O X X O X X O O X X X O X ]
[ O X X O O O O X O O O O O X X O O X X O X O X O X O O X O O X O X O X O X O ]
[ O X X O X X X X O O X X X X O X O O X O X O X O O O X O X X X X O O X X X X ]
[ O O O O O O O X X X X O O X O O X X O O O X O O X O X O X O O X X O O O O X ]
[ O O X O X O O X X X O O X X X X O O X X X X X X X O O X O O O X O O O X O X ]
[ X O X O X O O X O X O X X O X O X O X X X O O O O X X X X X X X O X O O X O ]
[ O O X O O X O X O X O O O O O O O O X O X O O O O X X O X X X X O X X X O X ]
[ X X X X X O O X O X X X O X X X O O X O X O X O O O O O O O O O O O O X O X ]
[ X O O O O X X O O O O O O X X X O O O O X X O O O X X O O X O O X X O X X O ]
[ O X O X X O O O X X X X X O X O X X X X O X O X O O O O X O O O O O O X O X ]
[ X X O O O X O X X X O X X X O X O X O O O X X O O X X X O X O O O O O X O X ]
[ O X X X X X X X O O O X O O X O O X O O X O X X O X X X X X X O O X O X O X ]
[ O X X X X O O X O X O X X O X O X X O O O O O O X X O X X O O O O O X O O X ]
[ X O O X O O X O X O X O O X X O X O X O X O X O O X O X X O X O O X O X O O ]
[ O X O O X X X O X O X O O O O X O O X O X X X X O O X O O X X O O O O O X X ]
[ X X O X X O O O X X X O X O O O X X O X X O X X O X O O X X X O O O O O X O ]
[ O O X X X X X X X O X X X X O O X O X O X X X O O X X X X O O O X O O O O X ]
[ O X O O X X X O X O X O O O O X X X O O O O O O X O X X X O X O X X X X O O ]
[ X X X O O O O O X O O X X X O O O O X O O X X O O X O O X O X O X X X O X X ]
[ X X O X O X X O O O X X X O X O X X X X X X X O X X X X X O O X O X O X X X ]
[ X X O O O O X X X X O O X X X O O O O X O O X O X O O O X O O O O X O X X X ]
[ X O O X O O O X X X X X X O O O X O O X X X O X O X X X X X O X O O X X X O ]
[ O X O O O X O O O X O X O O X O O X O O O O X X X O X X X O X O O O O O X O ]
__
6, 'Six';
