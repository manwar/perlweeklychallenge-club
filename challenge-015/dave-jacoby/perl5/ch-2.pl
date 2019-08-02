#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state fc };
no warnings qw{ experimental::postderef experimental::signatures };

my $keyword   = 'ATTACKATDAWN';
my $cleartext = <<'END';
Write a script to implement Vigenere cipher. 
The script should be able encode and decode.
END

# the point ISN'T to show off Getopt or File I/O techniques
# so I'm going way simple here.
$keyword   = $ARGV[0] ? $ARGV[0] : $keyword;
$cleartext = $ARGV[1] ? $ARGV[1] : $cleartext;

$keyword =~ tr/a-z/A-Z/;
$keyword =~ s/\W//g;
$cleartext =~ tr/a-z/A-Z/;    # or uc $cleartext. TMTOWTDI
$cleartext =~ s/\W//g;        # text that isn't alpha isn't encrypted
                              # and can give the game away.

my $cyphertext = encode_vigenere( $keyword, $cleartext );
my $decrypt = decode_vigenere( $keyword, $cyphertext );
say <<"END";
    CLEAR:
        $cleartext
    CYPHER:
        $cyphertext
    DECRYPT:
        $decrypt
END
exit;

sub encode_vigenere ( $keyword, $cleartext ) {
    my @keyword = split m{}, $keyword;
    my @base    = make_core_cypher();
    my @alpha   = 'A' .. 'Z';
    my %alpha   = map { $alpha[$_] => $_ } 0 .. 25;
    my @cypher;
    for my $clear ( split m{}, $cleartext ) {
        state $c = 0;
        # here's where I made a mistake, and wrote my decode to 
        # work with my mistake. I was using $c % length $keyword
        # as the column determiner, rather than the index of the
        # letter at position $c % length $keyword. 
        # the keyword 'aaaa' should give a cyphertext that's the
        # same as the cleartext. 

        # If your algorithm cannot return an encrypted letter 
        # that's the same as the clear letter, you have an 
        # attack vector, but if your keyword is all "a" with this, 
        # you have not encrypted anything.

        # and, really, long-term viability is not helped by 
        # short variable names
        my $k = $keyword[ $c % length $keyword ];
        my $d = $alpha{$k};
        my $e = $alpha{$clear};
        my $f = $base[$d][$e];
        push @cypher, $f;
        $c++;
    }
    return join '', @cypher;
}

sub decode_vigenere ( $keyword, $cyphertext ) {
    my @keyword = split m{}, $keyword;
    my @base    = make_core_cypher();
    my @alpha   = 'A' .. 'Z';
    my %alpha   = map { $alpha[$_] => $_ } 0 .. 25;
    my @clear;
    for my $cypher ( split m{}, $cyphertext ) {
        state $c = 0;
        my $k = $keyword[ $c % length $keyword ];
        my $d = $alpha{$k};
        my $e;
        for my $i ( 0 .. 25 ) {
            $e = $i if $base[$d][$i] eq $cypher;
        }
        my $f = $alpha[$e];
        push @clear, $f;
        $c++;
    }
    return join '', @clear;
}

sub make_core_cypher () {
    my @alpha = 'A' .. 'Z';
    my @output;
    for my $i ( 0 .. 25 ) {
        for my $j ( 0 .. 25 ) {
            my $k = ( $i + $j ) % 26;
            my $l = $alpha[$k];
            $output[$i][$j] = $l;
        }
    }
    return @output;
}
