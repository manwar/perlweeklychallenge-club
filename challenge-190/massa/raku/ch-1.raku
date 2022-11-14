
#!/usr/bin/env raku

=begin pod

Week 190:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-190

Task #1: Capital Detection

    Write a script to find out if the usage of Capital is appropriate if it satisfies at least one of the following rules:

    1) Only first letter is capital and all others are small.
    2) Every letter is small.
    3) Every letter is capital.

=end pod

use Test;

my regex capital-detection { ^ [ <upper> <lower>* | <upper>+ | <lower>+ ] $ }

ok  'Perl' ~~    /<capital-detection>/;
ok  'TPF' ~~     /<capital-detection>/;
nok 'PyThon' ~~  /<capital-detection>/;
ok  'raku' ~~    /<capital-detection>/;

done-testing;


