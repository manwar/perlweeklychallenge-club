# Task 1 of The Weekly Challenge 348
# https://theweeklychallenge.org/blog/perl-weekly-challenge-348/#TASK1

say can-split 'textbook'; # False
say can-split 'book'; # True
say can-split 'AbCdEfGh'; # True
say can-split 'rhythmmyth'; # False
say can-split 'UmpireeAudio'; # False

say can-split 'odd'; # False

sub can-split($str) {
    return False if $str.chars % 2;

    my $len = ($str.chars / 2).Int; # why: https://github.com/rakudo/rakudo/issues/6030
    my ($a, $b) = $str.comb($len);

    $a ~~ s:g:i/<-[aeiou]>+//;
    $b ~~ s:g:i/<-[aeiou]>+//;

    return $a.chars == $b.chars != 0;
}
