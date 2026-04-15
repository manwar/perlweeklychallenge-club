#!/usr/bin/env perl

# Perl Weekly Challenge 369 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/

use Modern::Perl;

@ARGV or die "usage: $0 title...\n";
say create_tag("@ARGV");

sub create_tag {
    my($title) = @_;
    my @words = split ' ', $title;
    for my $i (0 .. $#words) {
        $words[$i] =~ s/[^a-zA-Z]//g;
        if ($i==0) {
            $words[$i] = lc($words[$i]);
        }
        else {
            $words[$i] = ucfirst(lc($words[$i]));
        }
    }
    my $tag = '#'.join '', @words;
    if (length($tag) > 100) {
        $tag = substr($tag, 0, 100);
    }
    return $tag;
}
