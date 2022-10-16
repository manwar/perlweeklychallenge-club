#!perl

###############################################################################
=comment

Perl Weekly Challenge 186
=========================

TASK #2
-------
*Unicode Makeover*

Submitted by: Mohammad S Anwar

You are given a string with possible unicode characters.

Create a subroutine sub makeover($str) that replace the unicode characters with
ascii equivalent. For this task, let us assume it only contains alphabets.

Example 1

  Input: $str = 'ÃÊÍÒÙ';
  Output: 'AEIOU'

Example 2

  Input: $str = 'âÊíÒÙ';
  Output: 'aEiOU'

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

Unicode Characters
------------------
Characters to be replaced are drawn from the following Unicode blocks:
    Basic Latin               ($),
    Latin-1 Supplement        (¢, À, Á, ...)
    Latin Extended-A          (Ā, ā, Ă, ...)
    Latin Extended-B          (ƀ, Ɓ, Ƃ, ...)
    IPA Extensions            (ɛ, ɔ)
    Latin Extended Additional (Ḁ, ḁ, Ḃ, ...)
    Letterlike Symbols        (ℂ, ℍ, ℎ, ...).

In many cases, the identification of equivalent characters is straightforward;
for example, Unicode character U+00C0, named "Latin Capital Letter A with
grave," obviously has ASCII capital A as its equivalent. In other cases,
identification of "equivalent" characters is based on my subjective judgment.

For my convenience, Unicode characters which do not display in the DejaVu Sans
Mono font have been excluded.

Algorithm
---------
The hash %ASCII_2_UNICODE maps ASCII characters to their Unicode equivalents.
This presents the required data in a convenient form. The create_lookup() sub-
routine reverses this hash to create the hash %UNICODE_2_ASCII, which maps
Unicode characters to their ASCII equivalents. This is the lookup table used in
making the required replacements. 

Any character not entered in the lookup table is simply left unchanged in the
output string.

=cut
#==============================================================================

use strict;
use warnings;
use utf8;
use Const::Fast;
use Test::More;

const my %ASCII_2_UNICODE =>
(
    A  => [ qw( À Á Â Ã Ä Å Ā Ă Ą Ǎ Ǟ Ǡ Ȁ Ȃ Ȧ Ⱥ Ḁ         ) ],
    AE => [ qw( Æ Ǣ Ǽ                                     ) ],
    B  => [ qw( Ɓ Ƃ Ƀ Ḃ Ḅ                                 ) ],
    C  => [ qw( Ç Ć Ĉ Ċ Č Ƈ Ȼ ℂ                           ) ],
    D  => [ qw( Ð Ď Đ Ɖ Ɗ Ƌ                               ) ],
    E  => [ qw( È É Ê Ë Ē Ĕ Ė Ę Ě Ȅ Ȇ Ȩ                   ) ],
    F  => [ qw( Ƒ                                         ) ],
    G  => [ qw( Ĝ Ğ Ġ Ģ Ɠ Ǧ Ǵ                             ) ],
    H  => [ qw( Ĥ Ħ Ȟ ℍ                                   ) ],
    I  => [ qw( Ì Í Î Ï Ĩ Ī Ĭ Į İ Ɩ Ɨ Ǐ Ȉ Ȋ               ) ],
    IJ => [ qw( Ĳ                                         ) ],
    J  => [ qw( Ĵ                                         ) ],
    K  => [ qw( Ķ Ƙ Ǩ                                     ) ],
    L  => [ qw( £ Ĺ Ļ Ľ Ŀ Ł Ƚ                             ) ],
    N  => [ qw( Ñ Ń Ņ Ň Ɲ Ǹ Ƞ ℕ                           ) ],
    No => [ qw( №                                         ) ],
    NG => [ qw( Ŋ                                         ) ],
    O  => [ qw( Ò Ó Ô Õ Ö Ø Ō Ŏ Ő Ɵ Ơ Ǒ Ǫ Ǭ Ǿ Ȍ Ȏ Ȫ Ȭ Ȯ Ȱ ) ],
    OE => [ qw( Œ                                         ) ],
    P  => [ qw( Ƥ ℙ                                       ) ],
    Q  => [ qw( ℚ                                         ) ],
    R  => [ qw( Ŕ Ŗ Ř Ȑ Ɍ ℝ                               ) ],
    S  => [ qw( $ Ś Ŝ Ş Š Ș                               ) ],
    T  => [ qw( Ţ Ť Ŧ Ƭ Ʈ Ț Ⱦ                             ) ],
    TH => [ qw( Þ                                         ) ],
    U  => [ qw( Ù Ú Û Ü Ũ Ū Ŭ Ů Ű Ų Ư Ǔ Ǘ Ǚ Ǜ Ȕ Ȗ Ʉ       ) ],
    V  => [ qw( Ʋ                                         ) ],
    W  => [ qw( Ŵ                                         ) ],
    Y  => [ qw( ¥ Ý Ŷ Ÿ Ƴ Ȳ                               ) ],
    Z  => [ qw( Ź Ż Ž Ƶ Ʒ Ǯ Ȥ ℤ                           ) ],
    a  => [ qw( à á â ã ä å ā ă ą ǎ ǟ ǡ ȁ ȃ ȧ ḁ           ) ],
    ae => [ qw( æ ǣ ǽ                                     ) ],
    b  => [ qw( ƀ ƃ ḃ                                     ) ],
    c  => [ qw( ¢ ç ć ĉ ċ č ƈ ȼ                           ) ],
    d  => [ qw( ð ď đ ƌ ȡ                                 ) ],
    e  => [ qw( è é ê ë ē ĕ ė ę ě ȅ ȇ ȩ ℮ ɛ               ) ],
    f  => [ qw( ƒ                                         ) ],
    g  => [ qw( ĝ ğ ġ ģ ǧ ǵ                               ) ],
    h  => [ qw( ĥ ħ ȟ ℎ ℏ                                 ) ],
    i  => [ qw( ì í î ï ĩ ī ĭ į ı ǐ ȉ ȋ                   ) ],
    ij => [ qw( ĳ                                         ) ],
    j  => [ qw( ĵ ǰ ȷ                                     ) ],
    k  => [ qw( ķ ĸ ƙ ǩ                                   ) ],
    l  => [ qw( ĺ ļ ľ ŀ ł ƚ ȴ                             ) ],
    n  => [ qw( ñ ń ņ ň ŉ ƞ ǹ ȵ                           ) ],
    ng => [ qw( ŋ                                         ) ],
    o  => [ qw( ò ó ô õ ö ø ō ŏ ő ơ ǒ ǫ ǭ ǿ ȍ ȏ ȫ ȭ ȯ ȱ ɔ ) ],
    oe => [ qw( œ                                         ) ],
    p  => [ qw( ƥ                                         ) ],
    r  => [ qw( ŕ ŗ ř ȑ ɍ                                 ) ],
    s  => [ qw( ś ŝ ş š ſ ș ȿ                             ) ],
    ss => [ qw( ß                                         ) ],
    t  => [ qw( ţ ť ŧ ƫ ƭ ț ȶ                             ) ],
    th => [ qw( þ                                         ) ],
    u  => [ qw( ù ú û ü ũ ū ŭ ů ű ų ư ǔ ǘ ǚ ǜ ȕ ȗ         ) ],
    w  => [ qw( ŵ ƿ                                       ) ],
    y  => [ qw( ý ÿ ŷ ƴ ȳ                                 ) ],
    z  => [ qw( ź ż ž ƶ ƺ ǯ ȥ ɀ                           ) ],
);

const my $TEST_FIELDS => 3;
const my $USAGE       =>
"Usage:
  perl $0 <str>
  perl $0

    <str>    A Unicode string\n";

my %UNICODE_2_ASCII;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 186, Task #2: Unicode Makeover (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        create_lookup();
        run_tests();
    }
    elsif ($args == 1)
    {
        create_lookup();

        my $str = $ARGV[ 0 ];

        print "Input: \$str = '$str'\n";

        my $out = makeover( $str );

        print "Output:       '$out'\n";
    }
    else
    {
        error( "Expected 0 or 1 arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub makeover
#------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $plain;

    for my $char (split //, $str)
    {
        if (exists $UNICODE_2_ASCII{ $char })
        {
            $plain .= $UNICODE_2_ASCII{ $char };
        }
        else
        {
            $plain .= $char;
        }   
    }

    return $plain;
}

#------------------------------------------------------------------------------
sub create_lookup
#------------------------------------------------------------------------------
{
    for my $key (keys %ASCII_2_UNICODE)
    {
        for my $val (@{ $ASCII_2_UNICODE{ $key } })
        {
            $UNICODE_2_ASCII{ $val } = $key;
        }
    }
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($name, $in, $exp) = split / , \s* /x, $line, $TEST_FIELDS;

        my $out = makeover( $in );

        is $out, $exp, $name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,        ÃÊÍÒÙ,                       AEIOU
Example 2,        âÊíÒÙ,                       aEiOU
Finnish,          En ymmärrä,                  En ymmarra
French 1,         Combien ça coûte?,           Combien ca coute?
French 2,         Théâtralité évêché éphémère, Theatralite eveche ephemere
German,           Wie heißt du?,               Wie heisst du?
Icelandic,        Góðan daginn,                Godan daginn
Letter o,         òóôõöøōŏőơǒǫǭǿȍȏȫȭȯȱɔ,       ooooooooooooooooooooo
Acute capitals,   ÁǼĆÉǴÍĹŃÓŔŚÚÝŹ,              AAECEGILNORSUYZ
Circumflex small, âĉêĝîĵôŝûŵŷ,                 acegijosuwy
Double capitals,  ÆĲ№ŊŒÞ,                      AEIJNoNGOETH
Yours truly,      ℙėŗŀMȯƞķ Ąþåñąſïůș,          PerlMonk Athanasius
Krio,             Jɔs wan ɔda hakɛr,           Jos wan oda haker
