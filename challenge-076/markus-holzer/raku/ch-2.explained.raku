unit sub MAIN($words-file, $board-file);

my @words = $words-file.IO.lines;
say "Looking for words:";
dd @words;

my @chars = $board-file.IO.slurp.comb( /\H/ );
say "Grid:\n", @chars.join;
say "Searching these characters:";
dd @chars;

my $width = @chars.first( "\n", :k ) + 1;
say "Grid has a width of {$width}";

my $rotated-chars = rotated-chars;
say "Data after rotation";
dd $rotated-chars;

my $search-text = $rotated-chars.flat.join;
say "Final text to search:";
dd $search-text;

say "Results:";
.Str.say for words-in $search-text;

sub words-in( $text ) {
    $text ~ "\n" ~ $text.flip ~~ m:ex:i/@words/ }

sub rotated-chars {
    eager                   # just so the output is in the right order
    @chars.batch( $width ), # horizontal lines
    | (
        (0,0),              # vertical lines
        (0,1),              # left to right diagonal
        (1,0)               # right to left diagonal
    ).map: &rotate-chars }

sub rotate-chars( @offsets ) {
    say "Rotate the grid with offsets";
    dd @offsets;

    eager
    (^$width).map: -> $start {
        my $first = $start + @offsets[0];
        my $next  = $start + $width + @offsets[1];
        say "Line {$start}, Indices: {$first}, {$next} ... *";
        | @chars[  $first, $next ... * ], "\n";
    }
}