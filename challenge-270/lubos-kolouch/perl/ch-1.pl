use strict;
use warnings;
use List::Util qw(all);

sub num_special_positions {
    my ($matrix)      = @_;
    my $rows          = scalar(@$matrix);
    my $cols          = scalar( @{ $matrix->[0] } );
    my $special_count = 0;

    for my $i ( 0 .. $rows - 1 ) {
        for my $j ( 0 .. $cols - 1 ) {
            if ( $matrix->[$i][$j] == 1 ) {
                my $row_check = all { $_ == 0 }
                  @{ $matrix->[$i] }[ 0 .. $j - 1, $j + 1 .. $cols - 1 ];
                my $col_check = all { $_ == 0 }
                  map { $matrix->[$_][$j] } grep { $_ != $i } 0 .. $rows - 1;
                if ( $row_check && $col_check ) {
                    $special_count++;
                }
            }
        }
    }

    return $special_count;
}

# Example 1
my $matrix1 = [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ];
print num_special_positions($matrix1) == 1 ? "Pass\n" : "Fail\n";

# Example 2
my $matrix2 = [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ];
print num_special_positions($matrix2) == 3 ? "Pass\n" : "Fail\n";
