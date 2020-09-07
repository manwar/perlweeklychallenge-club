use v6;

my ($dict, $grid-file) = @*ARGS;
my $min-length = @*ARGS[2]:exists ?? @*ARGS[2] !! 5;
my $words = $dict.IO.lines.grep({.chars >= $min-length}).Set;
my @grid;
for  $grid-file.IO.lines -> $line {
    my @letters = $line.lc.split(' ');
    push @grid, @letters;
}
my $max_row = @grid.end;
my $max_col = @grid[0].end;
my $result = SetHash.new;

sub find_words (@row) {
    for 0 .. @row.end -> $i {
        for $i+$min-length-1 .. @row.end -> $j {
            my $word = join '', @row[$i..$j];
            $result{$word}++ if $words{$word};
            my $flipped = $word.flip;
            $result{$flipped}++ if $words{$flipped};
        }
    }
}
# Horizontal
for @grid -> @row {
    find_words @row;
}
# Vertical
for 0..$max_col -> $i {
    my @col = map { @grid[$_][$i] }, 0..$max_row;
    find_words @col;
}
# Oblique, NW to SE
for 0..$max_col - $min-length + 1 -> $i {
    my @vals = grep {defined $_}, map { @grid[$_][$_+$i] }, 0..$max_row;
    find_words @vals;
}
for 1..$max_row-$min-length+1 -> $j {
    my @vals = grep {defined $_}, map { @grid[$_+$j][$_]}, 0..$max_row;
    find_words @vals;
}
# Oblique, NE to Sw
for $min-length - 1 .. $max_col -> $j {
    my @vals = grep {defined $_}, map { @grid[$j-$_][$_] }, 0..$max_col;
    find_words @vals;
}
for 1 ..$max_row - $min-length + 1 -> $i {
    my @vals = grep {defined $_}, map { @grid[$i+$_][$max_col-$_] },  0..$max_col;
    find_words @vals;
}
say join " ", sort keys $result;
