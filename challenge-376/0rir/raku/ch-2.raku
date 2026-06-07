#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment

May be edited for space.
376-2: Doubled Words        Submitted by: Matt Martini
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
￼
Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F. Friedl
=end comment


my @Test =
     qq{you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.},
     qq{web server for doubled words (such as '[this] [this]'), a common problem},
    qq{Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.},
        qq{Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,},
#
    qq{to make a word bold: '...it is <B>very</B> very important...'.},
        qq{to make a word bold: '...it is <B>[very]</B> [very] important...'.},

    qq{Perl officially stands for Practical Extraction and Report Language, except when it doesn't.},
        qq{},

    qq{There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.},
    qq{There's more than [one] [one] way to do it.},

    qq{There's more than one one way\nor else},
    qq{There's more than [one] [one] way},

    qq{the\n\n\nthe},
    qq{[the]\n[the]},
;
plan +@Test ÷ 2;

my regex word { \w+ };
my regex tag  { [ '<' <-[>]>* '>' ] };
my regex sep  { [ <tag> | \s ]+  };
my regex a-sq-bracket  { [ \[ | \] ]  };

sub task(Str:D $a is copy where * !~~ / <[[\]]>  / ) {
    $a ~~ s:g/:i << (\w+)
                 {} :my $zed = $0;
                 ( <sep>+)
                 ($zed) >>
                 /\[$0\]$1\[$2\]/;
$a.lines.grep(/ <a-sq-bracket>/)».say;
    $a.lines.grep(/ <a-sq-bracket>/).join("\n");
}

sub stask( Str:D $a is copy where * !~~ / <[[\]]>  / ) {
    $a ~~ s:g/:i
        << (<word>)
        {} :my $zed = $0;
        (<sep>) ($zed) >>
        /\[$0\]$1\[$2\]/;
    $a
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;


my $str = "'The\nthe...'";

say qq{\nInput: \$str = "$str"\nOutput: "}, task($str),'"';
