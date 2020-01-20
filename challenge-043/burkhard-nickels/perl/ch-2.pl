#!/usr/bin/perl

use strict;
use warnings;
use lib ".";
use bigint qw/hex/;
use Hex qw(debug);

my @C = ((0..9),("a".."z"));
print "ch-2.pl, PWC #43 Task #2: Self-descriptive Numbers\n";

for( my $b=4; $b<=24; $b++ ) {

  my $m = ($b - 4) * $b**($b-1) + 
    2 * $b**($b-2) + 
    $b**($b-3) + 
    $b**3;
  my @r;
  convert($b,$m,\@r);

  my $base   = join("",@r);
  my $is_sdn;
  if($b > 3  and $b < 15) { $is_sdn = verify_dec($base); }
  if($b > 12 and $b < 18) { $is_sdn = verify_hex($base); }
  if($b > 15) { $is_sdn = verify_str($base); }

  if($is_sdn) { 
    $is_sdn = "self-descriptive"; 
  } 
  else { 
    $is_sdn = "NOT self-descriptive"; 
  }
  printf("Base: %2d, Nmbr: %30s, %25s = %s\n", 
    $b, $m, $base, $is_sdn);
}

# -------------------- Functions -------------------------

sub convert {
  my ($b,$n,$erg) = @_;
  my $d = int($n / $b);
  my $r = $n % $b;
  if($r > 15) { 
    # print "Value > 15: $r $C[$r]\n";
    $r = $C[$r]; 
  }
  elsif($r > 9) { $r = sprintf("%x", $r); }
  unshift(@$erg,$r);
  convert($b,$d,$erg) if $d;
}

sub verify_dec {
  my ($sdn) = @_;  # i.e. (1210) base 4
  my $i = 0;       # Position of number
  my $is_sdn = 1;  # is self-descriptive number
  foreach my $v (split(//,$sdn)) { # every digit 1 - 2 - 1 - 0
    my $nr;
    if($i>9) { $nr = 0; }
    else {
      $nr = () = $sdn =~ m/$i/g; # count occurence of position-value
    }
    if($v !~ /\d+/) { $v = hex($v); }
    if( $v != hex($nr) ) { # value is not self-descriptive ?
      $is_sdn = 0;
      return $is_sdn;      # - than finish here
    }
    $i++;                  # increase position
  }
  return $is_sdn;          # all values are self-descriptive
}
sub verify_hex {
  my ($sdn) = @_;
  my $H_sdn = Hex->new($sdn,1);
  my $H_i   = Hex->new(0x0);
  my $is_sdn = 1;
  my $H_v = Hex->new();
  foreach my $v (split(//,$H_sdn)) {
    $H_v->set($v,1);
    my $H_nr = Hex->new();
    if(hex($H_i)>0xf) { $H_nr = 0; }
    else {
      my $nr = () = $H_sdn =~ m/$H_i/g;
      $H_nr->set($nr);
    }
    if( $H_nr != $H_v ) {
      $is_sdn = 0;
      return $is_sdn;
    }
    $H_i++;
  }
  return $is_sdn;
}

sub verify_str {
  my ($sdn) = @_;
  my $i = 0;
  my $is_sdn = 1;
  foreach my $v (split(//,$sdn)) {
    my $nr;
    my $search = $C[$i];
    $nr = () = $sdn =~ m/$search/g;
    $nr = $C[$nr];
    if( $v ne $nr ) {
      $is_sdn = 0;
      return $is_sdn;
    }
    $i++; 
  }
  return $is_sdn;
}

