# I don't know how to write raku/perl6. With help from this blog post by Andrew
# Shitov I could figure out, how to generate a lazy, inifinite sequence of all
# factorials and adapt to the left factorial problem
# https://andrewshitov.com/2021/01/31/computing-factorials-using-raku/

my @facs = 1, * * ++$ ... *;
my @left_factorials = 0, 1, * + @facs[ ++$ ] ... *;

say @left_factorials[1..10];