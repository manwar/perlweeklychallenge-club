#!/usr/bin/env raku
use Test;

is valid-token-count("cat and dog"),              3;
is valid-token-count("a-b c! d,e"),               2;
is valid-token-count("hello-world! this is fun"), 4;
is valid-token-count("ab- cd-ef gh- ij!"),        2;
is valid-token-count("wow! a-b-c nice."),         2;
is valid-token-count("wow1 a-b2c nice."),         1;

sub valid-token-count($str)
{
    $str.words.grep(/^ <:Ll>+ ['-' <:Ll>+]? <:P - [-]>? $/).elems
}
