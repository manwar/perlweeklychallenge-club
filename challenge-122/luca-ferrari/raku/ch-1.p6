#!raku

multi sub MAIN( *@N where { @N.elems == @N.grep( * ~~ Int ).elems }) {
    my @average;
    @average.push: (@N[ 0 .. @average.elems - 1 ].sum + $_) / ( @average.elems + 1 ) for @N;
    

    @average.say;
}


multi sub MAIN() {
    "Insert a number at time".say;

    my @average;
    my $sum = 0;
    for lines() {
        "Not a number".say && next if $_ !~~ / \d+ /;
        $sum += $_;
        @average.push: $sum / ( @average.elems + 1 );
        "Average trend so far: { @average.say }";
        
    }
}
