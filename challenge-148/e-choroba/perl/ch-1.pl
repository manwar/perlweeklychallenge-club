#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $is_eban;
if (eval { require Lingua::EN::Numbers }) {
    $is_eban = sub { Lingua::EN::Numbers::num2en($_[0]) !~ /e/ };

} elsif (eval { require Number::Spell }) {
    $is_eban = sub { Number::Spell::spell_number($_[0]) !~ /e/ };

} else {
    $is_eban = sub {
        my ($n) = @_;
        return if $n =~ /[12789].$/
               || $n =~ /[135789]$/
               || $n == 0
               || $n =~ /[^0]..$/;
        return $is_eban->(substr $n, 0, -3)
            if 3 < length $n; # thousand .. nonillion
        return 1
    };
}

say join ', ', grep $is_eban->($_), 0 .. 100;
