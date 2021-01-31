#! /opt/local/bin/perl
#
#       et-tu-brute.pl
#
#         TASK #1 › Caesar Cipher
#         Submitted by: Mohammad S Anwar
#         You are given string $S containing alphabets A..Z only and a number $N.
# 
#         Write a script to encrypt the given string $S using Caesar Cipher with
#         left shift of size $N.
# 
#         Example
#             Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
#             Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
#     
#             Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
#             Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
#     
#             Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
#             Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

#         method:
#             Left shift? Right shift? I'll mimic the example.

#             The Caesar cypher is a near trivial translation cypher, shifting
#             the alphabet as written a certain number of characters to the left
#             or right and wrapping around should the letter to be written fall
#             above "z" or below "a".
# 
#             The reassignment can be done with two lists, shifting one reletive
#             to the other and restarting the lists as required:
#             
#                 A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z 
#          +5      | | | | |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z  
#                  | | | | | | | | | | | | | | | | | | | | | | | | |     
#         -->     V|W|X|Y|Z|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U

#             After shifting, those letters beyond "Z" are moved to start the
#             list at "A", completing the translation. To encode, one looks up
#             the letter on the top list, then scans downward to find its
#             shifted encoding. To decode, the same operation is done in
#             reverse.

#             Although this simplest of ciphers can hardly even be called
#             cryptographic, there is reason to believe it may have been
#             effective in Caesar's time. With the reletively consistent
#             declension in Latin grammer it would have been relatively easy to
#             spot recurring word endings, and from there to work out the
#             offset, but there are no contemporanious accounts from anyone
#             figuring this out. Letter frequency analysis, used to attack less
#             regular cryptograms, would not be invented until the 9th century.
# 
#             It has also been suggested that most people in the position to
#             intercept a courier's message would be illterate anyway, including
#             the courier.
# 
#             As such the cypher functions more as an obsticle than a vault,
#             making a message require an effort to be read, akin to sealing an
#             envelope to turn away prying eyes.

#             In Perl, a straight rendition of the visual encoding method above
#             would be to use the translation operator, `tr/abc/xyz/`. Given a
#             string of characters and a matching association, the operator
#             reroutes one letter for another efficiantly and extremely quickly.
#             The problem with this is the operator works its magic building its
#             routing table at complile time, as so no variable interpolation is
#             allowed. So somehow we'd have to already know what our encoding
#             alphabet looks like even before we compute it, so we can
#             explicitly write out
 
#                 tr/ABCDEFGHIJKLMNOPQRSTUVWXYZ/FGHIJKLMNOPQRSTUVWXYZABCDE/

#             There's an obvious chicken-and-egg problem here, which is
#             generally solved using a string `eval` statement to interpolate
#             and then spin off a new Perl context to compile it in. There are
#             security concerns about turning `eval` loose on random user input,
#             so we're not going to do that today.
# 
#             The next best plan is to use a hash table, with each letter used
#             as a key pointing to a translated replacement. This requires some
#             calculation upfront to create the hash but once that is done its
#             smooth sailing. The difficulties, as they are, come from deriving
#             the pattern of the character offsets.
# 
#             A good way to do this would be by constructing an array comprised
#             of the letters in the alphabet repeated twice. For input the
#             letters would be indexed 0-25, and encoded we could add any offset
#             up to 26. The wrap around is taken care of by restarting the
#             letters with A at postion 26.
# 
#             I like this approach, but ultimately decided to pursue a more
#             mathematical solution. You see, letters as computer text already
#             have a numerical mapping built in to them, being the ASCII codes
#             that are actually recorded in memory for each character. With a
#             numerical association to the numbers 0 through 25, we can then use
#             modulo arithmetic to seamlessly loop around when shifting the
#             values.

#             The only complication to using ASCII codes being that the
#             numbering doesn't start at 0. For the upper-case letters, the
#             numbering goes from 65 to 90. But this is no mind, we only need to
#             upper case the text, get its number, subtract 65, add or subtract
#             the offset as determined, run the result modulo 26 and then add 65
#             again, then view the code as a number again.
# 
#             Well in Perl we have the functions `ord` and `chr` to shift back
#             and forth between charaters and ascii, and the rest is just some
#             arithmetic. 

#             To do the actual translation, I'd rather not break the text up
#             into an array. Sure that would work, but it would be nice to not
#             have to recopy the text. To this end we can unleash the regular
#             expression engine on the input string in a grand substitution
#             scheme, matching any letter. When any single lower- or uppercase
#             letter is matched, it is captured and handed off to a helper
#             translation routine that performs the numerical massaging magic
#             we've outlines above, returning the new character which is
#             substituted in for the original using the `/e` switch. Adding the
#             global `/g` swithc and we're streaming away.

#             If we wanted to the expression easily fits into one long line, but
#             having a helper is much easier on the eyes.

#             Whitespace will be preserved as that is the way it works in the
#             example. This is contrary to elementary rules of cyphering, as
#             word boundries reveal short words, which are limited in their
#             possiblities an provide a opportunity to attack the script.
#             Cyphers are normally broken into equal sized segments of
#             characters to confound this attack.
# 
#             I find it interesting that weak as this cypher may be now, as
#             Caesar would have used it it would have been a bit stronger, as
#             spacing between words date from only the Early Medieval era, with
#             Irish monks transcribing and illuminating Latin texts. It turns
#             out that reading fluency makes word gaps somewhat superfluous; the
#             reletive consistancy of Latin words and their declensions would
#             make it easy to identify the start and stopping of individual
#             words, and the grammar rules would dictate phrases. It was only
#             when early medieval scribes, at the time primarily Irish monks,
#             began to copy the Latin text that they began inserting additional
#             space to help keep the more unfamiliar texts straight. The
#             original Latin-language writers would always have had the option
#             of using an interpunct dot between words but this was not normally
#             done in common communications. Likewise spacing, which only worked
#             itself in on a paragraph level. Without word boundries to orient
#             the reader decyphering would be more difficult.
# 
# 
# 
# 
#        
#             
#             
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";


my $n   = shift // 3;
my $str = shift // "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";

say $str;
$str =~ s/([a-zA-Z])/encode($1,$n)/ge;
say $str;

sub encode {
    my $out = chr(((ord(uc $_[0])-65-$_[1])%26)+65);
}
