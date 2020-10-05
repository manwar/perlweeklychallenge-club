unit sub MAIN( $file where $file.IO.f );

my $words = $file
    .IO
    .slurp
    .subst(/ <[ \. \" \( \) \, ]> | \'s | \-\- /, ' ', :g)
    .words
    .Bag;

my $freqs = $words
    .values
    .sort
    .squish;

for @$freqs -> $f {
    say join " ", $f, |$words
        .grep( *.value == $f )
        .sort
        .map: *.key }