#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("Cooking with 5 ingredients!"),  "#cookingWithIngredients");
test_line(1, quote("the-last-of-the-mohicans"),     "#thelastofthemohicans");
test_line(1, quote("  extra spaces here"),          "#extraSpacesHere");
test_line(1, quote("iPhone 15 Pro Max Review"),     "#iphoneProMaxReview");
test_line(1, quote("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"), "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn");

test_line(2, quote_list("RakuPerl", 4, "*"),    "(\"Raku\", \"Perl\")");
test_line(2, quote_list("Python", 5, "0"),      "(\"Pytho\", \"n0000\")");
test_line(2, quote_list("12345", 3, "x"),       "(\"123\", \"45x\")");
test_line(2, quote_list("HelloWorld", 3, "_"),  "(\"Hel\", \"loW\", \"orl\", \"d__\")");
test_line(2, quote_list("AI", 5, "!"),          "\"AI!!!\"");

done_testing;
