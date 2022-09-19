#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       tendon-ous-task.pl
#
#       Achilles Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Achilles Numbers. Please
#         checkout wikipedia for more information.
# 
#         An Achilles number is a number that is powerful but imperfect
#         (not a perfect power). Named after Achilles, a hero of the Trojan
#         war, who was also powerful but imperfect.
# 
#         A positive integer n is a powerful number if, for every prime
#         factor p of n, p^2 is also a divisor.
# 
#         A number is a perfect power if it has any integer roots (square
#         root, cube root, etc.).
# 
#         For example 36 factors to (2, 2, 3, 3) - every prime factor (2,
#         3) also has its square as a divisor (4, 9). But 36 has an integer
#         square root, 6, so the number is a perfect power.
# 
#         But 72 factors to (2, 2, 2, 3, 3); it similarly has 4 and 9 as
#         divisors, but it has no integer roots. This is an Achilles
#         number.
# 
# 
#         Output
#             72,  108,  200,  288,  392,  432,  500,  648,  675,  800,  
#             864, 968,  972, 1125, 1152, 1323, 1352, 1372, 1568, 1800
#

#       discussion:
# 
#         One unexpected delight in the past year's excursions into number
#         theory has been the amount of wordplay involved. One probably
#         wouldn't expect that from a mathematical crowd, but then again
#         play is play, and people who like to play have a tendency to play
#         with whatever they have around them — numbers, words, game
#         tokens, stories and fictional flights of fancy.
# 
#         In this case enter Achilleus, Ancient Greek Ἀχιλλεύς, a demigod
#         who fought for Athens in the Trojan Wars. Achilleus, known in
#         English more often as Achilles, was the progeny of a god and a
#         nymph, which, although this union produced a mortal man, he
#         retained some of the powers of the gods, and he was Athen's
#         greatest warrior in the fight.
# 
#         Achilleus was a proud man, and himself stated that he was driven
#         by his pride. Excessive pride, ὕβρις or hubris, was frowned upon
#         by the gods, taken to be a sign of man upsetting his station in
#         the world, and improperly venturing into the terrtory of the
#         gods. When Achilleus refuses to fight for his side because of an
#         percieved slight this pridefullness comes to a head. His friend
#         goes to the battlefield in his stead and is killed. Enraged,
#         Achilleus rejoins the battle and looks to single-handedly tip the
#         scales back to Athens and win the war.
# 
#         However this was not fated, and the gods took notice. Achilleus
#         had fought for his pride, not his city, and when he reacted to a
#         slight started actions that produced the death of his friend and
#         now were threatening the role of the fates themselves.
# 
#         THis would not do. Achilleus' hubris became his ἁμαρτία, or
#         hamartíā: his fatal flaw, his undoing. The Greek gods were known
#         for disproportionate justice against the inconsequence of mere
#         mortals. Although his prowness on the battlefield made him seem
#         untouchable in a fight, Apollo personally guided an arrow into
#         his heart, killing him.
# 
#         So Achilleus is the most powerful warrior in the Athenian army,
#         but for all that power had a fatal flaw, hamartíā, that led to
#         his downfall. 

#         ---
# 
#         The wordplay in the labeling this particular sequence as Achilles
#         Numbers is layered like an onion. Numbers whose prime factors are
#         all raised to at least the power of 2 are known as powerful
#         numbers. Because, you know, they are full of powers. Then we have
#         numbers that are the product of an exponential term, such as a
#         value being squared or cubed, or raised to a higher power. As a
#         group, these are known as perfect powers: perfect squares,
#         perfect cubes, and so on.
# 
#         So a powerful number that is also is imperfect, which is to say
#         it is powerful but not a perfect power, is like Achilles. 
#        
#       method:
# 
#         For a number to be powerful, it must have all of its prime
#         factors at least doubled.
# 
#         For a number to be a perfect power, then the count of all of its
#         prime factors must be at least 2 and furthermore the count of
#         each prime must be equal to that of all the others. The number
#         216, for example, has the factors (2, 2, 2, 3, 3, 3), which
#         allows each 2 to be paired up with a 3, and so can be expressed
#         as 6 cubed.
# 
#         So we're going to count primes among the factors. If the count of
#         each prime is greater than 1, but the counts are *not* all equal,
#         then we have an Achilles Number. 
        
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use ntheory qw( factor gcd );
use constant { QUANTITY => 20 };

my @achilles;
my $candidate = 1;

while ( $candidate++ ) {
    my @f = factor( $candidate );
    my %freq;
    $freq{$_}++ for @f;
    
    my @values = sort {$a<=>$b} values %freq;
            
    next if $values[0]     == 1;    ## not powerful
    next if gcd( @values ) >  1;    ## is perfect power

    push @achilles, $candidate;
    last if @achilles == QUANTITY;
}

say "@achilles";

