sub MAIN( Int $number ) {
    my $persistence = 0;
    my $root = $number;

    while ( $root >= 10 ) {
    	$root = [+] $root.Str.comb.map( *.Int );
    	$persistence++;
    }

    "Persistence : $persistence \nRoot : $root".say;

}
