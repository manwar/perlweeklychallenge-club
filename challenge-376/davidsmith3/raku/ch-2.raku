#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 376 Task 2

Submitted by: Matt Martini
=head2 Doubled Words

You are given a string (which may contain embedded newlines) which is taken from a page on a website. The string will not contain brackets qw{ [ ] }.

Write a script that will find doubled words (such as “this this”) and highlight (wrap in brackets) each doubled word.

The script should:

- Work across lines, even finding situations where a word at the end of
  one line is repeated at the beginning of the next.

- Find doubled words despite capitalization differences, such as with
  'The the...', as well as allow differing amounts of whitespace (spaces,
  tabs, newlines, and the like) to lie between the words.

- Find doubled words even when separated by HTML tags. For example, to
  make a word bold: '...it is <B>very</B> very important...'. Only show
  lines containing doubled words.

=head3 Example 1:
Input: $str = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."
Output: "web server for doubled words (such as '[this] [this]'), a common problem"

=head3 Example 2:
Input: $str = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."
Output: "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"

=head3 Example 3:
Input: $str = "to make a word bold: '...it is <B>very</B> very important...'."
Output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."

=head3 Example 4:
Input: $str = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."
Output: ""

=head3 Example 5:
Input: $str = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
Output: "There's more than [one] [one] way to do it."

=end pod

# See https://docs.raku.org/language/regexes#Capture_numbers for using captures inside a regex.
# See https://stackoverflow.com/questions/56920119/backreferences-in-regexes-match-but-do-not-capture and
# https://stackoverflow.com/questions/56393888/why-how-is-an-additional-variable-needed-in-matching-repeated-arbitary-character
# for more detail.

sub doubled-words(Str:D $str --> Str) {
    my $new = $str;
    $new ~~ s:g/:i << (\w+)                             # find a word
                      {} :my $c = $0;                   # publish and store in a variable so can be reused
                      ([\s | '<' <-[>]>* '>']+)         # traverse whitespace or an html tag
                      ($c) >>                           # find the original word
                   /\[$0\]$1\[$2\]/;                    # put brackets around the duplicates
    $new.split("\n").grep(/ '[' | ']' /).join("\n");    # drop any line without brackets
}

#| find doubled words in $str
multi MAIN(Str:D $str) {
    say doubled-words($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%( input => "the THE", output => "[the] [THE]" ));
    @tests.push(%( input => "the the raku raku", output => "[the] [the] [raku] [raku]" ));
    @tests.push(%( input => "the the the", output => "[the] [the] the" ));
    @tests.push(%( input => "the the\nraku raku", output => "[the] [the]\n[raku] [raku]" ));
    @tests.push(%( input => "<strong>the</strong> THE", output => "<strong>[the]</strong> [THE]" ));
    @tests.push(%( input => "<i>the</i> <i>THE</i>", output => "<i>[the]</i> <i>[THE]</i>" ));
    plan @tests + 3;
    for @tests {
        is doubled-words(.<input>), .<output>;
    }
    my $proc = run($*EXECUTABLE, $?FILE, "the the", :out, :err);
    is $proc.out.slurp(:close).trim, '[the] [the]', "cli produces produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string) / {
                @tests.push(%( input => $0.EVAL, output => $1.EVAL ));
            }
        }
    }
    @tests;
}
