unit module Math::SelfDescriptiveNumbers;

multi sub is-self-descriptive( Int $number, Int $base ) is export {
    is-self-descriptive( :$number, :$base );
}

multi sub is-self-descriptive( Int :$number, Int :$base ) is export {
    $number.base( $base ) ∈ self-descriptive-numbers-of( $base );
}

multi sub is-self-descriptive( Str $number, Int $base ) is export {
    is-self-descriptive( :$number, :$base );
}

multi sub is-self-descriptive( Str :$number, Int :$base ) is export {
    $number ∈ self-descriptive-numbers-of( $base );
}

sub self-descriptive-numbers is export {
    ( 1 .. 36 ).map( -> $base { ( $base, self-descriptive-numbers-of( $base ) ) });
}

sub self-descriptive-numbers-dec is export {
    ( 1 .. 36 ).map( -> $base { ( $base, self-descriptive-numbers-of( $base ).map({ parse-base($_, $base ) }) ) });
}

multi sub self-descriptive-numbers-of( Int $base where $_ ~~ 1|2|3|6 ) is export { () }
multi sub self-descriptive-numbers-of( Int $base where $_ == 4 ) is export { ('1210', '2020') }
multi sub self-descriptive-numbers-of( Int $base where $_ == 5 ) is export { ('21200') }
multi sub self-descriptive-numbers-of( Int $base ) is export { 
    ( ($base - 4).base( $base ) ~  "21" ~ ( '0' x ($base - 7) ) ~ '1000' )
}

