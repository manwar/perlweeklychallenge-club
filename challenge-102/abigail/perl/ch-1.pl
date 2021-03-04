#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# There is no simple efficient algorithm for spitting out rare numbers;
# at least not one which can be easily found online.
#
# The code fragments in the OEIS only give code to check whether a 
# number is a rare number, and they don't suggest anything other
# than "try all numbers" if you want to find all of the numbers of a
# certain length. 
#
# Shyam writes: "I have developed a computer program in Fortran to
# calculate Rare numbers. In fact with refinement of the code over
# the years, the program has been made so powerful that all numbers
# up to 10^14 can be just checked for Rare numbers in less than a
# minute on Pentium III PC. In few hours I have been able to check
# up to 10^18." (https://www.primepuzzles.net/conjectures/conj_023.htm)
# but he does not publish his code.
#
# Richard Guy writes "Here are three problems that have come to light
# recently, each of which can consume unlimited amounts of computer time,
# perhaps without revealing anything significant". [2]
# The rare numbers are one of the three problems.
#

#
# So, we just include a list of all know rare numbers, up to 10^22 [3],
# and preprocess them so they're bucketed to length. Then it's just
# a matter of reading the desired length, and printing the appropriate
# entry (or the empty string if no rare numbers of that length exist).
# There are only 124 known rare numbers, so preprocessing is very
# feasible.
#

#
# [1] https://www.primepuzzles.net/conjectures/conj_023.htm
# [2] Guy, Richard K. "Conway's RATS and Other Reversals." The American
#     Mathematical Monthly 96, no. 5 (1989): 425-28. Accessed March 1, 2021.
#     doi:10.2307/2325149. (https://www.jstor.org/stable/2325149?seq=1)
# [3] https://oeis.org/A035519/b035519.txt
#

my @rare_numbers;
$rare_numbers [ 2] =                     "65\n";
$rare_numbers [ 6] =                 "621770\n";
$rare_numbers [ 9] =              "281089082\n";
$rare_numbers [10] =             "2022652202\n" .
                                 "2042832002\n";
$rare_numbers [12] =           "868591084757\n" .
                               "872546974178\n" .
                               "872568754178\n";
$rare_numbers [13] =          "6979302951885\n";
$rare_numbers [14] =         "20313693904202\n" .
                             "20313839704202\n" .
                             "20331657922202\n" .
                             "20331875722202\n" .
                             "20333875702202\n" .
                             "40313893704200\n" .
                             "40351893720200\n";
$rare_numbers [15] =        "200142385731002\n" .
                            "204238494066002\n" .
                            "221462345754122\n" .
                            "244062891224042\n" .
                            "245518996076442\n" .
                            "248359494187442\n" .
                            "403058392434500\n" .
                            "441054594034340\n" .
                            "816984566129618\n";
$rare_numbers [16] =       "2078311262161202\n" .
                           "2133786945766212\n" .
                           "2135568943984212\n" .
                           "2135764587964212\n" .
                           "2135786765764212\n" .
                           "4135786945764210\n" .
                           "6157577986646405\n" .
                           "6889765708183410\n" .
                           "8052956026592517\n" .
                           "8052956206592517\n" .
                           "8191154686620818\n" .
                           "8191156864620818\n" .
                           "8191376864400818\n" .
                           "8650327689541457\n" .
                           "8650349867341457\n";
$rare_numbers [17] =      "22542040692914522\n" .
                          "67725910561765640\n" .
                          "86965750494756968\n";
$rare_numbers [18] =     "225342456863243522\n" .
                         "225342458663243522\n" .
                         "225342478643243522\n" .
                         "284684666566486482\n" .
                         "284684868364486482\n" .
                         "297128548234950692\n" .
                         "297128722852950692\n" .
                         "297148324656930692\n" .
                         "297148546434930692\n" .
                         "497168548234910690\n" .
                         "619431353040136925\n" .
                         "619631153042134925\n" .
                         "631688638047992345\n" .
                         "633288858025996145\n" .
                         "633488632647994145\n" .
                         "653488856225994125\n" .
                         "811865096390477018\n" .
                         "865721270017296468\n" .
                         "871975098681469178\n" .
                         "898907259301737498\n";
$rare_numbers [19] =    "2042401829204402402\n" .
                        "2060303819041450202\n" .
                        "2420424089100600242\n" .
                        "2551755006254571552\n" .
                        "2702373360882732072\n" .
                        "2825378427312735282\n" .
                        "6531727101458000045\n" .
                        "6988066446726832640\n" .
                        "8066308349502036608\n" .
                        "8197906905009010818\n" .
                        "8200756128308135597\n" .
                        "8320411466598809138\n";
$rare_numbers [20] =   "22134434735752443122\n" .
                       "22134434753752443122\n" .
                       "22134436953532443122\n" .
                       "22136414517954423122\n" .
                       "22136414971554423122\n" .
                       "22136456771730423122\n" .
                       "61952807156239928885\n" .
                       "61999171315484316965\n" .
                       "65459144877856561700\n";
$rare_numbers [21] =  "208393425242000083802\n" .
                      "219518549668074815912\n" .
                      "257661195832219326752\n" .
                      "286694688797362186682\n" .
                      "837982875780054779738\n";
$rare_numbers [22] = "2414924301133245383042\n" .
                     "2414924323311045383042\n" .
                     "2414946523311023183042\n" .
                     "2576494891793995836752\n" .
                     "2576494893971995836752\n" .
                     "2620937863931054483162\n" .
                     "2620937863931054483162\n" .
                     "2620955641393276283162\n" .
                     "2622935621573476481162\n" .
                     "2622935643751276481162\n" .
                     "2622937641933274481162\n" .
                     "2622955841933256281162\n" .
                     "2622957843751254281162\n" .
                     "2727651947516658327272\n" .
                     "2747736918335953517072\n" .
                     "2788047668617596408872\n" .
                     "2788047848617776408872\n" .
                     "2788047868437576408872\n" .
                     "2788047888617376408872\n" .
                     "2939501759705522349392\n" .
                     "2939503375709360349392\n" .
                     "2939503537707740349392\n" .
                     "2939521359525562149392\n" .
                     "2939521557527542149392\n" .
                     "2939523577527340149392\n" .
                     "2939523779525320149392\n" .
                     "2959503377707360349192\n" .
                     "6344828989519887483525\n" .
                     "8045841652464561594308\n" .
                     "8045841654642561594308\n" .
                     "8655059576513659814468\n" .
                     "8655059772157639814468\n" .
                     "8655079374155679614468\n" .
                     "8655079574515659614468\n" .
                     "8888070771864228883913\n";


print $rare_numbers [$_] // "" while <>;


__END__
