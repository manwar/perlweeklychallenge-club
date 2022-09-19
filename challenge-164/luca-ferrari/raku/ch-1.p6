#!raku

# Perl Weekly Challenge 164

sub MAIN( Int $limit = 1000 ) {
    my @primes-palindrome = lazy gather {
        for 0 ..^ $limit {
            take $_ if $_.is-prime && $_.Str.flip == $_.Str && $_.Str.comb.chars > 1;
        }
    };

    .say for @primes-palindrome;
}
