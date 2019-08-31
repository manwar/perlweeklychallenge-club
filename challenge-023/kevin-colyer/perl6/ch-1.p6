#!/usr/bin/perl6
use v6;

use Test;

# 23.1 Create a script that prints nth order forward difference series. You should be a able to pass the list of numbers and order number as command line parameters. Let me show you with an example.

# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like to create 1st order forward difference series (Y). So using the formula Y(i) = X(i+1) - X(i), we get the following numbers: (9-5), (2-9), (8-2), (1-8), (6-1). In short, the final series would be: 4, -7, 6, -7, 5. If you noticed, it has one less number than the original series. Similary you can carry on 2nd order forward difference series like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.\

sub NthOrderForwardDifference(@X is copy,$n) {
    my @Y;
    return @Y if $n >= @X.elems;
    for ^$n ->$j {
        # say "{$j}th loop - X=[{@X}]".indent($j);
        @Y = gather for ^(@X.elems-1) -> $i {
            take @X[$i+1]-@X[$i];
        }
        @X=@Y;
    }
    return @Y;
}
#| Produce Nth Order Forward Difference sequence from list of integers
multi MAIN(Int $order,  *@list where {$_.all ~~ Int} ) {
    say NthOrderForwardDifference(@list,$order);
}

multi MAIN("test") {
    my @X= 5, 9, 2, 8, 1, 6;
    is NthOrderForwardDifference(@X,0),[],"0th order = fail";
    is NthOrderForwardDifference(@X,6),[],"5th order on series of 6 = fail";
    is NthOrderForwardDifference(@X,1),[4, -7, 6, -7, 5],"first order";
    is NthOrderForwardDifference(@X,2),[-11, 13, -13, 12],"second order";
    is NthOrderForwardDifference(@X,3),[24, -26, 25],"third order";
    done-testing;
}

