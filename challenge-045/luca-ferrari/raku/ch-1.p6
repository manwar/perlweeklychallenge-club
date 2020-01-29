#!env perl6

# Perl Weekly Challenge 45
#
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/>
#
# Task 1
# The squate secret code mechanism first removes any space from the original message.
# Then it lays down the message in a row of 8 columns.
# The coded message is then obtained by reading down the columns going left to right.
#
# For example, the message is “The quick brown fox jumps over the lazy dog”.
# Then the message would be laid out as below:
#       thequick
#       brownfox
#       jumpsove
#       rthelazy
#       dog
#
# The code message would be as below:
#
# tbjrd hruto eomhg qwpe unsl ifoa covz kxey
#
# Write a script that accepts a message from command line
# and prints the equivalent coded message.
#
#
#
# Example of invocation:
# % perl6 ch-1.p6 --message="The quick brown fox jumps over the lazy dog"
# Your original message is
# The quick brown fox jumps over the lazy dog
# and encoded results:
#
#   t h e q u i c k
#   b r o w n f o x
#   j u m p s o v e
#   r t h e l a z y
#   d o g
#
#   that leads to
#
#   tbjrdhrutoeomhgqwpeunslifoacovzkxey
#
#   All done!



sub MAIN( Str :$message! where { .chars > 8 }
        , Int :$columns? where { $_ > 0 && $_ < $message.chars } = 8 ) {

    my @matrix = $message.lc.comb( /\w/ ).rotor: $columns, :partial;

    say "Your original message is \n\t$message\n and encoded results:\n";
    @matrix.join( "\n" ).say;
    say "\nthat leads to\n";
    for 0 .. $columns -> $start {
        ( @matrix[ $_ ][ $start ] // '' ).print for 0 .. @matrix.elems;
    }

    say "\n\nAll done!";
}
