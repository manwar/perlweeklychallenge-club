sub MAIN( *@n where *.elems > 0 ) 
{
    say [+] @n.combinations( 2 ).map: -> ( Int $a, Int $b )
    {
        ( $a +^ $b ).base( 2 ).indices( 1 )
    }
}