my $message = q:to/END/; 
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
END

# gives 'PerlRaku'
say decrypt( $message );

sub decrypt( $encrypted )
{
    [~] zip( 
        $encrypted.lines.map({ .split(/ \s /) }) 
    ).map({ 
        .Bag.first({ .value > 1 }).key 
    });
}