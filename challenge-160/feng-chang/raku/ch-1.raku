#!/bin/env raku

unit sub MAIN(UInt:D \N where * < 10 = 1);

my @digits-name = <zero one two three four five six seven eight nine>;
my %digits = (^10).map({ $_ => @digits-name[$_].chars });

my $n = N;
my @fim = do gather while $n != 4 {
    take $n;
    $n = @digits-name[$n].chars;
}

put (^@fim.elems).map(-> \n { "{ @digits-name[@fim[n]] } is @digits-name[%digits{@fim[n]}]" }).join(', ').tc,
    ', four is magic.';
