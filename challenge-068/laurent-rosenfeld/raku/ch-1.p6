use v6;

sub display (@mat) {
    .say for @mat; say "";
}

my @matrix = [1, 1, 1], [1, 0, 1], [1, 1, 1], [1, 1, 1];
display @matrix;

my @cols;
for 0..@matrix.end -> $i {
  my $row = False;
    for 0..@matrix[$i].end -> $j {
        if @matrix[$i][$j] == 0 {
            $row = True;
            push @cols, $j;
        }
    }
    @matrix[$i] = [0 xx @matrix[$i].elems] if $row;
}
for @cols -> $j {
    @matrix[$_][$j] = 0 for 0..@matrix.end;
}
display @matrix;
