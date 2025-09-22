#!/usr/bin/env raku

subset IsTrue of Bool where so *;

multi sub MAIN( IsTrue :t(:$test) ) is hidden-from-USAGE {
    use Test;
    ok ascending("The cat has 3 kittens 7 toys 10 beds");
    nok ascending('Alice bought 5 apples 2 oranges 9 bananas');
    ok ascending('I ran 1 mile 2 days 3 weeks 4 months');
    nok ascending('Bob has 10 cars 10 bikes');
    ok ascending('Zero is 0 one is 1 two is 2');
    done-testing;
}

multi sub MAIN( Str $s ) { ascending($s).say; }
multi sub MAIN( *@s ) { ascending( @s.join(" ") ).say; } 

sub ascending( Str $s ) {
    [<] $s.comb(/\d+/);
}
