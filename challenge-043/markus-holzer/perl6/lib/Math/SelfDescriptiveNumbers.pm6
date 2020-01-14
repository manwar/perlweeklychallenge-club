unit module Math::SelfDescriptiveNumbers;

multi sub is-self-descriptive( Int $number, Int $base ) is export {
    is-self-descriptive( :$number, :$base );
}

multi sub is-self-descriptive( Int :$number, Int :$base ) is export {
    $number ∈ self-descriptive-numbers-of( $base );
}

multi sub is-self-descriptive( Str $number, Int $base ) is export {
    is-self-descriptive( :$number, :$base );
}

multi sub is-self-descriptive( Str :$number, Int :$base ) is export {
    parse-base( $number, $base ) ∈ self-descriptive-numbers-of( $base );
}

sub self-descriptive-numbers is export {
    ( 1 .. 36 ).map({ ( $_, self-descriptive-numbers-of( $_ ) ) });
}

multi sub self-descriptive-numbers-of( Int $base where $_ ~~ 1|2|3|6 ) is export { () }
multi sub self-descriptive-numbers-of( Int $base where $_ == 4 ) is export { (100, 136) }
multi sub self-descriptive-numbers-of( Int $base where $_ == 5 ) is export { (1425) }
multi sub self-descriptive-numbers-of( Int $base ) is export { 
    ( parse-base( ($base - 4).base( $base ) ~  "21" ~ ( '0' x ($base - 7) ) ~ '1000', $base ) )
}

