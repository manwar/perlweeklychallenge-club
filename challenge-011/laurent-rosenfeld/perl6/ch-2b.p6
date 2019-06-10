use v6;

sub prettify (@matrix) {
    @matrix.map({join(" ",$_)}).join("\n");
}
sub MAIN (Int $size where * > 0) {
    say prettify (1..$size).map( -> $i
         { (1..$size).map( { $_ == $i ?? 1 !! 0 })});
}
