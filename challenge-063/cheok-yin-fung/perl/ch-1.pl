#!/usr/bin/perl
use Test::Simple tests => 3;
use strict;

sub last_word {
    my $qr = $_[1];
    my @rwords = reverse split / /, $_[0];
    foreach (@rwords) {
        if ($_ =~ $qr) {   #why   if ($qr)    does not work
            return $_;
        }
    }
    return undef;
}

ok ( last_word('hello world', qr/[ea]l/) eq "hello", "Good Hello"  ) ;
ok ( last_word("Don't match too much, Chet!",  qr/ch.t/i) eq 'Chet!', "Good Chet");
ok ( last_word( join(' ', 1..1e6), qr/^(3.*?){3}/) eq '399933', "Nice number");
