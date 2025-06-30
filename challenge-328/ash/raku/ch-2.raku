# Task 2 of The Weekly Challenge 328
# https://theweeklychallenge.org/blog/perl-weekly-challenge-328/#TASK2

say good-string('WeEeekly'); # Weekly
say good-string('aBbAdD');   # abc
say good-string('abc');      # (empty)

sub good-string($str) {
    my $s = $str;
    $s ~~ s:g/(<:Ll>)(<:Lu>)/{ $0 eq $1.lc ?? '' !! "$0$1" }/;
    $s ~~ s:g/(<:Lu>)(<:Ll>)/{ $0.lc eq $1 ?? '' !! "$0$1"  }/;

    return $s if $s eq $str;
    return good-string($s) if $s.lc ~~ /(.) $0/;
    return $s;
}
