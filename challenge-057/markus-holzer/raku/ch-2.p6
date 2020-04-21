my $words = [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ];

.say for gather shortest-unique-prefixes( $words );

sub shortest-unique-prefixes( Array $words, Int $l = 1 )
{
    for $words.classify( *.substr(0, $l) )
    {
        take .key and next
            if .value.elems == 1;
        shortest-unique-prefixes( .value, $l + 1 )
    }
}