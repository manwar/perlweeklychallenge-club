#!raku

sub MAIN( Int $limit where { $limit >= 1 }  = 5 ) {
    my @solutions;
    for 1 .. Inf {
        next if ! $_.is-prime;
        my $repeating-size = $_ - 1;
        my $repeating-part = ( 1 / $_ ).Rat.base-repeating( 10 )[ 1 ];
        next if ! $repeating-part;

        @solutions.push: $_ if $repeating-part.Str.chars == $repeating-size;
        last if @solutions.elems == $limit;
    }

    @solutions.join( ', ' ).say;
}
