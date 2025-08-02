use strict;
use warnings;
use feature 'say';

sub reverse_vowels  {
    my $str = lc shift;
    my @vowels = $str =~ /[aeiou]/g;
    $str =~ s/[aeiou]/pop @vowels/ge;
    return ucfirst $str;
}

for my $test (qw <Raku Perl Julia Uiua>) {
    say "$test \t => ", reverse_vowels $test;
}
