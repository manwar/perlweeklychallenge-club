#!raku

# You are given a string $S and an array of words @W.
#
# Write a script to find out if $S can be split into sequence of one or more words as in the given @W.
#
# Print the all the words if found otherwise print 0.
# Example 1:
#
# Input:
#
# $S = "perlweeklychallenge"
#  @W = ("weekly", "challenge", "perl")
#
#  Output:
#
# "perl", "weekly", "challenge"


sub MAIN( Str $S? = 'perlweeklychallenge', @W? = [ "weekly", "challenge", "perl" ] ){

    my $string = $S;
    my @found-words;
    my $redo = True;


    while ( $redo ) {
        $redo = False; # if no one match, skip the next loop
        for @W -> $part {
            # if the current string begins with this token,
            # mark as found and remove from the string
            if $string ~~ / ^ $part / {
                @found-words.push: $part;
                $string ~~ s/ ^ $part //;
                $redo = True;
            }
        }
    }

    # all done
    "In the string $S I found the words { @found-words.join( ',' ) } ".say if @found-words;
    '0'.say if ! @found-words;
}
