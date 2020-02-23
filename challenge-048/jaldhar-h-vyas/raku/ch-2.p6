#!/usr/bin/perl6

my @years = (2000 .. 2999).grep({
    / $<year> = (\d\d) $ /;
    (10, 20, 30, 40, 50, 60 , 70, 80, 90, 1, 11, 21).grep({ $_ == $/<year>}) 
});

for @years -> $year {
    $year.flip ~~ / ^ $<month> = (\d\d) $<day> = (\d\d) $ /;

    if $/<day> < 23 {
        ($/<month>, $/<day>, $year).join(q{/}).say;
    }
}
