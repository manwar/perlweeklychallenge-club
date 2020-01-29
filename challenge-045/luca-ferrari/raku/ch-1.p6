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


sub MAIN( Str :$message! where { .chars > 8 }  ) {

    my Int $columns = 8;
    my @matrix;

    my Int $row = 0;
    for $message.lc.comb( / \w / )  {
        @matrix[ $row ].push: $_ if @matrix[ $row ].elems < $columns;
        $row++ if @matrix[ $row ].elems == $columns;
    }

    say "Your original message is \n\t$message\n and encoded results:\n";
    @matrix.join( "\n" ).say;
    say "\nthat leads to\n";
    for 0 .. $columns -> $start {
        ( @matrix[ $_ ][ $start ] // '' ).print for 0 .. $row;
    }

    say "\n\nAll done!";
}
