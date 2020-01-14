use Test;
use Math::SelfDescriptiveNumbers;

multi sub MAIN()
{
    for self-descriptive-numbers() -> ($base, $numbers)
    {
        say output( $base, $numbers );
    }

    for self-descriptive-numbers-dec() -> ($base, $numbers)
    {
        say $base, $numbers;
    }
}

multi sub MAIN( Int $base where 1 < $base < 37 )
{
    say output( $base, self-descriptive-numbers-of( $base ) );
}

multi sub MAIN( "test" ) 
{
    # test values from Wikipedia
    ok is-self-descriptive( :number(parse-base('21200',5)), :base(5) );
    ok is-self-descriptive( :number('21200'), :base(5) );
    ok is-self-descriptive( 'C210000000001000', 16 );
    ok is-self-descriptive( 0xC210000000001000, 16 );
    ok !is-self-descriptive( 3210001000, 10 );
}

sub output( $base, $numbers )
{
    my $num-base = $numbers.join(',');
    my $num-dec  = $numbers.map({ parse-base( $_, $base ) }).join(',');

    "Base $base, " ~ ( $numbers.elems ?? "$num-base; $num-dec (decimal)" !! '---' );
}