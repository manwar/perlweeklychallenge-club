sub load-grid(Str $file-path) {
    my @grid = $file-path.IO.lines.map(*.comb);
    return @grid;
}

sub load-words(Str $file-path) {
    my %words = $file-path.IO.lines.map({ $_ => True }).hash;
    return %words;
}

sub find-words-in-grid(@grid, %words) {
    my @found-words;
    my @directions = (-1, 0, 1) X (-1, 0, 1) ->> grep { $_.head != 0 || $_.tail != 0 };
    my $rows = @grid.elems;
    my $cols = @grid[0].elems;

    for 0..^$rows -> $row {
        for 0..^$cols -> $col {
            for @directions -> ($dx, $dy) {
                my ($x, $y) = ($row, $col);
                my $word = '';
                while $x >= 0 && $x < $rows && $y >= 0 && $y < $cols {
                    $word ~= @grid[$x][$y];
                    @found-words.push($word) if %words{$word}:exists;
                    ($x, $y) = ($x + $dx, $y + $dy);
                }
            }
        }
    }
    return @found-words;
}

# Example usage
# Replace the file paths with the actual paths to your grid and words files
my $grid-file = 'grid.txt';
my $words-file = 'words.txt';

my @grid = load-grid($grid-file);
my %words = load-words($words-file);
my @found-words = find-words-in-grid(@grid, %words);

say "Found words:";
say $_ for @found-words;

