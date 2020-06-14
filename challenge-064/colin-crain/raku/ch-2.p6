#!/usr/bin/env perl6
#         TASK #2 › WORD BREAK
#
#         Submitted by: Mohammad S Anwar
#
#             You are given a string $S and an array of words @W.
#
#             Write a script to find out if $S can be split into
#             sequence of one or more words as in the given @W.
#
#             Print the all the words if found otherwise print 0.
#
#             EXAMPLE 1:
#
#             Input:
#
#             $S = "perlweeklychallenge"
#             @W = ("weekly", "challenge", "perl")
#
#             Output:
#
#             "perl", "weekly", "challenge"
#             EXAMPLE 2:
#
#             Input:
#
#             $S = "perlandraku"
#             @W = ("python", "ruby", "haskell")
#
#             Output:
#
#             0 as none matching word found.
#
#         METHOD
#
#             I have been called… things… for my love of regular
#             expressions. That it wasn’t natural. Suggestions that
#             there was something… off maybe, somewhere deep inside me.
#             Not to discount the possibility that those people were on
#             to something, I have persisted in the face of the critics.
#             Refusing to be shamed, I announce it to the world. It has
#             always been perhaps my favorite feature of the language,
#             which is no small praise in a language with so many nice
#             thing to say about it.
#
#             One cannot overstate the immense power contained in the
#             DSL that is Perl Regular Expressions. The added features
#             of the Raku RE engine only serve to augment that power,
#             and every time I have an opportunity to learn about
#             something new they’ve come up with I find myself giggling
#             with glee. Oh you can do that now? Sweet… Larry’s vision
#             of RE really knocked it out of the park when Perl grew to
#             rule the web, and the PCRE library spawned from that
#             effort still holds a very promenant position today. With
#             Raku, they have in a sense applied a metaoperator to the
#             the very idea of regexes, expanding the initial DSL into a
#             complete object ecosystem known as Grammers which we can
#             in turn use to write new DSLs.* It does take a little
#             getting used to coming from pure Perl, but it well worth
#             the effort.
#
#             This challenge, as I understand it, seems to me to be a
#             straightforward application of regular expressions.
#
#           ---------------
#             * Andrew Shitov Creating a Complier With Raku
#             https://andrewshitov.com/creating-a-compiler-with-raku/

sub MAIN(Str:D $string, *@words) {
    my $group = @words.join(' | ');
    my $matches = $string ~~ m:g/ <$group> /;
    $matches.list.elems ?? (.Str.say for $matches.list)
                        !!   say '0';

#    say "two:";
#    $matches = $string ~~ m:g/
#                             | weekly
#                             | perl
#                             | challenge
#                              /;
#    .Str.say for $matches.list;

}
