use Test;

sub excel-column( Int $n )
{
    state @digits = |('A'..'Z');

    multi ec( Int $i where * < 26 ) { 
	@digits[ $i ] }

    multi ec( Int $i ) {
        ec( $i div 26 - 1 ) ~ ec( $i % 26 ) }

    ec( $n - 1 );
}

ok excel-column( 1 ) eq 'A', 'A';
ok excel-column( 26 ) eq 'Z', 'Z';
ok excel-column( 27 ) eq 'AA', 'AA';
ok excel-column( 28 ) eq 'AB', 'AB';
ok excel-column( 26**3 + 26**2 + 26) eq 'ZZZ', 'ZZZ';
ok excel-column( 26**3 + 26**2 + 1) eq 'ZZA', 'ZZA';