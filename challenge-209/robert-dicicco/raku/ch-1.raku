#!/usr/bin/env raku
#`{
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-21
Challenge 209 Special Bit Chars ( Raku )
-----------------------------------------
}

my @bits = ([1, 0, 0],[1, 1, 1, 0]);

my $ln = @bits.elems;

my $flag = 0;
my $lastchar = '';

for (0..$ln - 1) -> $sub {
    say "Input: \@list1 = \[@bits[$sub]\]";
    my $ref_len = @bits[$sub].elems;
    for (0..$ref_len-1) -> $x {
        given (@bits[$sub][$x]) {
            when 1 {
                if ($flag == 0) {
                    $flag = 1;
                } else {
                    print 'c '.gist;
                    $lastchar = 'c';
                    $flag = 0;
                }
            }
            when 0 {
                if ($flag == 0) {
                    print 'a '.gist;
                    $lastchar = 'a';
                } elsif ($flag == 1) {
                    print 'b '.gist;
                    $lastchar = 'b';
                    $flag = 0;
                }
            }
    }

}
say " ";
if ($lastchar eq 'a' and $flag == 0) {
        say "Output: 1";
    } else {
        say "Output: 0";
    }
    say " ";
}
#`{
-----------------------------------------
SAMPLE OUTPUT
raku .\SpecialBit.rk
Input: @list1 = [1 0 0]
b a
Output: 1

Input: @list1 = [1 1 1 0]
c b
Output: 0
-----------------------------------------
}
