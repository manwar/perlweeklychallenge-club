#!/usr/bin/env raku

subset ValidWord of Str where /^ <[a..z A..Z]>+ $/;
subset ValidSentence of Str where { all($_.split(" ")) ~~ ValidWord };

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is title-caps("PERL IS gREAT"), "Perl is Great";
    is title-caps("THE weekly challenge"), "The Weekly Challenge";
    is title-caps("YoU ARE A stAR"), "You Are a Star";
    done-testing;
}

sub title-caps(ValidSentence $str is copy) {
    $str
    .split(" ")
    .map(*.lc)
    .map( -> $a { $a.codes > 2 ?? $a.tc !! $a } )
    .join(" ");
}

#|(Accepts a string made of
upper and lower case letters. Outputs the 
sentence nicely capitalised)
multi sub MAIN(
    ValidSentence $str #= Sentence made or letters in both cases
) {
    title-caps($str).say;
}

#|(Accepts a list of strings made of
upper and lower case letters. Outputs the 
sentence nicely capitalised
)
multi sub MAIN(
    *@words where all(@words) ~~ ValidWord #= List of words
) {
    title-caps(@words.join(" ")).say;
}
