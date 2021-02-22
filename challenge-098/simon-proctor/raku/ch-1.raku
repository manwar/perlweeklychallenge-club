#!/usr/bin/env raku

# Switch the langauge version to general v6.
# This generally helps in case you run a Raku script with Perl
use v6;

# This whole script is the main sub.
unit sub MAIN();

# This script will read and print out itself by the number of characters
# that you tell it to until it's stopped or runs out of text.

# Note that characters include Unicode ones like £€æßðđŋŧ¶«»¢“”ŋŧ←ħ
# This is cool.

# Get our filehandle. $?FILE is the current file so we open a read only handle to it.
my $handle = $?FILE.IO.open( :r );

# Give some opening sprawl
say "Self referential code is fun right?";

# While we have a truthy input
while ( my $val = prompt( "How many characters should I print? " ) ) {
    if ( $val ~~ Int ) {
        # Allow for negative read back.
        if ( $val < 0 ) {
            # If we would read back to beyond the start just reset it.
            if ( $handle.tell() >= $val.abs ) {
                $handle.seek($val, SeekFromCurrent );
            } else {
                $handle.seek(0, SeekFromBeginning );
            }
        }
        my $res = $handle.readchars($val.abs);
        # I thought about reading back displaying backwards but... not instead it
        # pulls the pointer back and rereads
        say $res;
        # If we got back less code points than we asked for (note not bytes)
        # we are done.
        if $res.codes != $val.abs {
            say "That's all folks";
            last;
        }
    } else {
        say "Please enter an integer. Thanks.";
    }
}

# All over. Say goodbye.
say "Bye";
