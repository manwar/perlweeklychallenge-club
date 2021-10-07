#!/usr/bin/env raku

use experimental :cached;

#| Display the first n smith numbers
sub MAIN ( UInt \n = 10 ) {
    .say for (2..*).grep( { is-smith-number($_) } )[^n];
}

multi sub is-smith-number( Int \n where n.is-prime --> False ) {}

multi sub is-smith-number( Int \n --> Bool ) is pure {
    my @factors = prime-factors( n );
    ([+] n.comb) == ([+] @factors.map( { [+] $_.comb } ));
}

sub prime-factors( Int $n is copy --> Array ) is pure {
    my @factors;
    while ! $n.is-prime {
        my \s = smallest-factor( $n );
        @factors.push(s);
        $n = $n div s;
    }
    @factors.push($n);
    return @factors;
}

sub smallest-factor( Int \n --> Int ) is pure is cached {
    for (2..(n div 2)).grep(*.is-prime) {
        return $_ if n %% $_;
    }
    die "Something went wrong";
}
