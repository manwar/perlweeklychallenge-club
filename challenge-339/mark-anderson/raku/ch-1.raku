#!/usr/bin/env raku
use Test;

is max-diff(<  5  9  3  4  6 >), 42;
is max-diff(<  1 -2  3 -4    >), 10;
is max-diff(< -3 -1 -2 -4    >), 10;
is max-diff(< 10  2  0  5  1 >), 50;
is max-diff(<  7  8  9 10 10 >), 44;

sub max-diff(@a)
{
    my %c := { -1 => [], 0 => [], 1 => [] }
    @a.classify(*.sign, :into(%c));
    %c<-1> = %c<-1>.sort.Array;
    %c<1>  = %c<1> .sort.Array;

    if %c<0> >= @a.end { return 0 }
    if none(%c<-1 0>)  { return ([*] %c<1> .tail(2)) - ([*] %c<1> .head(2)) }
    if none(%c<1 0>)   { return ([*] %c<-1>.head(2)) - ([*] %c<-1>.tail(2)) }

    return .max given gather
    {  
        if all(%c<1> >= 3, %c<-1> >= 1)
        {
            take ([*] %c<1>[*-2,*-1]) - ([*] %c<-1>[0], %c<1>[*-3]);
            take ([*] %c<1>[*-3,*-2]) - ([*] %c<-1>[0], %c<1>[*-1])
        }

        if all(%c<-1> >= 3, %c<1> >= 1)
        {
            take ([*] %c<-1>[0,1]) - ([*] %c<-1>[2], %c<1>[*-1]);
            take ([*] %c<-1>[1,2]) - ([*] %c<-1>[0], %c<1>[*-1])
        }
 
        if all(all(%c<-1 1>) >= 2, none(%c<0>))
        {
            take (%c<-1>.tail * %c<1>.head) - (%c<-1>.head * %c<1>.tail)
        }

        if all(%c<-1 0 1>) >= 1
        {
            take -([*] %c<-1>.head, %c<1>.tail)
        }

        if all(%c<1> >= 2, %c<0> >= 1)
        {
            take [*] %c<1>.tail(2)  
        }

        if all(%c<-1> >= 2, %c<0> >= 1)
        {
            take [*] %c<-1>.head(2)  
        }

        if %c<-1> == 2
        {
            take ([*] %c<-1>.head(2)) - ([*] %c<1>.head(2))
        }

        if %c<1> == 2
        {
            take ([*] %c<1>.tail(2)) - ([*] %c<-1>.tail(2))
        }
    }
}
