#!/usr/bin/env perl

use strict;
use warnings;
use List::MoreUtils qw/ first_index /;;
use Benchmark::Forking qw/ cmpthese /;

my @alphabet = ("A".."Z");

cmpthese(-10, {
    'initial_encode' => sub{
        my ( $plaintext, $keyword ) = ("MMEZQTBJDGNQKYPURWZMWOIUOC", "LEMON");
        my $cyphertext;
        for my $i (0..((length $plaintext) - 1)){
            (my $mi) = grep { $alphabet[$_] eq substr($plaintext, $i, 1) } (0..@alphabet-1);
            (my $ki) = grep { $alphabet[$_] eq substr($keyword, ($i % length $keyword), 1)} (0..@alphabet-1);
            $cyphertext .= $alphabet[($mi + $ki) % 26];
        }
        return $cyphertext;
    },

    'substr_out_grep' => sub{
        my ( $plaintext, $keyword ) = ("MMEZQTBJDGNQKYPURWZMWOIUOC", "LEMON");
        my $cyphertext;
        for my $i (0..((length $plaintext) - 1)){
            my $plaintext_chr = substr($plaintext, $i, 1);
            my $keyword_chr   = substr($keyword, ($i % length $keyword), 1);
            (my $mi) = grep { $alphabet[$_] eq $plaintext_chr } (0..@alphabet-1);
            (my $ki) = grep { $alphabet[$_] eq $keyword_chr } (0..@alphabet-1);
            $cyphertext .= $alphabet[($mi + $ki) % 26];
        }
        return $cyphertext;
    },

    'use_first_index' => sub{
        my ( $plaintext, $keyword ) = ("MMEZQTBJDGNQKYPURWZMWOIUOC", "LEMON");
        my $cyphertext;
        for my $i (0..((length $plaintext) - 1)){
            my $plaintext_chr = substr($plaintext, $i, 1);
            my $keyword_chr   = substr($keyword, ($i % length $keyword), 1);
            (my $mi) = first_index { $alphabet[$_] eq $plaintext_chr } (0..@alphabet-1);
            (my $ki) = first_index { $alphabet[$_] eq $keyword_chr } (0..@alphabet-1);
            $cyphertext .= $alphabet[($mi + $ki) % 26];
        }
        return $cyphertext;
    },

    'use_ord_chr' => sub{
        my ( $plaintext, $keyword ) = ("MMEZQTBJDGNQKYPURWZMWOIUOC", "LEMON");
        my $cyphertext;
        for my $i (0..((length $plaintext) - 1)){
            my $mi = ord( substr( $plaintext, $i, 1 ) ) - 65;
            my $ki = ord( substr( $keyword, ($i % length $keyword), 1)) - 65;
            $cyphertext .= chr((($mi + $ki) % 26) + 65);
        }
        return $cyphertext;
    },
});
