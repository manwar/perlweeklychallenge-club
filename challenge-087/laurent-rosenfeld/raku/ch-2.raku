use v6;

my @matrices =
    [ [ <0 1 0 1> ], [ <0 0 1 0> ], [ <1 1 0 1> ], [ <1 1 0 1> ] ],
    [ [ <1 1 0 1> ], [ <1 1 0 0> ], [ <0 1 1 1> ], [ <1 0 1 1> ] ],
    [ [ <0 1 0 1> ], [ <1 0 1 0> ], [ <0 1 0 0> ], [ <1 0 0 1> ] ],

    [ [ <1 1 0 1 1 1> ], [ <1 1 1 0 1 0> ],
        [ <1 1 0 1 0 1> ], [ <1 1 1 0 0 1> ]
    ],

    [ [ <0 0 0 1 0 0> ], [ <1 1 1 0 0 0> ],
      [ <0 0 1 0 0 1> ], [ <1 1 1 1 1 0> ], [ <1 1 1 1 1 0>],
    ],

    [ [ <0 0 0 1 1 1> ], [ <1 1 1 1 1 1> ],
      [ <0 0 1 0 0 1> ], [ <0 0 1 1 1 1> ],
      [ <0 0 1 1 1 1> ],
    ];

for @matrices -> @m {
    print-matrix @m;
    find-rect @m;
}
sub print-matrix (@matrix) {
    say "[ $_ ]" for @matrix;
    say "";
}

sub find-rect (@m) {
    my $max-h = @m.end;
    my $max-w = @m[0].end;
    my @positions =  ((0..$max-h) X  (0..$max-w))
        .grep({@m[$_[0]][$_[1]] == 1});
    # say @positions;
    my @pairs = @positions.combinations: 2;
    # say @pairs;
    my @eligible = gather {
        for @pairs -> $p {
            next if $p[0][0] > $p[1][0] or $p[0][1] > $p[1][1];
            next if @m[$p[0][0]..$p[1][0];$p[0][1]..$p[1][1]].any == 0;
            take $p;
        }
    }
    say "0\n" and return unless @eligible;
    my $rect = (reverse sort {
            ($_[1][0] - $_[0][0] + 1) * ($_[1][1] - $_[0][1] + 1)
            }, @eligible)[0];
    say  "Rectangle corners: ", $rect;
    for $rect[0][0]..$rect[1][0] -> $row {
        say @m[$row][$rect[0][1]..$rect[1][1]];
    }
    say "";
}
