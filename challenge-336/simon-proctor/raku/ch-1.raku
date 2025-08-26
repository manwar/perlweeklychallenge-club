#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is equal-group(1,1,2,2,2,2), True;
    is equal-group(1,2,1,2,2,2), True;
    is equal-group(1,1,1,2,2,2,3,3), False;
    is equal-group(5,5,5,5,5,5,7,7,7,7,7,7), True;
    is equal-group(1,2,3,4), False;
    is equal-group(8,8,9,9,10,10,11,11), True;
    done-testing;
}

multi sub MAIN(*@args where all(@args) ~~ Int() ) {
    equal-group(|@args).say;
}

sub equal-group(*@args where all(@args) ~~ Int() ) {
    my $bag = @args.Bag;
    my $min-len = $bag.values.min;
    return False if $min-len < 2;
    return so all( $bag.values >>%%>> $min-len );
}
