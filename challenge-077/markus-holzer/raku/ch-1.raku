#
# D:\Projekte\Perl6\perlweeklychallenge-club\challenge-077\markus-holzer\raku>raku ch-1.raku 123456789
# Number of combinations: 3230
# Calculated in 8.736 seconds
#
# Let me know if yours is faster
# See https://encyclopediaofmath.org/wiki/Zeckendorf_representation
#

use experimental :cached;

unit sub MAIN( Int $N where * > 0, Bool :$v = False );

my $start = now;

with my @combinations = gather combine zeckendorf $N
{
    say @combinations.map( *.join( "," ) ).join( "\n" ) if $v;
    say "Number of combinations: {+@combinations}";
    say "Calculated in { sprintf "%.3f", now - $start } seconds"
}

sub combine( @Z ) is cached
{
    my &valid  = -> $result {
        $result.elems == $result.unique.elems && $result !~~ @Z }

    my &insert = -> $where, $what {
        my @x = @Z.clone; @x.splice( $where, 1, |$what ); @x }

    take @Z and sink @Z
        .map( &zeckendorf )
        .kv.map( &insert )
        .grep( &valid )
        .map( &combine )
}

sub zeckendorf( $n is copy ) is cached
{
    state @fib = [1, 1, * + * ... * > $N];

    my &do-zeckendorf = {
        eager gather for @fib.grep( * < $n ).reverse {
            if $_ <= $n {
                take $_;
                $n -= $_ }}}

    $n == 1 ?? 1.List !! do-zeckendorf
}