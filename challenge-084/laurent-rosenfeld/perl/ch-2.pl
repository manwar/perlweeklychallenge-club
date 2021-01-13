use strict;
use warnings;
use feature "say";

my @mat = ( [ [ qw<0 1 0 1> ], [ qw<0 0 1 0> ], [ qw<1 1 0 1> ],
              [ qw<1 0 0 1> ] ],
            [ [ qw<1 1 0 1> ], [ qw<1 1 0 0> ], [ qw<0 1 1 1> ],
              [ qw<1 0 1 1> ] ],
            [ [ qw<0 1 0 1> ], [ qw<1 0 1 0> ], [ qw<0 1 0 0> ],
              [ qw<1 0 0 1> ] ],
            [ [ qw<1 1 0 1 0 1> ], [ qw<1 0 1 0 1 1> ],
              [ qw<1 1 0 0 1 0> ], [ qw<1 1 0 1 1 1> ] ],
          );

for my $m_ref (@mat) {
    print_matrix($m_ref);
    say "Number of matrices: ", find_squares($m_ref);
}
sub print_matrix {
    my @matrix = @{$_[0]};
    say "";
    for my $row (@matrix) {
        say '[ ', join (" ", @$row), ' ]';
    }
    say " ";
}

sub find_squares {
    my @matrix = @{$_[0]};
    my $nb_lines = scalar @matrix;
    my $nb_col = scalar @{$matrix[0]};
    my $nb_squares = 0;
    my $max_square_size = $nb_lines > $nb_col ? $nb_col : $nb_lines;
    for my $square_size (2..$max_square_size) {
        for my $j (0..$nb_col - $square_size) {
            for my $i (0..$nb_lines - $square_size) {
                next if $matrix[$i][$j] == 0;
                next if $matrix[$i][$j+$square_size-1] == 0;
                next if $matrix[$i+$square_size-1][$j] == 0;
                next if $matrix[$i+$square_size-1][$j+$square_size-1] == 0;
                say "Value in position $i, $j is the top left corner of a square of size $square_size";
                $nb_squares++;
            }
        }
    }
    return $nb_squares;
}
