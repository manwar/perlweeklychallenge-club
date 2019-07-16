#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

for my $url ( 'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1',
    'https://en.wikipedia.org/wiki/URL',
    'https://perlcon.eu/my',
    'https://www.perlmonks.org/?node=Seekers of Perl Wisdom') {

    $url =~ m{
        ^                       # start of string
        (\w+ (?: : \w+)?)       # scheme, captured in $1
        ://                     # literal ://
        (?:(\w+:\w+)@)?         # optional user info captured in $2
        (\w+ (?: \.\w+)*)       # host, captured in $3
        (?: : (\d+) )?          # optional port captured in $4
        (/(?:\w+ (?:/\w+)*)?)   # path, captured in  $5
        (?: \? (\w+=[\s\w]+))?  # optional query in $6
        (?: \# (\w+))?          # optional fragment in $7
        $                       # end of string
        }x;

    say "Matched $url:";
    say "   scheme: $1";
    say "   userinfo: $2" if defined $2;
    say "   host: $3";
    say "   port: $4" if defined $4;
    say "   path: $5";
    say "   query: $6" if defined $6;
    say "   fragment: $7" if defined $7;
}
