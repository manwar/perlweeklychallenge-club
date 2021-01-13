use Test;

subset ExcelColumn of Str where * ~~ / ^ <[ A .. Z ]>+ $ /;
subset PositiveInt of Int where * > 0;

multi sub MAIN( ExcelColumn $c ) { say from-excel( $c ) }
multi sub MAIN( PositiveInt $n ) { say to-excel( $n ) }
multi sub MAIN( Bool:D :$t  )    { run-tests; }

sub to-excel( PositiveInt $n )
{
    multi ec( Int $i where * < 26 ) {
        ( $i + 65 ).chr }

    multi ec( Int $i ) {
        ec( $i div 26 - 1 ) ~ ec( $i % 26 ) }

    ec $n - 1;
}

sub from-excel( ExcelColumn $column )
{
    [+] $column.comb.map( *.ord - 64 ).reverse.kv.map: -> $i, $v {
        26 ** $i * $v
    }
}

sub run-tests( $n = 26**3 + 26**2 + 26 )
{
    for ( 'A', 'B' ... * ).kv -> $i, $v
    {
        last if $i == $n;
        ok to-excel( $i + 1 ) eq $v, "to-excel({ $i + 1 })";
        ok from-excel( $v ) eq $i + 1, "from-excel({ $v })";
    }

    dies-ok { from-excel( "AÜA" ) }, "bad input: Ü";
    dies-ok { to-excel( 0 ) }, "bad input: 0";
}
