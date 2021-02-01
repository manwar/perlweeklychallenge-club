#!/usr/bin/env raku

# Switch the langauge version to general v6.
# This generally helps in case you run a Raku script with Perl
use v6;

# This whole script is the main sub.
unit sub MAIN();

# This script will read and print out itself by the number of characters
# that you tell it to until it's stopped or runs out of text.

# Note that characters include Uncide ones like £€æßðđŋŧ¶«»¢“”ŋŧ←ħ
# This is cool.

# Get out filehandle
my $handle = $?FILE.IO.open( :r );

# Give some opening sprawl
say "Self referential code is fun right?";

# While we have a truthy input
while ( my $val = prompt( "How many characters should I print? " ) ) {
    my $rval = $val.Int();
    if ( $rval ~~ $val ) {
        if ( $rval < 0 ) {
            if ( $handle.tell() >= $rval.abs ) {
                $handle.seek($rval, SeekFromCurrent );
            } else {
                $handle.seek(0, SeekFromBeginning );
            }
        }
        my $res = $handle.readchars($rval.abs);
        say $res;
        if $res.codes != $rval.abs {
            say "That's all folks";
            last;
        }
    } else {
        say "Please enter an integer. Thanks.";
    }
}

say "Bye";
