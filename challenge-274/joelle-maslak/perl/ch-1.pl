#!/usr/bin/perl

use JTM::Boilerplate 'script';

MAIN: {
    my $sentence = join ' ', @ARGV;
    $sentence =~ s/(?<!\S)([aeiou])([^\s]*)/${1}${2}ma/igs;
    $sentence =~ s/(?<!\S)([^aeiou])([^\s]*)/${2}${1}ma/igs;

    my (@words) = split /\s+/, $sentence;
    my $append = "a";
    for (@words) {
        $_ .= $append;
        $append .= "a";
    }
    $sentence = join " ", @words;
    say $sentence;
}
