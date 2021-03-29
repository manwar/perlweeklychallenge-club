#!raku

sub MAIN( *@N where { @N.elems == @N.grep( * ~~ Int ).elems } ) {
    my @M = 0;
    my @n = @N.sort;
    @M.push: @n[ $_ + 1 ] - @n[ $_ ]  for 0 ..^ @n.elems - 1;
    say @M.max;

    # using a single scalar
    # my $max = 0;
    # $max = @n[ $_ + 1 ] - @n[ $_ ] > $max
    #                   ?? @n[ $_ + 1 ] - @n[ $_ ]
    #                   !! $max  for 0 ..^ @n.elems - 1;
    # say $max;
}
