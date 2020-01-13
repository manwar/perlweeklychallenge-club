use Test;

# all self-descriptive numbers 
# - must be at least base digits long
# - have digit sums equal to their base, 
# - are multiples of that base 
# - each digit d at position n counts how many instances of digit n are in m

multi sub MAIN( Int $base where $_ < 37 )
{
    .base( $base ).say for 
        self-descriptive-candidates( $base )
        .grep({ is-self-descriptive( $_, $base ) });
}


multi sub MAIN( "test" ) 
{
    ok base-start( 2 )  == 2;
    ok base-start( 10 ) == 1000000000;
    ok base-start( 16 ) == 0x1000000000000000;

    # test values from Wikipedia
    ok is-self-descriptive( parse-base('21200',5), 5 );
    ok is-self-descriptive( 0xC210000000001000, 16 );
    ok is-self-descriptive( 6210001000, 10 );
    ok !is-self-descriptive( 3210001000, 10 );
    ok self-descriptive-candidates(4).first({ is-self-descriptive( $_, 4) }).base(4) eq "1210";
    ok self-descriptive-candidates(5).first({ is-self-descriptive($_, 5) }).base(5) eq "21200";
    ok self-descriptive-candidates(7).first({ is-self-descriptive($_, 7) }).base(7) eq "3211000";
}


sub is-self-descriptive( $number, $base ) 
{
    state @digits = (0 .. 9).Array.append( ('A' .. 'Z').Array );
    
    my $base-str = $number.base( $base );

    !so $base-str.comb.pairs.first( -> $p
    {
        my $digit = @digits[ $p.key ];
        my $count-is = ( $base-str ~~ m:g/ ($digit) / ).elems;
        $count-is != parse-base( $p.value.Str, $base );
    });
}


sub self-descriptive-candidates( $base )
{
    my $base-start = base-start($base);
    return $base-start, $base-start + $base, { $_ + $base } ...^ $base-start * $base;
}

sub base-start( $base )
{
    my $zeroes = $base - 1;
    my $n = "1" ~ ( "0" x $zeroes );
    parse-base( $n, $base );
}

