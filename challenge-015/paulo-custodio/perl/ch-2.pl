#!/usr/bin/perl

# Challenge 015
#
# Task #2
# Write a script to implement Vigenère cipher. The script should be able encode
# and decode. Checkout wiki page for more information.

use strict;
use warnings;
use 5.030;

my($op, $key, @text) = @ARGV;
if ($op && $op =~ /^enc/i) {
    say encode("@text", $key);
}
elsif ($op && $op =~ /^dec/i) {
    say decode("@text", $key);
}
else {
    die "Usage: ch-2.pl encode|decode key text\n";
}


sub text_codes {
    my($text) = @_;
    $text = uc($text);
    $text =~ s/\W//g;
    my @codes = map {ord($_)-ord('A')} split //, $text;
    return @codes;
}

sub codes_text {
    my(@codes) = @_;
    return join '', map {chr($_+ord('A'))} @codes;
}

sub encode {
    my($plain, $key) = @_;
    return vigenere($plain, $key, 1);
}

sub decode {
    my($plain, $key) = @_;
    return vigenere($plain, $key, 0);
}

sub vigenere {
    my($plain, $key, $encode) = @_;
    my @key = text_codes($key);
    my @plain = text_codes($plain);
    my @cipher;
    for my $pc (@plain) {
        if ($encode) {
            push @cipher, ($pc + $key[0]) % 26;
        }
        else {
            push @cipher, ($pc - $key[0] + 26) % 26;
        }
        push @key, shift @key;          # rotate key
    }
    return codes_text(@cipher);
}
