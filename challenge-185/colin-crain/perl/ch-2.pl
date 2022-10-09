#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       the-masked-ball.pl
#
#       Mask Code
#         Submitted by: Mohammad S Anwar
#         You are given a list of codes in many random format.
# 
#         Write a script to mask first four characters (a-z,0-9) and keep
#         the rest as it is.
# 
#         Example 1
#             Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
#             Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
# 
#         Example 2
#             Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
#             Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')
# 

#         analysis:
# 
#             I’d say the biggest obstacle in front of us, in coming up
#             with a process for this task, would be the completely unknown
#             formatting surrounding the characters that we wish to mask.
#             The first four characters in simple string, for instance,
#             would be a trivial substitution. Or alternately, should the
#             targets be interspersed among some fixed position delimiters
#             or spacers, well, if we knew where to look those strings too
#             would be straightforward to parse.
# 
#             But this is not to be. We are seemingly assured there will be
#             four characters to mask, and can take that for granted, but
#             we have idea whatsoever of their positioning. We will need to
#             search for them to find them, and swap out the first four we
#             find.
# 
#             However we do know one thing right off the bat, or at least
#             can derive it fairly simply: that is that if the characters
#             we are to match are drawn from the set of digits and
#             lowercase letters, then the formatting must exclusively be
#             composed of characters not in that set.
# 
#             This makes sense and pretty much has to be, or else the
#             formatting would indistinguishable from the serial
#             characters. And this might be fine for the purposes of
#             obfuscation, but without being alerted to the arrangement
#             there would be no way for us, on the outside, to filter them
#             out and pursue the task.
# 
#             Ergo the format characters must be comprised of characters
#             from the complement set of those we wish to match. We might
#             not know much, but we do know that.
# 
#             Let’s start by thinking this through in the most basic way we
#             can. We could build a loop and look at the strings starting
#             with the left-most character, replacing each with an “x” if
#             it’s found within the set of those to be masked, or skipping
#             over it if it is not. Once we’ve counted four substitutions
#             we’re done.
# 
#             This seems a functional and straightforward approach to the
#             problem that would work just fine.
# 
#             But it’s also just a language-independent outline to an
#             algorithm. Which leads us to the question: “What does Perl
#             have to offer us, to help us out here today?”
# 
#             Well how about regular expressions? We’re matching characters
#             and performing a search-and-replace. That’s a very Perlish
#             thing to do. Not quite unique as it once was, but we did kind
#             of write the book on the subject.
# 
#             Let’s do that.

# 
#           method:
# 
#             Using the substitution operator, we immediately run into
#             troubles. For you see, the replacement character “x” is
#             itself located in the set of characters to be replaced. So if
#             we were to replace one character at a time in a loop:
# 
#             s/[a-z0-9]/x/ for (1..4) — we would start at the left side of
#             the string and replace the first character that matches the
#             character class we’ve defined with “x”. Then we would go
#             again, find that “x” again and replace it with “x” again.
# 
#             Yea, this is not what we were wanting in life. Down that road
#             is nothing but disappointment and regret.
# 
#             Ok, fine. All is not lost though! There’s always another way
#             out! We can instead perform a global search-and-replace,
#             using the /g switch:
# 
#             s/[a-z0-9]/x/g This, however, goes way too far. It replaces
#             every single occurrence that matches within the string, when
#             we only want to alter the first four. And that, my friends,
#             is our problem in a nutshell: how do we search for and
#             replace only the first four characters using a regex?
# 
#             Yes that was a long-winded way to cycle around to basically
#             where we started, but it is good to be precise. I see two
#             ways to go about it.
# 
#             To be more accurate: as I’m writing this after the fact, now
#             I see two ways, but when I started I only saw one obvious
#             route, and had a sort of vague plan for the other. I knew it
#             was in there somewhere.
# 
#             The obvious path would be to unroll the loop inside the
#             regular expression and directly match all four characters at
#             once. It’ll be long, but repeat itself.
# 
#             As deduced above, even without any knowledge of the
#             formatting we can divide all the characters in the input
#             string into two classes: those characters to be masked and
#             those containing formatting to be ignored. These can be
#             codified into two complementary regex character classes:
#             [a-z0-9], and it’s negation [^a-z0-9]. Any character will be
#             in one or the other. We can then further streamline things by
#             assigning these classed to variables: $chr and $non.
# 
#             Next we will need to divide the string in some way, into
#             sub-groups containing one matched character to be replaced,
#             collected together with any surrounding formatting up until
#             we get to the next group boundary. As there’s nothing
#             preventing a string from starting with formatting, we will
#             need to lead with that possibility. Our pattern is now zero
#             or more formatting characters followed by one masked
#             character. We capture the formatting so we can replicate it
#             in the substitution portion, but throw out the masked
#             character as we will no longer need it. Like this:
# 
#             /($non*)$chr/
# 
#             This is one atomic element and we need four of these:
# 
#             /($non*)$chr($non*)$chr($non*)$chr($non*)$chr/
# 
#             Replace this with the capture group variables and new xs and
#             we’re done:
# 
#             s/($non*)$chr($non*)$chr($non*)$chr($non*)$chr/$1x$2x$3x$4x/
# 
# 
#           a cooler way:
# 
#             This is all well and good, but there has to be a cooler way,
#             right? Of course there is.
# 
#             The cooler way requires us to crack the idea of how to
#             somehow loop over replacement matching, starting where we had
#             previously left off yet only performing four substitutions.
# 
#             Global substitution will take care of the
#             starting-where-we-left-off part, but as we said will attempt
#             to match all the way across the string and there ain’t
#             nothin’ we can do about that. Or is there? Note we said it
#             will attempt to match, not that it would. If we can force it
#             to fail the match then we can limit the effects. This is the
#             way.
# 
#             What we need is a counter.
# 
#             A good trick to remember with counters is instead of counting
#             upwards and then checking against a limit with a conditional,
#             we can count downwards and when the value reaches zero it
#             will fail a truth test. This can produce very neat and
#             compact structures.
# 
#             We match, then, our familiar assemblage of a formatting
#             capture and a masked character, and append a zero-width
#             conditional assertion in the pattern to make sure we’re still
#             counting when we cycle around with each global match. We then
#             combine this structure with the /e switch to make the
#             replacement section a code block to be evaluated, that will
#             in turn return the string to be inserted. And that’s where we
#             decrement our counter. The last line of the replacement block
#             is what is returned, so we provide a double-quoted string
#             with the capture group and the character x.
# 
#             /$mask--; "$1x"/
# 
#             In the substitution portion, inside our post-fix conditional,
#             we provide two options to match, grouped with non-capturing
#             parentheses and joined with a logical OR. Either the counter
#             returns a true value, meaning it isn’t yet 0 (or somehow has
#             become undefined), or we try the other half of the OR, which
#             is the verb *FAIL.
# 
#             As you might guess from the strong language this always
#             causes that particular match attempt to fail. The engine then
#             backtracks and tries the next start point to proceed.
# 
#             So with every substitution we swap one masked character for
#             an x, preserve any preceding formatting, and decrement a
#             counter by 1. When the counter reaches 0, the conditional
#             fails, the match attempt fails, and so the replacement
#             portion is never evaluated. The counter stays at 0 and no
#             more matches can no ever be made.
# 
#             Which is exactly what we wanted.
# 
#             Although the first method is probably more practical for a
#             robust, fixed solution that once set up will never change, I
#             do like the second method for its logical elegance. I knew
#             there must be a way — it just too me a little while to figure
#             it out.
# 
# 
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
use constant { MASK_WIDTH => 4 };

my @input = ('ab-cde-123', '123.abc.420', '3abc-0010.xy', 
             '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');           

my $chr   = '[a-z0-9]';
my $non   = '[^a-z0-9]*';


for (@input) {
    my $mask = MASK_WIDTH;
    
    ## repeat the unaltered input string
    say;
    
    ## output altered copies of the input using /r switch
    
    ## REGEX 1 - unrolled
    say s/($non)$chr($non)$chr($non)$chr($non)$chr/$1x$2x$3x$4x/r;

    ## REGEX 2 - eval counter
    say s/($non)$chr(?(?{$mask})|(*FAIL))/$mask--; "$1x"/egr;
    
    say '';
}




