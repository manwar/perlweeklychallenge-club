#!raku
# Perl Weekly Challenge 160


sub MAIN( Int :$n! where { 0 < $n < 10 }, Int :$stop = 4 ) {
    my %words = 1 => 'One',
                2 => 'Two',
                3 => 'Three',
                4 => 'Four',
                5 => 'Five',
                6 => 'Six',
                7 => 'Seven',
                8 => 'Eight',
                9 => 'Nine';


    my $current = $n;
    while ( $current != $stop ) {
        "{ %words{ $current } } is { %words{ $current }.chars }".say and $current = %words{ $current }.chars;
    }

    "%words{ $stop } is magic".say;

}
