use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 289
=========================

TASK #2
-------
*Jumbled Letters*

Submitted by: Ryan Thompson

An Internet legend dating back to at least 2001 goes something like this:

    Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn't mttaer in waht
    oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist
    and lsat ltteer be at the rghit pclae. The rset can be a toatl mses and you
    can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not
    raed ervey lteter by istlef, but the wrod as a wlohe.

This supposed Cambridge research is unfortunately an urban legend. However, the
effect has been studied. For example--and with a title that probably made the
journal's editor a little nervous--_Raeding wrods with jubmled lettres: there is
a cost_ by Rayner, White, et. al. looked at reading speed and comprehension of
jumbled text.

*Your task* is to write a program that takes English text as its input and
outputs a jumbled version as follows:

    1. The first and last letter of every word must stay the same
    2. The remaining letters in the word are scrambled in a random order (if
       that happens to be the original order, that is OK).
    3. Whitespace, punctuation, and capitalization must stay the same
    4. The order of words does not change, only the letters inside the word

So, for example, "Perl" could become "Prel", or stay as "Perl," but it could not
become "Pelr" or "lreP".

I don't know if this effect has been studied in other languages besides English,
but please consider sharing your results if you try!

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, an example is presented: original
   text, followed by that same text in a jumbled form.
2. If the command-line contains the "--file" flag followed by a filename, the
   text in that file is displayed in jumbled form.
3. If the command-line contains a single string, the text in that string is dis-
   played in both its original and jumbled forms.

=end comment
#===============================================================================

my regex LETTER {  <[ A..Z a..z ]> };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 289, Task #2: Jumbled Letters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str    #= String to jumble
)
#===============================================================================
{
    "Original text:\n$str\n".put;

    my Str $jumbled = jumble( $str );

    "Jumbled text:\n$jumbled".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$file where *.IO.f          #= Name of file containing text to jumble
)
#===============================================================================
{
    my Str $str     = $file.IO.slurp;
    my Str $jumbled = jumble( $str );

    qq[Jumbled text from file "$file":\n\n$jumbled].print;
}

#===============================================================================
multi sub MAIN()                                     # No input: show an example
#===============================================================================
{
    "Example:\n".put;

    my Str $str = '';

    for example-data.lines -> Str $line
    {
        $str ~= $line.chomp;
    }

    "Original text:\n$str\n".put;

    my Str $jumbled = jumble( $str );

    "Jumbled text:\n$jumbled".put;
}

#-------------------------------------------------------------------------------
sub jumble( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @chunks = $str.split( / (<LETTER>+) /, :v ).map: { ~$_ };

    for @chunks -> Str $chunk is rw
    {
        if $chunk ~~ / ^ (<LETTER>) (<LETTER>+) (<LETTER>) $ /
        {
            my Str $middle = (~$1).split( '', :skip-empty ).pick( ~$1.chars ).
                             join: '';

            $chunk = ~$0 ~ $middle ~ ~$2;
        }
    }

    return @chunks.join: '';
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub example-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        According to a researcher at Cambridge University, it doesn't matter in 
        what order the letters in a word are, the only important thing is that 
        the first and last letter be at the right place. The rest can be a 
        total mess and you can still read it without problem. This is because 
        the human mind does not read every letter by itself, but the word as a 
        whole.
        END
}

################################################################################
