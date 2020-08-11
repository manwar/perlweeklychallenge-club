#!/usr/bin/env perl6
#
#         63_1_drop_the_mic.raku
#
#         TASK #1 › Last Word
#         Submitted by: Mohammad S Anwar
#         Lovingly Crafted by: Ryan Thompson
#
#             Define sub last_word($string, $regexp) that returns the
#             last word matching $regexp found in the given string, or
#             undef if the string does not contain a word matching
#             $regexp.
#
#             For this challenge, a “word” is defined as any character
#             sequence consisting of non-whitespace characters (\S)
#             only. That means punctuation and other symbols are part of
#             the word.
#
#             The $regexp is a regular expression. Take care that the
#             regexp can only match individual words! See the Examples
#             for one way this can break if you are not careful.
#
#             Examples
#
#             last_word('  hello world',                qr/[ea]l/);      # 'hello'
#             last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
#             last_word("spaces in regexp won't match", qr/in re/);      #  undef
#             last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'
#
#         METHOD
#
#             It seems the main idea behind this challenge is in the
#             mechanics of passing a regular expression into a subroutine,
#             and in handling a variety of edge-cases that can arise whilst
#             still conforming to the required behavior.
#
#             In general, looking for the last occurrence of a thing
#             requires a sense of state to be updated, but finding one
#             solution and moving on is much simpler. So with that in mind,
#             we will tokenize our string and look for a match starting from
#             the end rather than the beginning. Returning after our first
#             match will find that last match in the original string. Easy
#             peasy.
#
#             Another detail is that the challenge explicitly asks for a
#             subroutine, so that is what we will create, along with a
#             wrapper to call it.
#
#             For the challenge description, we are given Perl 5
#             regexes, and the request to return undef. In Raku, we will
#             need to update this a little, as PCRE requires a little
#             expansion to allow for new abilities. The examples have
#             been altered accordingly. Also, undef has been replaced by
#             Nil, another trivial change in keeping with the spirit of
#             the specification. After that, accomplishing the task is
#             short and clear:
#
#             Note the subroutine asked for does return Nil here, and
#             the script when given Nil to report chooses to say «no
#             match found» instead to avoid confusion with a match.
#             Seems as good a way to handle this as any.
#
#           2020 colin crain
#
# # # # # # # # # # #

sub MAIN() {
    my @pairs =
            ['  hello world', rx/<[ea]>l/],
            ["Don't match too much, Chet!", rx:i/ch.t/],
            ["spaces in regexp won't match", rx:s/in re/],
            [(1 .. 1e6).join( ' ' ), rx/^(3.*?) ** 3/];
    for @pairs -> ($string, $regex) {
        (last_word( $string, $regex ) || '«no match found»').say
    }
}

## ## ## ## ## SUBS:

sub last_word ($string, $regex) {
    my @words = $string.split( /\s/, :skip-empty );
    for @words.reverse {
        return $_ if $_.match: /$regex/
    }
    return Nil;
}
