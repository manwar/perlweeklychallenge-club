#!/bin/env raku

# The Weekly Challenge 369
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Valid Tag
pwc-test './ch-1.raku',
    'Cooking with 5 ingredients!',
    '#cookingWithIngredients',
    "Valid Tag: 'Cooking with 5 ingredients!'" ~
    ' => #cookingWithIngredients';
pwc-test './ch-1.raku',
    'the-last-of-the-mohicans',
    '#thelastofthemohicans',
    "Valid Tag: 'the-last-of-the-mohicans'" ~
    ' => #thelastofthemohicans';
pwc-test './ch-1.raku',
    '  extra spaces here',
    '#extraSpacesHere',
    "Valid Tag: '  extra spaces here'" ~
    ' => #extraSpacesHere';
pwc-test './ch-1.raku',
    'iPhone 15 Pro Max Review',
    '#iphoneProMaxReview',
    "Valid Tag: 'iPhone 15 Pro Max Review'" ~
    ' => #iphoneProMaxReview';
pwc-test './ch-1.raku',
    'Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!',
    '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn',
    "Valid Tag: 'Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!'" ~
    ' => #ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn';

# Task 2, Group Division
pwc-test './ch-2.raku', <RakuPerl 4 *>,   'Raku Perl',       'Group Division: $str="RakuPerl",   $size=4, $filler="*" => Raku, Perl';
pwc-test './ch-2.raku', <Python 5 0>,     'Pytho n0000',     'Group Division: $str="Python",     $size=5, $filler="0" => Pytho, n0000';
pwc-test './ch-2.raku', <12345 3 x>,      '123 45x',         'Group Division: $str="12345",      $size=3, $filler="x" => 123, 45x';
pwc-test './ch-2.raku', <HelloWorld 3 _>, 'Hel loW orl d__', 'Group Division: $str="HelloWorld", $size=3, $filler="_" => Hel, loW, orl, d__';
pwc-test './ch-2.raku', <AI 5 !>,         'AI!!!',           'Group Division: $str="AI",         $size=5, $filler="!" => AI!!!';
