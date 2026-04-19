#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 369 Task 1: Valid Tag
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use utf8::all;
use Text::Unidecode;

sub valid_tag_short( $caption ) {
    return substr(
        "#" . lcfirst( join "",
            map ucfirst,
                split " ",
                    lc unidecode( $caption ) =~ s/[^[:alpha:]\s]//igr ),
        0, 100 );
}

sub valid_tag( $caption ) {
    # Translate all non-ASCII UNICODE characters into an ASCII representation.
    $caption = unidecode( $caption );

    # Remove everything that is not a letter or whitespace.
    $caption =~ s/[^[:alpha:]\s]//ig;

    # Transform the whole string into lower case,
    # then split into words on any sequence of whitespace.
    # Uppercase the first letter of each word.
    my @words = map ucfirst, split " ", lc $caption;

    # Combine the words into a hash tag,
    # lowercasing the first letter of the result.
    my $hash_tag = "#" . lcfirst join "", @words;

    # Return the first 100 characters.
    return substr( $hash_tag, 0, 100 );
}

use Test2::V0 qw( -no_srand );

is valid_tag( "Cooking with 5 ingredients!" ), "#cookingWithIngredients",
    'Example 1: valid_tag( "Cooking with 5 ingredients!" )' . "\n"
        . '    eq "#cookingWithIngredients"';
is valid_tag( "the-last-of-the-mohicans" ), "#thelastofthemohicans",
    'Example 2: valid_tag( "the-last-of-the-mohicans" )' . "\n"
        . '    eq "#thelastofthemohicans"';
is valid_tag( "  extra spaces here" ), "#extraSpacesHere",
    'Example 3: valid_tag( "  extra spaces here" ) eq "#extraSpacesHere"';
is valid_tag( "iPhone 15 Pro Max Review" ), "#iphoneProMaxReview",
    'Example 4: valid_tag( "iPhone 15 Pro Max Review" )' . "\n"
        . '    eq "#iphoneProMaxReview"';
is valid_tag(
    "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely"
        . " by Artificial Intelligence and Voice Commands in the year 2026!" ),
    "#ultimateHourChallengeLivingInASmartHomeControlledEntirely"
        . "ByArtificialIntelligenceAndVoiceCommandsIn",
    'Example 5: valid_tag( "Ultimate 24-Hour Challenge: [...] 2026!" )' . "\n"
        . '    eq "#ultimateHourChallenge[...]CommandsIn [100 chars]"';

is valid_tag(
    "Some greek letters and their names: ἄλφα βῆτα γάμμα δέλτα the α and ω" ),
    "#someGreekLettersAndTheirNamesAlphaBetaGammaDeltaTheAAndO",
    'Own Test 1: valid_tag(' . "\n"
        . '"Some greek letters and their names:'
            . ' ἄλφα βῆτα γάμμα δέλτα the α and ω" )' . "\n"
        . '    eq "#someGreekLettersAndTheirNamesAlphaBetaGammaDeltaTheAAndO"';

is valid_tag(
    "Élégance à Noël : Où déguster des pâtés,"
        . " bœufs rôtis et crèmes brûlées à l’ancienne ?" ),
    "#eleganceANoelOuDegusterDesPatesBoeufsRotisEtCremesBruleesALancienne",
    'Own Test 1: valid_tag('
        . ' "Élégance à Noël : Où déguster des pâtés,' . "\n"
        . '     bœufs rôtis et crèmes brûlées à l’ancienne ?" ) eq' . "\n"
        . '"#eleganceANoelOuDegusterDesPates'
            . 'BoeufsRotisEtCremesBruleesALancienne"' . "\n"
        . '    not:' . "\n"
        . '"#lganceNolODgusterDesPtsBufsRtisEtCrmesBrlesLancienne"';

done_testing;
