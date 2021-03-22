#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

die << "--";
This challenge is impossible. This is a children's game, played
with children who cannot read or write yet. The song is entirely
based on *sounds*. It is about how a name is pronounded, not how
it is written.

How a name is pronounced depends on language, region, and parential
preference.

For instance, what is the consonant sound starting names like Thom
(T?, Th?) or Christine (C?, Ch?, Chr?)? We cannot deduce that from
how it's written.

And what to do with names starting with a silent consonant? The
Greek goddess of sand beaches, for instance, Psamathe.

We might have a shot at solving this if the input were to be given
in IPA phonetic notation, but the one example given doesn't indicate
this is the intention.

And we refuse to do something stupid as just blindly chopping off
the leading consonant (if any) of a name. No pre-schooler would
sing a different song for Tijs than they would for Thijs (names,
which in my language are pronounced identically) -- and rightly so,
because the game removes the leading consonant sound, which is not
necessarily the leading consonant when written. Besides, what is
the first consonant of \x{5b54}\x{592b}\x{5b50}?

What to think about Victor? The name game has a special rule for
names starting with a 'b', 'f' or 'm' sound. There are languages
where the 'V' in Victor is very distinct from an 'f' sound -- and
there are languages where they are the same sound. Again, really
easy for pre-schoolers playing the game by sound; impossible to do
by text.

And then we haven't tackled the syllable count yet. Kyle. One or two
syllables?
--
