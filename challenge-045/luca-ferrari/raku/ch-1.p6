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
    my @chars    = $message.comb( / \w / ); # keeps letters, avoid spaces
    my Int $rows = ( @chars.elems / $columns ).Int + 1;
    my Int $start = 0;
    loop ( my $current_row = 0; $current_row < $rows; $current_row++ ) {
        @matrix.push( @chars[ $start .. $start + $columns - 1 ] );
        $start += $columns;
    }

    say "Your original message is [$message], and encoded results:\n";
    for 0 .. $columns -> $start {
        ( @matrix[ $_ ][ $start ] // ' ' ).print for 0 .. $rows;
    }

    say "\n\nAll done!";
}
