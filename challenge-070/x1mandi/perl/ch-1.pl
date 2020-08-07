#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;
use utf8;
use 5.26.0;
#promt for a string from user (keyboard input)

my $S = $ARGV[0] || "Perlmongers";
my $C = $ARGV[1] || 3;
my $O = $ARGV[2] || 4;

print character_swapping($S, $C, $O)."\n";

sub character_swapping {
    my ($s, $c, $o) = @_;
    my $N = length($s);
    
    die "ERROR: Missing string.\n" unless defined $s;
    die "ERROR: Missing swap count.\n" unless defined $c;
    die "ERROR: Missing offset.\n" unless defined $o;
    die "ERROR: Invalid swap count [$c].\n" unless ( $c >= 1 ); 
    die "ERROR: Invalid offset [$o].\n" unless ( $o >= 1 );
   #Why swap count cannot be greater that offset? Checked $S=abcd, $C=2, $O=1 and the output is "bcda" 
    die "ERROR: Swap count [$c] is greater than offset [$o].\n" unless ( $c <= $o );
   # When $N = $c-1  
    die "ERROR: Invalid string length [$N] for given swap count and offset [$c + $o].\n"
      unless ( ($c + $o) <= $N);
    
    my @chars = split //, $s;
    
    #Why is swapping not applied to the first character at index 0?
    for (1..$c) {
      my $firstchar = $chars[$_ % $N];
      my $secondchar = $chars[ ($_+$o) % $N];
      
      $chars[($_+$o) % $N] = $firstchar; 
      $chars[$_ % $N] = $secondchar;      
    }
    
    $s = join('', @chars);
    return $s;
}