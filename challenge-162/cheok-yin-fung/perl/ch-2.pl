#!/usr/bin/perl
# The Weekly Challenge 162
# Task 2 Wheatstone-Playfair cipher
# Usage:
# $ ch-1.pl 1 "$key" "$text_to_be_encrypted"
# $ ch-1.pl 0 "$key" "$text_to_be_decrypted"

use v5.22.0;
use warnings;
use Data::Dumper;
use List::Util qw/pairmap uniqstr first/;

if (defined($ARGV[2])) {
    if ($ARGV[0]) {
        say encrypt($ARGV[1], $ARGV[2]);
    }
    else {
        say decrypt($ARGV[1], $ARGV[2]);
    }
}



sub encrypt {
    my $key = $_[0];
    my $word = $_[1];
    my $board = playfair_board($key);
    return codify($board, pairup(preprocess($word)));
}


sub decrypt {
    my $key = $_[0];
    my $encoded = uc $_[1];
    $encoded =~ s/\W//g;
    $encoded =~ s/J/I/g;
    die "Bad cryptotext (non-alphabet characters).\n" 
        if $encoded !~ /^[A-Z]+$/;
    die "Bad cryptotext (odd number of characters). \n"
        if (length $encoded) % 2 != 0;
    my $board = playfair_board($key);
    return decode($board, $encoded);
}


sub codify {
    my $board = $_[0];
    my @wordpairs = $_[1]->@*;
    my @en_wordpairs;
    for (@wordpairs) {
        my ($e, $f) = split "", $_;
        my ($x1,$y1) = seek_xy($board, $e);
        my ($x2,$y2) = seek_xy($board, $f);
        # case: lay on same column
        if ($x1 == $x2) {
            push @en_wordpairs, 
                $board->[$x1][($y1+1)%5].$board->[$x1][($y2+1)%5];   
            next;
        }
        # case: lay on same row
        if ($y1 == $y2) {   
            push @en_wordpairs, 
                $board->[($x1+1)%5][$y1].$board->[($x2+1)%5][$y2];
            next;
        }
        # case: form a rectangle
        push @en_wordpairs, $board->[$x1][$y2].$board->[$x2][$y1];
    }
    return join "", @en_wordpairs;
}



sub decode {
    my $board = $_[0];
    my $encoded = $_[1];
    my @wordpairs = pairmap {$a.$b} split "", $encoded;
    my @de_wordpairs;
    for (@wordpairs) {
        my ($e, $f) = split "", $_;
        my ($x1,$y1) = seek_xy($board, $e);
        my ($x2,$y2) = seek_xy($board, $f);
        # case: lay on same column
        if ($x1 == $x2) {
            push @de_wordpairs, 
                $board->[$x1][($y1+4)%5].$board->[$x1][($y2+4)%5];   
            next;
        }
        # case: lay on same row
        if ($y1 == $y2) {   
            push @de_wordpairs, 
                $board->[($x1+4)%5][$y1].$board->[($x2+4)%5][$y2];
            next;
        }
        # case: form a rectangle
        push @de_wordpairs, $board->[$x1][$y2].$board->[$x2][$y1];
    }
    return join "", @de_wordpairs;
}



sub seek_xy {
    my $board = $_[0];
    my $alphabet = $_[1];
    my $num = first {$board->[$_ / 5][$_ % 5] eq $alphabet} (0..24);
    return (int $num / 5, $num % 5);
}



sub preprocess {
    my $word = uc $_[0];
    $word =~ s/\W//g;
    $word =~ tr/J/I/;
    my $pword;  # BEGIN: insert X for repeating char
    do {     #  not in the master class of regex /_\ (sad)
        $pword = $word;
        $word =~ s/([A-Z])\1/${1}X${1}/;
    } while ($pword ne $word);  # END of insertion
    return $word;
}



sub pairup {
    my $word = $_[0];
    $word = $word."X" if (length $word) % 2 == 1;
    return [pairmap {$a.$b} split "", $word];
}



sub playfair_board {
    my $key = (uc $_[0]) . (join "", ("A".."Z"));
    $key =~ tr/J/I/;
    my @let = uniqstr grep {$_ ne " "} split "", $key;
    @let = ( 
            [@let[0..4]  ],
            [@let[5..9]  ],
            [@let[10..14]],
            [@let[15..19]],
            [@let[20..24]],
           ) ;
    return [@let];
}


use Test::More tests => 2;
ok encrypt("playfair example", "hide the gold in the tree stump")
      eq uc "bmodzbxdnabekudmuixmmouvif";
ok decrypt("perl and raku", uc "siderwrdulfipaarkcrw") 
      eq uc "thewexeklychallengex";
