#!/usr/local/bin/jconsole
require 'regex'

am =: e.&(a. {~ 97+i.26)      NB. get mask of (lower case) alphabetic characters in string
NB. get indices of word beginnings except the first
wi =: (<(<0);0;0)&{@('(?<![a-z])(?=[a-z])[-a-z]+(?<=[a-z])(?![a-z])'&rxmatches)
trunc =: ] {.~ [ <. #@]       NB. truncate y at pos x

NB. convert to lower case, find indices of word beginnings, convert characters
NB. at these indices to upper case, drop non-alpha characters, prepend '#' and
NB. restrict to 100 characters
tag =: (100 trunc '#' , am # wi ((toupper@{)`[)} ])@tolower

Examples =: cutopen 0 : 0
Cooking with 5 ingredients!
the-last-of-the-mohicans
  extra spaces here
iPhone 15 Pro Max Review
Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!
)

Expected =: cutopen 0 : 0
#cookingWithIngredients
#thelastofthemohicans
#extraSpacesHere
#iphoneProMaxReview
#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo tag > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: tag&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''