#!/usr/bin/perl6
use v6;

use Test;

# 32.1 Create a script that either reads standard input or one or more files specified on the command-line.
# Count the number of times and then print a summary, sorted by the count of each entry.
#
# So with the following input in file example.txt
#
# apple
# apple
# banana
# apple
# cherry
# cherry
# the script would display something like:
#
# apple     3
# cherry    2
# banana    1
# For extra credit, add a -csv option to your script, which would generate:
#
# apple,3
# cherry,2
# banana,1

sub MAIN($file where *.IO.f = "test.txt", Bool :$csv = False) {
    my $bag=Bag.new($file.IO.slurp.lines>>.trim);
    my $delim=$csv ?? "," !! "\t";
    say $_.antipairs.fmt("%s$delim%s") for $bag.invert.sort.reverse;
}
