#!/usr/bin/perl
use 5.020;
use warnings;

my @output;

my @player_ages = (
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ],
);

my @player_names = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
);

my $col0length = 0;
my $col1length = 0;
my $col2length = 0;

for my $r (@player_ages) {
    for my $s (@player_names) {
        if ($r->[1] eq $s->[0]) {

            push @output, [ $r->[0], "\"$r->[1]\"", "\"$s->[1]\"" ];

            if (length $r->[0] > $col0length) {
                $col0length = length $r->[0];
            }

            if (length $r->[1] > $col1length) {
                $col1length = length $r->[1];
            }

            if (length $s->[1] > $col2length) {
                $col2length = length $s->[1];
            }
        }
    }
}

for my $row (sort { $a->[1] cmp $b->[1] } @output) {
    printf
        "%-${\($col0length + 1)}s %-${\($col1length + 3)}s %-${\($col2length + 2)}s\n",
        $row->[0] . q{,}, $row->[1] . q{,}, $row->[2];
}
