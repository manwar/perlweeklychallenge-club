# Perl Weekly Challenge - 018
# Task #1
#
# See
#     engineering.purdue.edu/~mark/pwc-018.pdf
# for more information.

# Run using Perl v6.d.
use v6.d;

# Make an array of sets.
# Each element of the array will contain a set of all substrings
# for the corresponding word.
my SetHash @set;

# For each word on the command line
for (0 .. @*ARGS.elems - 1) -> $i  {
    # Get the word.
    my $word = @*ARGS[$i];
    # Compute and store every substring in the word in @set[$i].
    for (0 .. $word.chars - 1) -> $startpos  {
        for ($startpos .. $word.chars - 1) -> $endpos  {
            my $substr = $word.substr($startpos .. $endpos);
            @set[$i]{$substr} = True;
        }
    }
}

# Compute the intersection of all sets,
# sort by the number of characters,
# get the last entry (the one with the most characters),
# and print it.
([(&)] @set).keys.sort({.chars}).tail.say;
