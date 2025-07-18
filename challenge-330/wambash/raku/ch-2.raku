#!/usr/bin/env raku

sub title-capital (+$str) {
    $str.wordcase(
        filter => { .chars > 2 ?? .tclc !! .lc }
    )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is title-capital('PERL IS gREAT'), 'Perl is Great';
    is title-capital('THE weekly challenge'), 'The Weekly Challenge';
    is title-capital('You ARE A stAR'), 'You Are a Star';
    done-testing;
}

multi MAIN ($str) {
    say title-capital $str;
}
