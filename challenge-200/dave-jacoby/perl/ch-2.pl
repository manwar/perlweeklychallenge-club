#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };
use Algorithm::Permute;

my @examples = ( 1, 27, 190 .. 200 );
@examples = @ARGV if scalar @ARGV;
my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
my @base  = map { chomp $_; $_ } <DATA>;

for my $e (@examples) {
    seven_segment($e);
}

sub seven_segment( $num ) {
    my @digits = split //, $num;
    my @segs   = 'a' .. 'g';
    my @out;
    for my $digit (@digits) {
        my %segs = map { $_ => 1 } split //, $truth[$digit];
        for my $s ( 0 .. 6 ) {
            my $line = $base[$s];
            for my $seg (@segs) {
                if   ( $segs{$seg} ) { $line =~ s/$seg/*/g }
                else                 { $line =~ s/$seg/ /g }
            }
            push $out[$s]->@*, $line;
        }
    }
    say join "\n", '',map { join '', $_->@* } @out;
}

__DATA__
 aaaaa   
f     b  
f     b  
 ggggg   
e     c  
e     c  
 ddddd   
