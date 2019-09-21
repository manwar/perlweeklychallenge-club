use v6;

################################################################################
=begin comment

Perl Weekly Challenge 026
=========================

Task #1
-------
Create a script that accepts two strings, let us call it, *"stones"* and
*"jewels"*. It should print the count of "alphabet" from the string *"stones"*
found in the string *"jewels"*. For example, if your *stones* is *"chancellor"*
and *"jewels"* is *"chocolate"*, then the script should print *"8"*. To keep it
simple, only A-Z,a-z characters are acceptable. Also make the comparison case
sensitive.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my Regex constant $ALPHA  =  rx{ <[A..Za..z]> };
my Str   constant $STONES = 'chancellor';
my Str   constant $JEWELS = 'chocolate';

BEGIN say '';

#===============================================================================
sub MAIN
#===============================================================================
(
    Str:D  :$stones = $STONES,      #= The "stones" string
    Str:D  :$jewels = $JEWELS,      #= The "jewels" string
    Bool:D :$show   = False,        #= Show the matching letters?
)
{
    my UInt $count  = 0;
    my Nil  %jewels = $jewels.split('').grep( { $ALPHA } ).map( { $_ => Nil } );

    # Count each letter in the "stones" string if and only if it also occurs
    # (anywhere, but at least once) in the "jewels" string

    my Str @letters if $show;

    for $stones.split('').grep( { $ALPHA } ) -> Str $letter
    {
        if %jewels{$letter}:exists
        {
            ++$count;
            @letters.push($letter) if $show;
        }
    }

    my UInt $width = $count.chars;

    ("%*d of the letters in the Stones string \"%s\"\n" ~
     "%*s     also occur%s in the Jewels string \"%s\"\n").printf:
        $width, $count, $stones,
       ($count == 1 ?? $width - 1 !! $width), '',
       ($count == 1 ??    's'     !!   ''  ), $jewels;

    "namely ({ @letters.join(', ') })".say if $show && @letters.elems;
}

################################################################################
