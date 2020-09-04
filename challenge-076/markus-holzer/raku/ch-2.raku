unit sub MAIN($words-file, $board-file);

my @words = $words-file.IO.lines;
my $width = $board-file.IO.lines.head.chars div 2 + 1;
my @chars = $board-file.IO.slurp.comb( /\w/ );

.Str.say for words-in rotated-data.flat.join;

sub words-in( $text ) {
    $text ~'~'~ $text.flip ~~ m:ex:i/@words/ }

sub rotated-data {
    @chars.batch( $width ), |( (0,0), (0,1), (1,0) ).map: &rotate-data }

sub rotate-data( @offsets ) {
    (^$width).map: { @chars[ ($_ + @offsets[0]), ($_ + $width + @offsets[1]) ... * ] } }
