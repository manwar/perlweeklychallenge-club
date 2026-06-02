#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub doubled_words($str) {
    my $previous = "";
    my $from_p = 0;
    my $word = "";
    my $from = 0;
    my $pos = -1;
    while (1 + $pos++ < length $str) {
        my $c = substr $str, $pos, 1;
        if ($c =~ /\w/) {
            $from = $pos unless length $word;
            $word .= lc $c;

        } elsif ($c =~ /\W/) {
            if ($word eq $previous && length $word) {
                substr $str, $from_p, 0, '[';
                substr $str, $from_p + 1 + length $word, 0, ']';
                substr $str, $from + 2, 0, '[';
                substr $str, $pos + 3, 0, ']';
                $pos -= 4;
                # Second word followed by a tag.
                if ('<' eq $c) {
                    $previous = $word;
                    $word = "";
                    $from_p = $from;
                }
            }
            if ('<' eq $c) {
                ++$pos until '>' eq substr $str, $pos, 1;
            } else {
                $previous = $word;
                $word = "";
                $from_p = $from;
            }
        } else {
            die "Unknown [$c]";
        }
    }
    return join "\n", grep /\[/, split /\n/, $str
}

use Test::More tests => 5 + 5;

is doubled_words("you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."),
    "web server for doubled words (such as '[this] [this]'), a common problem",
    'Example 1';

is doubled_words("Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."),
    "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,",
    'Example 2';

is doubled_words("to make a word bold: '...it is <B>very</B> very important...'."),
    "to make a word bold: '...it is <B>[very]</B> [very] important...'.",
    'Example 3';

is doubled_words("Perl officially stands for Practical Extraction and Report Language, except when it doesn't."),
    "",
    'Example 4';

is doubled_words("There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."),
    "There's more than [one] [one] way to do it.",
    'Example 5';

is doubled_words("<hr><hr>"),
    "",
    'Doubled tag';

is doubled_words("This is <b>very</b>\nvery important."),
    "This is <b>[very]</b>\n[very] important.",
    'Tag plus newline';

is doubled_words("Several several words words on the same line"),
    "[Several] [several] [words] [words] on the same line",
    'Several words';

is doubled_words("Different tag <b>tag</b> order"),
    'Different [tag] <b>[tag]</b> order',
    'Different tag order';

# Not sure about this one: The test currently fails.
is doubled_words('Part of a w<b>or</b>d word tagged'),
    'Part of a [w<b>or</b>d] [word] tagged',
    'Part of a word tagged';
