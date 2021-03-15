#!/usr/bin/perl

use warnings;


sub nflip2(\@\@) {
  local (*p0arr,*saarr) = @_;
     my $nftot=0;
     for my $l (0.. $#p0arr) {
         $nftot += ($p0arr[$l] != $saarr[$l]);
     }
  return $nftot;
}

sub nflip($\@) {
  local ($p0,*sa) = @_;
  my @p0arr = split("",$p0);
  my $nftot=0;
  for my $t (@sa){
     my @saarr = split("",$t);
     $nftot += nflip2(@p0arr,@saarr);
  }
  return $nftot;
}

sub doit($$) {
  my ($B,$S) = @_;
  print "\n$B,$S\n";
  my @sa=unpack("(a$S)*",$B);
  my @ba=map {nflip( $_,@sa)} @sa;
  my $low=$S * @ba;
  my $lidx=0;
  for my $t (0 .. $#ba) {
    if ($low> $ba[$t]){
        $low= $ba[$t];
        $lidx=$t;
    }
  }
  print "Output: $ba[$lidx]\n";
  print "Reference: $lidx: $sa[$lidx]\n";
  print "Binary Substrings:\n";
  my @p0arr = split("",$sa[$lidx]);
  for my $t (@sa) {
     my @saarr = split("",$t);
     my $nftot = nflip2(@p0arr,@saarr);
     print "\"$t\": $nftot flips";
     print " tot make it \"$sa[$lidx]\"" if ($nftot);
     print "\n";
  }  
}


$B = "101100101"; $S = 3;
doit($B,$S);
$B = "10110111"; $S = 4;
doit($B,$S);


