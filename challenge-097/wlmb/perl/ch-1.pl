#!/usr/bin/env perl
# Perl weekly challenge 097
# Task 1: Caesar Cipher
#
# See https://wlmb.github.io/2021/01/25/PWC097/#task-1-caesar-cipher
use warnings;
use strict;
use v5.12;
use Scalar::Util qw(looks_like_number);

sub usage {
    say <<END;
    Usage:
	./ch-1.pl S N
    to encode string S using Casear's cipher with displacement N
END
    exit 1;
}

usage() unless @ARGV==2;
my $string = uc shift @ARGV; # Allow lower case but convert to uppercase
my $displacement=shift @ARGV;
usage() unless looks_like_number($displacement);

my @plain="A".."Z";
my %translation_of=map {($plain[$_]=>$plain[($_-$displacement)%@plain])} 0..@plain-1;

my $translated=join '', map {$translation_of{$_}//$_} split '', $string;
say "Input:  \"$string\" $displacement\nOutput: \"$translated\"\n";
say "Plain:\t", @plain, "\n",
    "Cipher:\t", join '', @translation_of{sort keys %translation_of}, "\n",
    "Displacement:\t$displacement\n",
    "Plaintext:\t$string\n",
    "Ciphertext:\t$translated",
