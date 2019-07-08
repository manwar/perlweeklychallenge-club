#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Vigenere;

    sub new { bless \$_[1], $_[0] }
    sub encode { $_[0]->_code($_[1],  1) }
    sub decode { $_[0]->_code($_[1], -1) }

    sub _code {
        my ($self, $string, $direction) = @_;
        my $x_coded = "";
        for my $i (0 .. length($string) - 1) {
            my $ch = substr $string, $i, 1;
            my $pch = substr $$self, $i % length $$self, 1;
            my $ord = ord($ch) + $direction * (ord($pch) - ord('A'));
            $ord -= 26 if $ord > ord 'Z';
            $ord += 26 if $ord < ord 'A';
            $x_coded .= chr $ord ;
        }
        return $x_coded
    }
}

use Test::More tests => 2;
my $v = 'My::Vigenere'->new('LEMON');
is $v->encode('ATTACKATDAWN'), 'LXFOPVEFRNHR', 'encode';
is $v->decode('LXFOPVEFRNHR'), 'ATTACKATDAWN', 'decode';
