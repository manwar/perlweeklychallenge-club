# Write a script that can wrap the given paragraph
# at a specified column using the greedy algorithm.

use strict;
use warnings;
use v5.10;
use utf8;
use open qw(:std :utf8);

# greedy algorithm basically means put as many words
# on a line as possible
#
# let's start by defining a "fmt" function, that
# you will call with the text and the desired line width

sub fmt {
    my ( $text, $line_width ) = @_;
    my $out          = '';    # final formatted text will be here
    my $current_line = '';    # we will be adding words (while they fit) here
    for my $w ( split /\s+/, $text ) {

        # this split will return an array of "non-space" words. Note that
        # the amount of consecutive space characters doesn't matter, as
        # long there is at least one
        if ( length("$current_line $w") > $line_width ) {

            # a space plus $w does not fit in current line
            # close current line and start a new one with
            # just $w
            $out .= "$current_line\n";
            $current_line = $w;
        }
        else {
            # here we just append a space and $w to current line
            # actually the space is appended only when $current_line
            # is not empty, (i.e. is not the first word of the text)
            $current_line .= ' ' if length $current_line;
            $current_line .= $w;
        }
    }

    # we still need to add our current line at the end
    $out .= "$current_line" if length $current_line;
    return $out;
}

#
# an example:
#

my $example_text = '
Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis nostrud exercitation ullamco
laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit
esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.
';
say fmt( $example_text, 60 );
