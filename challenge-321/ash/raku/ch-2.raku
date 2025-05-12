# Task 2 of the Weekly Challenge 321
# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/#TASK2

my $str1 = 'ab#c';
my $str2 = 'ad#c'; # True

# my $str1 = 'ab##';
# my $str2 = 'a#b#'; # True

# my $str1 = 'a#b';
# my $str2 = 'c'; # False

say process($str1) eq process($str2);

sub process($s is copy) {
    $s ~~ s/.\#// while $s ~~ /.\#/;

    return $s;
}
