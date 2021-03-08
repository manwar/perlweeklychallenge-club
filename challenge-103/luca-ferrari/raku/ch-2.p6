#!raku


sub MAIN( Int $start-ms where { $start-ms > 0 },
          Int $now-ms where { $now-ms >= $start-ms },
          Str $filename ) {

    # lookup file name and tracks
    my @tracks;
    for $filename.IO.lines {
        my ( $ms, $track ) = .split: ',';
         @tracks.push: { time => $ms,
                         track => $track };
    }

    # try to reach the end of the time
    my $diff = $now-ms - $start-ms;
    my $last-track = 0;
    while ( $diff > 0 ) {
        $last-track = 0;
        for @tracks.kv -> $index, $track {
            $diff -= $track< time >;
            last if ( $diff <= 0 );
            $last-track = $index;
        }
    }

    "Now playing { @tracks[ $last-track ]<track> } ".say;
}
