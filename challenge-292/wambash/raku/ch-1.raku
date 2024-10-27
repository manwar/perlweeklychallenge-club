#!/usr/bin/env raku

sub twice-largest (+@ints) {
    my ($ind-max, $max) = @ints.max :kv;
    $max < @ints.one * 2 ?? $ind-max !! Nil
}

multi MAIN (Bool :test($)!) {
    use Test;
    is twice-largest(2,4,1,0),1;
    is twice-largest(1..4),Nil;
    done-testing;
}

multi MAIN (+@ints) {
    say twice-largest(@ints) // -1
}
