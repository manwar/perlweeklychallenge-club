#!raku

# Perl Weekly Challenge 179

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems } ) {
    my @symbols = '▁' ... '█';
    my ($min, $max) = @n.min, @n.max;
    my @graph = @n.map: { ( $_ - $min ) / ( $max - $min ) * @n.elems };
    @symbols[ @graph ].join.say;
}
