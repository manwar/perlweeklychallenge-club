# # Task #2
#
# Write a script that can wrap the given paragraph at a specified column
# using the greedy algorithm.
#
# A simple way to do word wrapping is to use a greedy algorithm that
# puts as many words on a line as possible, then moving on to the next
# line to do the same until there are no more words left to place. This
# method is used by many modern word processors, such as OpenOffice.org
# Writer and Microsoft Word[citation needed]. This algorithm always uses
# the minimum possible number of lines but may lead to lines of widely
# varying lengths. The following pseudocode implements this algorithm:
#
# ```
# SpaceLeft := LineWidth
# for each Word in Text
#     if (Width(Word) + SpaceWidth) > SpaceLeft
#         insert line break before Word in Text
#         SpaceLeft := LineWidth - Width(Word)
#     else
#         SpaceLeft := SpaceLeft - (Width(Word) + SpaceWidth)
# ```
#
# Where LineWidth is the width of a line, SpaceLeft is the remaining
# width of space on the line to fill, SpaceWidth is the width of a
# single space character, Text is the input text to iterate over and
# Word is a word in this text.

use Text::ParseWords;

my ($spaceLeft) = @ARGV; # specify wrap column

my @words = Text::ParseWords::shellwords(<STDIN>);
print @words[0];
$spaceLeft -= length shift @words;

for my $word (@words) {
    if ($spaceLeft < 1 + length $word) {
	($spaceLeft) = @ARGV;
	print "\n"; # append on new line
    } else {
	$word = " $word";
    }
    print $word; # TODO: wrap words longer than the wrap column
    $spaceLeft -= length $word;
}

print "\n" if @words;
