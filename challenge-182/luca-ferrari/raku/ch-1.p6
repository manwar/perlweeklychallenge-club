#!raku

# Perl Weekly Challenge 182

sub MAIN( *@n ) {
    my %h;
    %h{ @n[ $_ ] } = $_ for 0 ..^ @n.elems;
    "{ %h{ $_ } }".say given %h.keys.max;
}
