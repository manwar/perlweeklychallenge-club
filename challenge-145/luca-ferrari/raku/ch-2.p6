#!raku
sub MAIN( Str $s = 'redivider' ) {

    my @roots;
    my @chars = $s.comb;

    for 0 ..^ @chars.elems -> $current {
        my $current-root = @chars[ $current ];


        for $current + 1 ..^ @chars.elems -> $other {
            next if @chars[ $other ] !~~ $current-root;

            my $string = @chars[ $current .. $other ].join;

            if ( $string ~~ $string.flip ) {
                @roots.push: [ $current-root, $string ];
                last;
            }
        }

        @roots.push: [ $current-root, '' ] if ! @roots.grep({  $_[ 0 ] ~~ $current-root } );
    }

    "$_[0] = $_[1]".say for @roots;
}
