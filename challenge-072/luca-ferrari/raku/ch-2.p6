#!raku


sub MAIN( Str $file-name,
          Int $A where { $A > 0 },
          Int $B where { $B >= $A } ) {
    my $line-counter = 0;
    for $file-name.IO.lines -> $line {
        $line.say if ( $A <= ++$line-counter <= $B );
    }
}
