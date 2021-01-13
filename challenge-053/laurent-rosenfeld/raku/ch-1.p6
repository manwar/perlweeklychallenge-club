use v6;

sub display_matrix (@matrix) {
    for @matrix -> $row {
        say "[", join(", ", $row), "]";
    }
}
sub rotate_90 (@input) {
    my @output;
    for 0 .. @input.end -> $row {
        for 0 .. @input[$row].end -> $col {
            @output[$col][@input[$row].end - $row] = @input[$row][$col];
        }
    }
  return @output;
}
sub rotate_180 (@matrix) {rotate_90 rotate_90 @matrix}
sub rotate_270 (@matrix) {rotate_90 rotate_180 @matrix}

my $matrix = (
    [1, 2 ,3],
    [4, 5, 6],
    [7, 8, 9],
);
say "Initial matrix:";
display_matrix($matrix);
say "\nMatrix rotated 90°";
display_matrix rotate_90 $matrix;
say "\nMatrix rotated 180°";
display_matrix rotate_180 $matrix;
say "\nMatrix rotated 270°";
display_matrix rotate_270 $matrix;
say "\nRotate 360 (sanity check, should be the initial matrix)";
display_matrix rotate_270 rotate_90 $matrix;
