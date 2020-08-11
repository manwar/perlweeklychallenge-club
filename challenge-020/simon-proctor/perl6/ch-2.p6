#!/usr/bin/env perl6

use v6;


multi sub MAIN ( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#|Given a starting number (default 0) find the first two Amicable numbers following it.
multi sub MAIN ( Int $start = 0 ) {
    my $current = $start;
    my $pair;
    loop {        
        $current++;
        $pair = first-pair( $current );
        last if $pair;
    }
    say "$pair, $current";

}

sub first-pair( Int $number ) {
    my $num-total = [+] divisors( $number );
    (1..^$number).first( 
        {
            my $sum = [+] divisors( $_ );
            ($sum == $number && $num-total == $_) 
        }
    );
}

sub divisors( Int $number ) is pure {
    state @divs;
    my $mid = $number div 2;
    @divs[$number] //= (1..$mid).grep( $number %% * ).list;
}