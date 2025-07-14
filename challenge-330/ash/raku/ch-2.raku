# Task 2 of the Weekly Challenge 330
# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/#TASK2

say title-capital('PERL IS gREAT');        # Perl is Great
say title-capital('THE weekly challenge'); # The Weekly Challenge
say title-capital('YoU ARE A stAR');       # You Are a Star

sub title-capital($str is copy) {
    $str ~~ s:g/(\w+)/{$0.chars < 3 ?? $0.lc !! $0.tclc}/;

    return $str;
}
