use strict;
use warnings;
use feature "say";

sub display_matrix {
    my $matrix = shift;
    for my $row (@$matrix) {
        say "[", join(", ", @$row), "]";
    }
}

sub rotate_90 {
    my $input = shift;
    my @output;
    for my $row (0 .. $#$input) {
        for my $col (0 .. $#{@$input[$row]}) {
            $output[$col][$#{@$input[$row]} - $row] = $input->[$row][$col];
        }
    }
  return \@output;
}
sub rotate_180 {rotate_90 rotate_90 @_}
sub rotate_270 {rotate_90 rotate_180 @_}

my $matrix_ref = [
    [1, 2 ,3],
    [4, 5, 6],
    [7, 8, 9],
];
say "Initial matrix:";
display_matrix($matrix_ref);
say "\nMatrix rotated 90°";
display_matrix rotate_90 $matrix_ref;
say "\nMatrix rotated 180°";
display_matrix rotate_180 $matrix_ref;
say "\nMatrix rotated 270°";
display_matrix rotate_270 $matrix_ref;
say "\nRotate 360 (sanity check, should be the initial matrix)";
display_matrix rotate_270 rotate_90 $matrix_ref;
