#!/bin/env raku

# The Weekly Challenge 363
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, String Lie Detector
pwc-test './ch-1.raku', 'aa - two vowels and zero consonants',     'True',  'String Lie Detector: "aa - two vowels and zero consonants"     => true';
pwc-test './ch-1.raku', 'iv - one vowel and one consonant',        'True',  'String Lie Detector: "iv - one vowel and one consonant"        => true';
pwc-test './ch-1.raku', 'hello - three vowels and two consonants', 'False', 'String Lie Detector: "hello - three vowels and two consonants" => false';
pwc-test './ch-1.raku', 'aeiou - five vowels and zero consonants', 'True',  'String Lie Detector: "aeiou - five vowels and zero consonants" => true';
pwc-test './ch-1.raku', 'aei - three vowels and zero consonants',  'True',  'String Lie Detector: "aei - three vowels and zero consonants"  => true';

# Task 2, Subnet Sheriff
pwc-test './ch-2.raku', <192.168.1.45 192.168.1.0/24>, 'True',  'Subnet Sheriff: 192.168.1.45 192.168.1.0/24 => true';
pwc-test './ch-2.raku', <10.0.0.256 10.0.0.0/24>,      'False', 'Subnet Sheriff: 10.0.0.256 10.0.0.0/24      => false';
pwc-test './ch-2.raku', <172.16.8.9 172.16.8.9/32>,    'True',  'Subnet Sheriff: 172.16.8.9 172.16.8.9/32    => true';
pwc-test './ch-2.raku', <172.16.4.5 172.16.0.0/14>,    'True',  'Subnet Sheriff: 172.16.4.5 172.16.0.0/14    => true';
pwc-test './ch-2.raku', <192.0.2.0 192.0.2.0/25>,      'True',  'Subnet Sheriff: 192.0.2.0 192.0.2.0/25      => true';
