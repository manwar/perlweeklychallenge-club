#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub last_word { say ((grep  /$_[1]/ , $_[0] =~ /\S+/g)[-1]) }

last_word('  hello world',                qr/[ea]l/);      # 'hello'
last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
last_word("spaces in regexp won't match", qr/in re/);      #  undef
last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'