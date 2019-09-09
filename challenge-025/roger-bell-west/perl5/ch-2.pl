#! /usr/bin/perl

use strict;
use warnings;

# Create script to implement Chaocipher.

my @alpha;
foreach my $ix (0,1) {
  my $t=shift @ARGV;
  unless ($t =~ /^[A-Z]{26}$/) {
    die "Bad wheel $t\n";
  }
  $alpha[$ix]=[split '',$t];
}

my $dir=(shift @ARGV)?1:0;

my $message=uc(join('',@ARGV));

#print cipher([[split '','HXUCZVAMDSLKPEFJRIGTWOBNYQ'],
#        [split '','PTLNBQDEOYSFAVZKGJRIHWXUMC']],
#       'WELLDONEISBETTERTHANWELLSAID',
#       0),"\n";;

#print cipher([[split '','HXUCZVAMDSLKPEFJRIGTWOBNYQ'],
#        [split '','PTLNBQDEOYSFAVZKGJRIHWXUMC']],
#       'OAHQHCNYNXTSZJRRHJBYHQKSOUJY',
#       1),"\n";;

print cipher(\@alpha,
       $message,
       $dir),"\n";

sub cipher {
  my $alpha=shift;
  my $in=shift;
  my $direction=shift; # 0 encipher, 1 decipher
  my $out;
  foreach my $inc (split '',$in) {
    # ddump($alpha);
    my $m={map {$alpha->[1-$direction][$_] => $_} (0..$#{$alpha->[1-$direction]})};
    my $outc=$alpha->[$direction][$m->{$inc}];
    $out.=$outc;
    my @ctpt=($outc,$inc);
    if ($direction==1) {
      @ctpt=($inc,$outc);
    }
    # 1. Shift the entire left alphabet cyclically so the ciphertext letter just enciphered is positioned at the zenith (i.e., position 1).
    $m={map {$alpha->[0][$_] => $_} 0..$#{$alpha->[0]}};
    push @{$alpha->[0]},@{$alpha->[0]};
    @{$alpha->[0]}=splice @{$alpha->[0]},$m->{$ctpt[0]},26;
    # 2. Extract the letter found at position zenith+1 (i.e., the letter to the right of the zenith), taking it out of the alphabet, temporarily leaving an unfilled ‘hole’.
    # 3. Shift all letters in positions zenith+2 up to, and including, the nadir (zenith+13), moving them one position to the left.
    my $temp=splice @{$alpha->[0]},1,1;
    # 4. Insert the just-extracted letter into the nadir position (i.e., zenith+13).
    splice @{$alpha->[0]},13,0,$temp;
    # 1. Shift the entire right alphabet cyclically so the plaintext letter just enciphered is positioned at the zenith.
    $m={map {$alpha->[1][$_] => $_} 0..$#{$alpha->[1]}};
    push @{$alpha->[1]},@{$alpha->[1]};
    @{$alpha->[1]}=splice @{$alpha->[1]},$m->{$ctpt[1]},26;
# 2. Now shift the entire alphabet one more position to the left (i.e., the leftmost letter moves cyclically to the far right), moving a new letter into the zenith position.
    push @{$alpha->[1]},$alpha->[1][0];
    shift @{$alpha->[1]};
    # 3. Extract the letter at position zenith+2, taking it out of the alphabet, temporarily leaving an unfilled ‘hole’.
    $temp=splice @{$alpha->[1]},2,1;
    # 4. Shift all letters beginning with zenith+3 up to, and including, the nadir (zenith+13), moving them one position to the left.
    # 5. Insert the just-extracted letter into the nadir position (zenith+13).
    splice @{$alpha->[1]},13,0,$temp;
  }
  return $out;
}

sub ddump {
  my $alpha=shift;
  foreach my $e (@{$alpha}) {
    print join('',@{$e})," ";
  }
  print "\n";
}
