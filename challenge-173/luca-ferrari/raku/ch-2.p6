#!raku

# Perl Weekly Challenge 173

sub MAIN( Int $limit = 10 ) {
    my @sly = 2, 3;

    while ( @sly.elems < $limit ) {
        @sly.push: ( [*] @sly ) + 1;
    }

    @sly.join( "\n" ).say;
}
