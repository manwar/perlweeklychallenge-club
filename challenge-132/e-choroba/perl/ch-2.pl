#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

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

sub hash_join {
    my ($build, $probe, $limit) = @_;
    my @out;
    my %hash;
    my $size = 0;
    my $out = sub {
        for my $s (@$probe) {
            push @out, [$_, $s->[0], $s->[1]]
                for @{ $hash{ $s->[0] } // []};
        }
        %hash = ();
        $size = 0;
    };
    for my $r (@$build) {
        push @{ $hash{ $r->[1] } }, $r->[0];
        $out->() if ++$size >= $limit;
    }
    $out->();
    return \@out
}

use Test2::V0;
plan 6;

for my $limit (1 .. 6) {
    is hash_join(\@player_ages, \@player_names, $limit),
        bag {
            item [20, "Alex", "Stewart"];
            item [20, "Alex", "Jones"];
            item [18, "Alex", "Stewart"];
            item [18, "Alex", "Jones"];
            item [28, "Joe", "Root"];
            item [28, "Joe", "Blog"];
            item [38, "Mike", "Gatting"];
            item [18, "Simon", "Duane"];
            end();
        }, "Limit $limit";
}
