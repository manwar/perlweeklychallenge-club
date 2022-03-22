#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $count = 3 ) ;


say $_[*-1] for ((1..*) .map({proper_divisors($_)})
            .grep({abundant($_) and not semiperfect($_)}))[^$count] ;

sub proper_divisors ($num) {
    |((1..$num/2).grep($num %% *)) , $num
}

sub abundant ( @pdiv is copy ) {
    my $num = @pdiv.pop;
    @pdiv.sum > $num;
}

## a unsatisfactorily slow solution, but sound

sub semiperfect ( @pdiv is copy) {
## given a value and a list of proper divisors, returns yes/no 
## if a subset of the divisors can be found to sum to the number
    my $num = @pdiv.pop;
    my $max = @pdiv.elems;

    for ( 1..2**$max - 1 ) {
        my $fmt = '%0' ~ $max ~ 'b' ;
        my @mask = $_.fmt("$fmt").comb;
        my $sum = (@mask Z* @pdiv).sum ;

        return True if $sum == $num;
    }
    return False;
}
