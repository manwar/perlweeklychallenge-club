#!/usr/bin/env raku
use Test;

is doubled-words("you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."), 
"web server for doubled words (such as '[this] [this]'), a common problem";

is doubled-words("Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."),
"Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,";

is doubled-words("to make a word bold: '...it is <B>very</B> very important...'."),
"to make a word bold: '...it is <B>[very]</B> [very] important...'.";

is doubled-words("Perl officially stands for Practical Extraction and Report Language, except when it doesn't."),
Empty.Str;

is doubled-words("There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."),
"There's more than [one] [one] way to do it.";

sub doubled-words($str is copy)
{
    $str ~~ s:g/(<<\w+>>) 
                (<ws>? ['<' '/'? \w+ '>']? <ws>?) 
                (<<\w+>>) 
                (<ws>? ['<' '/'? \w+ '>']? <ws>?) 
                <?{ $0.lc eq $2.lc }> /{ "[$0]" ~ $1 ~ "[$2]" ~ $3 }/;

    $str.lines.grep(/'['/).join("\n")
}
