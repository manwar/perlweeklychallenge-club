unit sub MAIN($words-file, $board-file);

my @words = $words-file.IO.lines;
my @board = $board-file.IO.slurp.subst( ' ', :g ).lines;
my $width = @board.head.chars;
my @chars = @board.map: |*.comb;

.Str.say for words-in rotated-data.flat.join;

sub words-in( $text ) {
    $text ~'~'~ $text.flip ~~ m:ex:i/@words/ }

sub rotated-data {
    @chars.batch( $width ), |( (0,0), (0,1), (1,0) ).map: &rotate-data }

sub rotate-data( @offsets ) {
    (^$width).map: { @chars[ ($_ + @offsets[0]), ($_ + $width + @offsets[1]) ... * ] } }
