use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @matrices =
    ( [ [ qw <0 1 0 1> ], [ qw <0 0 1 0> ],
        [ qw <1 1 0 1> ], [ qw <1 1 0 1> ]
      ],

      [ [ qw <1 1 0 1> ], [ qw <1 1 0 0> ],
        [ qw <0 1 1 1> ], [ qw <1 0 1 1> ]
      ],

      [ [ qw <0 1 0 1> ], [ qw <1 0 1 0> ],
        [ qw <0 1 0 0> ], [ qw <1 0 0 1> ]
      ],

      [ [ qw <1 1 0 1 1 1> ], [ qw <1 1 1 0 1 0> ],
          [ qw <1 1 0 1 0 1> ], [ qw <1 1 1 0 0 1> ]
      ],

      [ [ qw <0 0 0 1 0 0> ], [ qw <1 1 1 0 0 0> ],
          [ qw <0 0 1 0 0 1> ], [ qw <1 1 1 1 1 0> ],
          [ qw <1 1 1 1 1 0>],
      ],
      [ [ qw <1 0 1 0 1 0> ], [ qw <0 1 0 1 0 1> ],
          [ qw <1 0 1 0 1 0> ], [ qw <0 1 0 1 0 1> ],
      ],
      [ [ qw <0 0 0 1 1 1> ], [ qw <1 1 1 1 1 1> ],
          [ qw <0 0 1 0 0 1> ], [ qw <0 0 1 1 1 1> ],
          [ qw <0 0 1 1 1 1> ],
      ],
    );

for my $m_ref (@matrices) {
    print_matrix($m_ref);
    find_rect($m_ref);
}

sub print_matrix {
    my @matrix = @{$_[0]};
    say "";
    say "[ @$_ ]" for @matrix;
    say "";
}

sub find_rect {
    my @m = @{$_[0]};
    my $max_h = scalar @m;
    my $max_w = scalar @{$m[0]};
    my @positions;
    for my $i (0..$#m) {
        for my $j (0..$#m) {
            push @positions, [$i, $j] unless $m[$i][$j] == 0;
        }
    }
    my @pairs;
    for my $k (0..$#positions) {
        for my $n ($k+1..$#positions) {
            push @pairs, [ [@{$positions[$k]}], [@{$positions[$n]}] ];
        }
    }

    my @eligible;
    for my $p_ref (@pairs) {
        my @p = @$p_ref;
        next if $p[0][0] > $p[1][0] or $p[0][1] > $p[1][1];
        my $only_ones = 1;
        for my $i ($p[0][0].. $p[1][0]) {
            for my $j ($p[0][1]..$p[1][1]) {
                if ($m[$i][$j] == 0) {
                    $only_ones = 0;
                    next;
                }
            }
        }
         push @eligible, $p_ref if $only_ones;
    }

    say 0 and return unless @eligible;

my @sorted = map { $_->[0] }
             sort { $b->[1] <=> $a->[1] }
             map { [$_, ($_->[1][0] - $_->[0][0] + 1)
                   * ($_->[1][1] - $_->[0][1] + 1)] }
                   @eligible;
    my $rect = $sorted[0];
    say "Rectangle corners: ";
    say "@$_" for @$rect;
    say "\nRectangle:";

    for my $row ($rect->[0][0]..$rect->[1][0]) {
        say "@{$m[$row]}[$rect->[0][1]..$rect->[1][1]]";
    }
    say "";
}
