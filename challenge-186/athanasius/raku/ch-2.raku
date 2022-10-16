use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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
The hash %ASCII-TO-UNICODE maps ASCII characters to their Unicode equivalents.
This presents the required data in a convenient form. The create-lookup() sub-
routine reverses this hash to create the hash %UNICODE-TO-ASCII, which maps
Unicode characters to their ASCII equivalents. This is the lookup table used in
making the required replacements. 

Any character not entered in the lookup table is simply left unchanged in the
output string.

=end comment
#==============================================================================

use Test;

my constant %ASCII-TO-UNICODE =
    A  => [ < À Á Â Ã Ä Å Ā Ă Ą Ǎ Ǟ Ǡ Ȁ Ȃ Ȧ Ⱥ Ḁ         > ],
    AE => [ < Æ Ǣ Ǽ                                     > ],
    A  => [ < À Á Â Ã Ä Å Ā Ă Ą Ǎ Ǟ Ǡ Ȁ Ȃ Ȧ Ⱥ Ḁ         > ],
    AE => [ < Æ Ǣ Ǽ                                     > ],
    B  => [ < Ɓ Ƃ Ƀ Ḃ Ḅ                                 > ],
    C  => [ < Ç Ć Ĉ Ċ Č Ƈ Ȼ ℂ                           > ],
    D  => [ < Ð Ď Đ Ɖ Ɗ Ƌ                               > ],
    E  => [ < È É Ê Ë Ē Ĕ Ė Ę Ě Ȅ Ȇ Ȩ                   > ],
    F  => [ < Ƒ                                         > ],
    G  => [ < Ĝ Ğ Ġ Ģ Ɠ Ǧ Ǵ                             > ],
    H  => [ < Ĥ Ħ Ȟ ℍ                                   > ],
    I  => [ < Ì Í Î Ï Ĩ Ī Ĭ Į İ Ɩ Ɨ Ǐ Ȉ Ȋ               > ],
    IJ => [ < Ĳ                                         > ],
    J  => [ < Ĵ                                         > ],
    K  => [ < Ķ Ƙ Ǩ                                     > ],
    L  => [ < £ Ĺ Ļ Ľ Ŀ Ł Ƚ                             > ],
    N  => [ < Ñ Ń Ņ Ň Ɲ Ǹ Ƞ ℕ                           > ],
    No => [ < №                                         > ],
    NG => [ < Ŋ                                         > ],
    O  => [ < Ò Ó Ô Õ Ö Ø Ō Ŏ Ő Ɵ Ơ Ǒ Ǫ Ǭ Ǿ Ȍ Ȏ Ȫ Ȭ Ȯ Ȱ > ],
    OE => [ < Œ                                         > ],
    P  => [ < Ƥ ℙ                                       > ],
    Q  => [ < ℚ                                         > ],
    R  => [ < Ŕ Ŗ Ř Ȑ Ɍ ℝ                               > ],
    S  => [ < Ś Ŝ Ş Š Ș                                 > ],
    T  => [ < Ţ Ť Ŧ Ƭ Ʈ Ț Ⱦ                             > ],
    TH => [ < Þ                                         > ],
    U  => [ < Ù Ú Û Ü Ũ Ū Ŭ Ů Ű Ų Ư Ǔ Ǘ Ǚ Ǜ Ȕ Ȗ Ʉ       > ],
    V  => [ < Ʋ                                         > ],
    W  => [ < Ŵ                                         > ],
    Y  => [ < ¥ Ý Ŷ Ÿ Ƴ Ȳ                               > ],
    Z  => [ < Ź Ż Ž Ƶ Ʒ Ǯ Ȥ ℤ                           > ],
    a  => [ < à á â ã ä å ā ă ą ǎ ǟ ǡ ȁ ȃ ȧ ḁ           > ],
    ae => [ < æ ǣ ǽ                                     > ],
    b  => [ < ƀ ƃ ḃ                                     > ],
    c  => [ < ¢ ç ć ĉ ċ č ƈ ȼ                           > ],
    d  => [ < ð ď đ ƌ ȡ                                 > ],
    e  => [ < è é ê ë ē ĕ ė ę ě ȅ ȇ ȩ ℮ ɛ               > ],
    f  => [ < ƒ                                         > ],
    g  => [ < ĝ ğ ġ ģ ǧ ǵ                               > ],
    h  => [ < ĥ ħ ȟ ℎ ℏ                                 > ],
    i  => [ < ì í î ï ĩ ī ĭ į ı ǐ ȉ ȋ                   > ],
    ij => [ < ĳ                                         > ],
    j  => [ < ĵ ǰ ȷ                                     > ],
    k  => [ < ķ ĸ ƙ ǩ                                   > ],
    l  => [ < ĺ ļ ľ ŀ ł ƚ ȴ                             > ],
    n  => [ < ñ ń ņ ň ŉ ƞ ǹ ȵ                           > ],
    ng => [ < ŋ                                         > ],
    o  => [ < ò ó ô õ ö ø ō ŏ ő ơ ǒ ǫ ǭ ǿ ȍ ȏ ȫ ȭ ȯ ȱ ɔ > ],
    oe => [ < œ                                         > ],
    p  => [ < ƥ                                         > ],
    r  => [ < ŕ ŗ ř ȑ ɍ                                 > ],
    s  => [ < ś ŝ ş š ſ ș ȿ                             > ],
    ss => [ < ß                                         > ],
    t  => [ < ţ ť ŧ ƫ ƭ ț ȶ                             > ],
    th => [ < þ                                         > ],
    u  => [ < ù ú û ü ũ ū ŭ ů ű ų ư ǔ ǘ ǚ ǜ ȕ ȗ         > ],
    w  => [ < ŵ ƿ                                       > ],
    y  => [ < ý ÿ ŷ ƴ ȳ                                 > ],
    z  => [ < ź ż ž ƶ ƺ ǯ ȥ ɀ                           > ];

my UInt constant $TEST-FIELDS = 3;

my %UNICODE-TO-ASCII;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 186, Task #2: Unicode Makeover (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Str:D $str                       #= A Unicode string
)
#==============================================================================
{
    my UInt $args = @*ARGS.elems;

    $args == 1 or error( "Expected 0 or 1 arguments, found $args" );

    create-lookup();

    "Input: \$str = '$str'".put;

    my Str $out = makeover( $str );

    "Output:       '$out'".put;
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    create-lookup();

    for test-data.lines -> Str $line
    {
        my Str ($name, $in, $exp) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        my Str $out = makeover( $in );

        is $out, $exp, $name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub makeover( Str:D $str --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $plain;

    for $str.split( '', :skip-empty ) -> Str $char
    {
        if %UNICODE-TO-ASCII{ $char }:exists
        {
            $plain ~= %UNICODE-TO-ASCII{ $char };
        }
        else
        {
            $plain ~= $char;
        }   
    }

    return $plain;
}

#------------------------------------------------------------------------------
sub create-lookup
#------------------------------------------------------------------------------
{
    for %ASCII-TO-UNICODE.keys -> Str $key
    {
        for %ASCII-TO-UNICODE{ $key }.list -> Str $val
        {
            %UNICODE-TO-ASCII{ $val } = $key;
        }
    }
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
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
     END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
