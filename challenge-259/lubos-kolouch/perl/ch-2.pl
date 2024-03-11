use strict;
use warnings;

sub load_grid {
    my ($file_path) = @_;
    open my $fh, '<', $file_path or die "Could not open file: $!";
    my @grid = map { [ split ' ', $_ ] } <$fh>;
    close $fh;
    return \@grid;
}

sub load_words {
    my ($file_path) = @_;
    open my $fh, '<', $file_path or die "Could not open file: $!";
    my %words = map { chomp; $_ => 1 } <$fh>;
    close $fh;
    return \%words;
}

sub find_words_in_grid {
    my ( $grid, $words ) = @_;
    my @found_words;
    my @directions = (
        [ -1, -1 ], [ -1, 0 ],  [ -1, 1 ], [ 0, -1 ],
        [ 0,  1 ],  [ 1,  -1 ], [ 1,  0 ], [ 1, 1 ]
    );

    my $rows = @$grid;
    my $cols = @{ $grid->[0] };

    for my $row ( 0 .. $rows - 1 ) {
        for my $col ( 0 .. $cols - 1 ) {
            foreach my $dir (@directions) {
                my ( $dx, $dy ) = @$dir;
                my ( $x,  $y )  = ( $row, $col );
                my $word = '';
                while ( $x >= 0 && $x < $rows && $y >= 0 && $y < $cols ) {
                    $word .= $grid->[$x][$y];
                    push @found_words, $word if exists $words->{$word};
                    $x += $dx;
                    $y += $dy;
                }
            }
        }
    }
    return \@found_words;
}

# Example usage
# Replace the file paths with the actual paths to your grid and words files
my $grid_file  = 'grid.txt';
my $words_file = 'words.txt';

my $grid        = load_grid($grid_file);
my $words       = load_words($words_file);
my $found_words = find_words_in_grid( $grid, $words );

print "Found words:\n";
print "$_\n" foreach @$found_words;
