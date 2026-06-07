#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

#
# Read in the full text
#
local $/;
my $text = <>;

#
# Pattern for parsing an HTML tag
#
# https://dev.w3.org/html5/spec-LC/syntax.html
# https://html.spec.whatwg.org/multipage/syntax.html
#
my $tag_re = qr {
    (?(DEFINE)
        (?<WS>                     [ \t\n\r\f]+)
        (?<OPT_WS>                 [ \t\n\r\f]*)
        (?<ASCII_ALPHA>            [a-zA-Z])
        (?<ASCII_ALPHANUM>         [a-zA-Z0-9])
        (?<EQ>                     (?: (?&OPT_WS) = (?&OPT_WS)))
        (?<TAG_NAME>               (?: (?&ASCII_ALPHA) (?&ASCII_ALPHANUM)*))
        (?<ATTR_NAME>              (?[ \p{Any} - \p{Control} -
                                       [\x{00} \t\n\r\f"'=/>]])+)

        (?<ATTR_VAL_UNQUOTED>      (?[\p{Any} - [\x{00}\p{Control}] -
                                        [ \t\n\r\f] - ['"=<>`]])+)
        (?<ATTR_VAL_SINGLE_QUOTED> ' (?[ \p{Any} - [\x{00}'] -
                                        (\p{Control} - [ \t\n\r\f])])* ')
        (?<ATTR_VAL_DOUBLE_QUOTED> " (?[ \p{Any} - [\x{00}"] -
                                        (\p{Control} - [ \t\n\r\f])])* ")

        (?<ATTR_EMPTY>             (?&ATTR_NAME))
        (?<ATTR_UNQUOTED>          (?:(?&ATTR_NAME) (?&EQ)
                                      (?&ATTR_VAL_UNQUOTED) (?!/)))
        (?<ATTR_SINGLE_QUOTED>     (?:(?&ATTR_NAME) (?&EQ)
                                      (?&ATTR_VAL_SINGLE_QUOTED)))
        (?<ATTR_DOUBLE_QUOTED>     (?:(?&ATTR_NAME) (?&EQ)
                                      (?&ATTR_VAL_DOUBLE_QUOTED)))
        (?<ATTR>                   (?:(?&WS) (?: (?&ATTR_EMPTY)         | 
                                                 (?&ATTR_UNQUOTED)      |
                                                 (?&ATTR_SINGLE_QUOTED) |
                                                 (?&ATTR_DOUBLE_QUOTED))))
        (?<ATTR_LIST>              (?&ATTR)*)
        (?<START_TAG>              <  (?&TAG_NAME) (?&ATTR_LIST) (?&OPT_WS) /?>)
        (?<END_TAG>                </ (?&TAG_NAME) (?&OPT_WS) >)
        (?<TAG>                    (?:(?&START_TAG) | (?&END_TAG)))
    )
    (?&TAG)
}x;


#
# Tokenize the text: split into words and non-words
#
# Note that the rules inside the (?(DEFINE) ... ) *do* generate capture,
# thought they don't capture anything -- not even an empty string.
# So we need to filter out the undefined captures.
#
my @chunks = grep {defined}
             $text =~ /(  \p{XPosixAlnum}+                     # A word
                        | (?:$tag_re|[^\p{XPosixAlnum}<]+|<)+  # Not a word
                       )/gx;

#
# Find double words. Note that in @chunks words and non-words alternate,
# but we need to figure out whether we start with a word or a non-word
#
my $start_i = $chunks [0] =~ /^\p{XPosixAlnum}/ ? 0 : 1;
for (my $i = $start_i; $i < @chunks; $i += 2) {
    my $base   = $chunks [$i];
    my $double = 0;
    for (my $j = $i + 2; $j < @chunks; $j += 2) {
        #
        # Search for doubled words. Note we have a "one one one"; we 
        # cannot stop after finding the next one.
        #
        # Use fold-case to compare words
        #
        last unless fc $base eq fc $chunks [$j];
        $chunks [$j] = "[" . $chunks [$j] . "]";
        $double = $j;
    }
    if ($double) {
        $chunks [$i] = "[" . $chunks [$i] . "]";
        $i = $double;
    }
}

#
# Print only the line(s) with doubled words
#
say for grep {/\[/} split /\n/ => join "" => @chunks; 
