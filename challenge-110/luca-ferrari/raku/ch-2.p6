#!raku

sub MAIN( Str $file-name = 'people.txt' ) {

    my @content;
    @content.push: .split( ',' ) for $file-name.IO.lines;

    for 0 ..^ @content[ 0 ].elems -> $column {
        my @row.push:  @content[ $_ ][ $column ] for 0 ..^ @content.elems;
        @row.join( ',' ).say;
    }
}
