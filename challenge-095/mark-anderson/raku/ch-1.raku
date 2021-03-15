#!/usr/bin/env raku

multi MAIN 
{
    use Test;

    ok palindrome(1221) == 1, "Example 1";
    ok palindrome(-101) == 0, "Example 2";
    ok palindrome(90)   == 0, "Example 3";
}
 
multi MAIN(IntStr $N) 
{
    say palindrome($N);
}

sub palindrome(Int:D $N) 
{
    .Int given $N eq $N.flip;
}
