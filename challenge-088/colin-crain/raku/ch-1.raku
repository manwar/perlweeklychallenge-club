#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;
@input.elems == 0 and @input = 5, 2, 1, 4, 3;

my $product = [*] @input;
my @output = @input.map: {$product/$_};

say @input;
say @output;
