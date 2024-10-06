#!perl

################################################################################
=comment

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
effect _has_ been studied. For example--and with a title that probably made the
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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, an example is presented: original
   text, followed by that same text in a jumbled form.
2. If the command-line contains the "-f" or "--file" flag followed by a file-
   name, the text in that file is displayed in jumbled form.
3. If the command-line contains a single string, the text in that string is dis-
   played in both its original and jumbled forms.

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Const::Fast;
use Getopt::Long;
use List::Util      qw( shuffle );

const my $LETTER => qr/ [A-Za-z] /x;
const my $USAGE  => <<END;
Usage:
  perl $0 <str>
  perl $0 [--file=<Str>]
  perl $0

    <str>           String to jumble
    --file=<Str>    Name of file containing text to jumble
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 289, Task #2: Jumbled Letters (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $file;

    GetOptions
    (
        'file=s' => \$file,

    ) or error( 'Invalid command-line argument(s)' );

    my $argc = scalar @ARGV;

    if (defined $file)
    {
        $argc == 0 or error( 'Found extra argument after filename' );

        read_from_file( $file );
    }
    elsif ($argc == 0)
    {
        show_example();
    }
    elsif ($argc == 1)
    {
        read_from_command_line();
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub jumble
#-------------------------------------------------------------------------------
{
    my ($str)   = @_;
    my  @chunks = split / ($LETTER+) /x, $str;

    for my $chunk (@chunks)
    {
        if ($chunk =~ / ^ ($LETTER) ($LETTER+) ($LETTER) $ /x)
        {
            my $middle = join '', shuffle split //, $2;

            $chunk = $1 . $middle . $3;
        }
    }

    return join '', @chunks;
}

#-------------------------------------------------------------------------------
sub read_from_command_line
#-------------------------------------------------------------------------------
{
    my $str = $ARGV[ 0 ];

    print "Original text:\n$str\n\n";

    my $jumbled = jumble( $str );

    print "Jumbled text:\n$jumbled\n";
}

#-------------------------------------------------------------------------------
sub read_from_file
#-------------------------------------------------------------------------------
{
    my ($file) = @_;

    open( my $fh, '<', $file )
              or die qq[Cannot open file "$file" for reading: $!];

    {
        local $/;   # Slurp mode

        my $jumbled = jumble( <$fh> );

        print qq[Jumbled text from file "$file":\n\n$jumbled];
    }

    close $fh or die qq[Cannot close file "$file": $!];
}

#-------------------------------------------------------------------------------
sub show_example
#-------------------------------------------------------------------------------
{
    print "Example:\n\n";

    my $str = '';

    while (my $line = <DATA>)
    {
        chomp $line;

        $str .= $line;
    }

    print "Original text:\n$str\n\n";

    my $jumbled = jumble( $str );

    print "Jumbled text:\n$jumbled\n";
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
According to a researcher at Cambridge University, it doesn't matter in what 
order the letters in a word are, the only important thing is that the first and 
last letter be at the right place. The rest can be a total mess and you can 
still read it without problem. This is because the human mind does not read 
every letter by itself, but the word as a whole.
