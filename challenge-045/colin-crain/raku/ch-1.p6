use v6.d;

#
#       square_secret.raku
#
#       PWC 45 TASK #1
#         Square Secret Code
#             The squate secret code mechanism first removes any space from the
#             original message. Then it lays down the message in a row of 8
#             columns. The coded message is then obtained by reading down the
#             columns going left to right.
#
#             For example, the message is “The quick brown fox jumps over the lazy
#             dog”.
#
#             Then the message would be laid out as below:
#
#                 thequick
#                 brownfox
#                 jumpsove
#                 rthelazy
#                 dog

#             The code message would be as below:
#
#                 tbjrd hruto eomhg qwpe unsl ifoa covz kxey

#             Write a script that accepts a message from command line and prints
#             the equivalent coded message.

#         method:
#             Raku has some very powerful string and list processing routines
#             that make the actual data processing portion of the program quite
#             succinct. In fact, with one line to prepare the input, and another
#             to display the output, the challenge can be dispatched in three
#             lines:
#
#             1. On first pass we purify the input, removing spaces and
#             lowercasing everything, to match the directives.
#
#             2. We dice the prepared string into groups of 8 chars until the
#             end using a comb routine. These segments are then each combed
#             again and broken apart into arrays of chars. The arrays of
#             segments are interwoven in turn, the output is another list of
#             arrays, the first composed of taking the first element of each
#             segement, the second the second element, etcetera until all
#             elements from the input are are allocated between the eight
#             outputs. The roundrobin routine does the heavy lifting here, and
#             the input arrays are distributed amongst the outputs until
#             finished, meaning the output arrays will be of different lengths
#             unless they aren't just by chance (quantity a whole multiple of 8
#             in this case).
#
#             3. To print we join first the interwoven subarrays into words and
#             then these words with a space to form the coded message.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Str:D $raw = "The quick brown fox jumps over the lazy dog" ) {

    ## remove spaces and lowercase in one pass
    ## not specified, but we will strip punctuation and any nonword chars with the spaces,
    ## leaving a homogeneous unpunctuated string of lower case chars.
    my $input = $raw.comb.grep( /\w/ ).join( '' ).lc;

    ##  chop into strings of 8 chars, dice and interleave those strings
    my @output = roundrobin ($input.comb(8)).map({ .comb });

    ## join interleaved sub-arrays into strings, join those with a space
    say join ' ', @output.map({ .join });

}


