#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
Task 1: Split Strings           Submitted by: Mohammad S Anwar
Given an array of strings and a character separator;  write a script to
return all words separated by the given character excluding empty string.

Example 1
Input: @words = ("one.two.three","four.five","six")
       $separator = "."
Output: "one","two","three","four","five","six"
Example 2
Input: @words = ("$perl$$", "$$raku$")
       $separator = "$"
Output: "perl","raku"

=end comment

sub ____ (+@list) { gather @list.deepmap: *.take }   # move to Flatland 
constant \pancake-flat = &____;

my @Test =
    '@', ('one@@two@three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    ':', ("one:two:three","four:five","six"),
            Q'"one","two","three","four","five","six"',
    '.', ("one.two.three","four.five","six"),
            Q'"one","two","three","four","five","six"',
    '$', ('$perl$$', '$$raku$'),
        Q'"perl","raku"',
    '#', ('one##two#three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    '%', ('one%%two%three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    '^', ('one^^two^three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    '&', ('one&&two&three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    '*', ('one**two*three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    '(', ('one((two((three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    ')', ('one))two)three','four$five',"six"),
            Q'"one","two","three","four$five","six"',
    '?', ('one??two?three','four$five',"six"),
            Q'"one","two","three","four$five","six"',

                                            #   Q'one\\two' ; is confused.

#    Q'\', ( Q{one\\two\three}, Q{four$five}, "six"),   # this will work
#           Q'"one","two","three","four$five","six"',

                                                        # but punted these
#   Q'\', ( Q{one\\two\three}, Q{four\$five}, "six"),
#           Q'"one","two","three","four$five","six"',
#   Q'\', ( Q{one\\two\three}, Q{four\\$five}, "six"),
#           Q'"one","two","three","four$five","six"',
#   Q'\', ( Q{one\\two\three}, Q{four\\\$five}, "six"),
#           Q'"one","two","three","four$five","six"',
#   Q'\', ( Q{one\\two\three}, Q{four\\\\$five}, "six"),
#           Q'"one","two","three","four$five","six"',
;
plan @Test ÷ 3;

sub func( $sep where * ne Q{\}, @word --> Str) {
    # more efficient to be taught how to normalize backslash than self learning?
    '"'
    ~ @word.map( *.split( / $sep+ / , :skip-empty )
               ).&____.join( '","').grep( none "")
    ~ '"'
}

for @Test -> $sep, @in, $exp {
    is func($sep, @in), $exp, "$exp <- $sep <- @in[]";
}
done-testing;
my $sep = 'x';
my @word = Q{??xxx!!x##X#@@x^}, Q{^x&x*x(x)x-x+x=[x;]'x/x\x|x<x>x_x};


print "\nInput: @word = ( @word[] )\n       \$separator = "
    ~ $sep ~ "\nOutput: ", func( $sep, @word);

die unless  func( $sep, @word) ~~ Q{"??","!!","##X#@@","^","^","&","*","(",")","-","+","=[",";]'","/","\","|","<",">","_"};
exit;

