#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub last_word {
    my ($string, $regexp) = @_;
    if (ref($regexp) ne 'Regexp') {
        die "Not a regexp!";
    }
    my $result = undef;

    for my $word (reverse split /\s+/, $string) {
        if ($word =~ $regexp) {
            $result = $word;
            last;
        }
    }

    return $result;
}


say last_word('  hello world',                qr/[ea]l/) // 'undef';      # 'hello'
say last_word("Don't match too much, Chet!",  qr/ch.t/i) // 'undef';      # 'Chet!'
say last_word("spaces in regexp won't match", qr/in re/) // 'undef';      #  undef
say last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/) // 'undef'; # '399933'