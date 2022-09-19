#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       orderly-sentencing.pl
#
#       Sentence Order
#         Submitted by: Mohammad S Anwar
#         You are given a paragraph.
# 
#         Write a script to order each sentence alphanumerically and print
#         the whole paragraph.
# 
#         Example
#         Input:
#             All he could think about was how it would all end. There was
#             still a bit of uncertainty in the equation, but the basics
#             were there for anyone to see. No matter how much he tried to
#             see the positive, it wasn't anywhere to be seen. The end was
#             coming and it wasn't going to be pretty.
# 
#         Ouput:
#             about All all could end he how it think was would. a anyone
#             basics bit but equation, for in of see still the the There
#             there to uncertainty was were. anywhere be he how it matter
#             much No positive, see seen the to to tried wasn't. and be
#             coming end going it pretty The to was wasn't.

#       Background
# 
#         One of the biggest obsticles facing any new reader is that the
#         words, simply put, are all over the place. WE might start near
#         the front of the alphabet, then jump hapazardly to near the end,
#         then back to the front again followed by somewhere in the middle.
#         To a casual observer this placement could reasonably be
#         considered random. It's exhausting, both mentally and physically.
# 
#         Even thinking about this state of affairs has left me emotionally
#         drained and dangeously unstable. It cannot stand.
# 
#         So what can we do to make this reading thing more user-friendly?
# 
#         Well, one thing that comes to mind is we could minimize the
#         lettering gaps between adjacent words in a sentence. We start
#         with all the "A" words and end with "Zymurgy", sould we be
#         unlucky enough to have to travel that far. Then, for the next
#         sentence, the next idea, we simply take a casual walk back to the
#         begining of the alphabet, each at our own pace, taking as much
#         advantage as required given the broad latitude in pausing
#         delivered by the punctuation marks.
# 
#         That sounds *way* better. Let's do that.
# 

#       Method
# 
#         We'll need to split our paragraph up two ways: once to break out
#         the individual sentences, then again within the sentence to sort
#         the words. Using `split` on the input paragraph, we can define a
#         regular expression to match out the terminal punctuation: period,
#         question mark or exclamation point.
# 
#             /[.?!]/
# 
#         Rewmewmber that a dot inside a character class is just a dot, not
#         a wildcard.
# 
#         But, you ask, what of that word, "alphanumerically" in the
#         challenge description? This does imply the possible existence of
#         numbers, and with them decimal points. And decimal points do look
#         suspiciously like periods. This could cause a problem should we
#         need to define pi within our sentence.
# 
#         Fortunately punctuation that actually ends a sentence is
#         invariably followed by a space, so if we include that in our
#         delimiter we're good again.
# 
#             /[.?!]\s/
# 
#         However as-is our sentence splitting does not simply split on but
#         removes and discards the terminal punctuation! Holy crap! How did we miss that?
# 
#         Wait, wait, take a deep breath. If we surround the delimiter
#         match with capture parentheses, the matched delimiter is returned
#         as an element in the split array. Then, because every sentence
#         has some sort of terminal puncuation we end up with pairs of
#         snetences and their closing marks.
# 
#         There's only one loose end remaining, being the last line of the
#         input, which likely has a period without a space as there's
#         nothing to separate it from. There may not even be a terminal
#         linefeed. Fortuantely we have a metacharacter for that: the
#         anchor `$` signifying the end of the string.
# 
#         What we end up with is
# 
#             split /([.?!](?:\s|$))/, $input
# 
#         which does what we need. 
# 
#         The last piece of the puzzle is to rearrange the words in each
#         sentence irrespective of any capitalization. We need to isolate
#         the sentece element from rthe first array and split it again, on
#         simple whitespace this time and sort the array. To perform the
#         sort case-insensitive the normal way we used to do things would
#         be to convert to lower- or uppercase and use that as the basis,
#         but with the introduction of Unicode we have an improvement in
#         "casefolding", being an generalized way of comparing strings
#         regardeless to case, not matter the specific meaning in non-Latin
#         alphabets. Using `fc()` is a bit less hacky as the function is
#         designed specifically to perform case-insensitive comparisons. 
# 

#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my $input = q(All he could think about was how it would all end. There was still a bit of uncertainty in the equation, but the basics were there for anyone to see. No matter how much he tried to see the positive, it wasn't anywhere to be seen. The end was coming and it wasn't going to be pretty.);

my @sentences = split /([.?!](?:\s|$))/, $input;

while (my ($sent, $punct) = splice @sentences, 0, 2) {
    my @w = sort { fc($a) cmp fc($b) } split /\s/, $sent;
    print "@w", $punct;
}
say '';










# use Test::More;
# 
# is 
# 
# done_testing();
