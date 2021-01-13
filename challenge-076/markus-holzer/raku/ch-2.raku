unit sub MAIN($words-file, $board-file);

my @words = $words-file.IO.lines;
my @chars = $board-file.IO.slurp.comb( /\H/ );
my $width = @chars.first( "\n", :k ) + 1;

.Str.say for words-in rotated-chars.flat.join;

sub words-in( $text ) {
    $text ~ "\n" ~ $text.flip ~~ m:ex:i/@words/ }

sub rotated-chars {
    @chars.batch( $width ),
    |( (0,0), (0,1), (1,0) ).map: &rotate-chars }

sub rotate-chars( @offsets ) {
    (^$width).map: -> $start {
        | @chars[ ($start + @offsets[0]), ($start + $width + @offsets[1]) ... * ], "\n" } }