#!/usr/bin/env raku
use Test;

is max-words("Hello world", "This is a test", "Perl is great"),                                                                                      4;
is max-words("Single"),                                                                                                                              1;
is max-words("Short", "This sentence has seven words in total", "A B C", "Just four words here"),                                                    7;
is max-words("One", "Two parts", "Three part phrase", ""),                                                                                           3;
is max-words("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"), 10;

sub max-words(*@s)
{
    max @s>>.words>>.elems
}
