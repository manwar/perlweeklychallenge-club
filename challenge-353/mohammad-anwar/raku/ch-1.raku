#!/usr/bin/env raku

use Test;

my @examples = (
    { in  => [ "Hello world",
               "This is a test",
               "Perl is great" ],
      out => 4,
    },
    {
      in  => [ "Single" ],
      out => 1,
    },
    {
      in  => [ "Short",
               "This sentence has seven words in total",
               "A B C",
               "Just four words here" ],
      out => 7,
    },
    {
      in  => [ "One",
               "Two parts",
               "Three part phrase",
               "" ],
      out => 3,
    },
    {
      in  => [ "The quick brown fox jumps over the lazy dog",
               "A",
               "She sells seashells by the seashore",
               "To be or not to be that is the question" ],
      out => 10,
    },
);

is max_word($_<in>), $_<out> for @examples;

done-testing;

sub max_word(@sentences) {
    my @w = @sentences.map: { $_.words.elems };
    return @w ?? @w.sort.reverse[0] !! 0;
}
