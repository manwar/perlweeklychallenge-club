#! /usr/bin/perl

use strict;
use warnings;

my $lzw=Local::LZW->new('A'..'Z');

my $bitstr=$lzw->encode('TOBEORNOTTOBEORTOBEORNOT');
print $lzw->decode($bitstr),"\n";

package Local::LZW;
use List::Util qw(max);

sub new {
  my $class=shift;
  my $self={};
  bless $self,$class;
  my $alphabet=join('',@_) or die "Specify alphabet\n";
  my @dec=split '',$alphabet;
  unshift @dec,'#STOP#'; # yes, I know this is bad
  $self->{encode}={map {$dec[$_] => $_} (0..$#dec)};
  return $self;
}

sub encode {
  my $self=shift;
  my @inchars=split '',shift;
  push @inchars,'#STOP#';
  my @out;
  my %dict=%{$self->{encode}};
  my $l=int(log(scalar keys %dict)/log(2))+1 ;
  while (@inchars) {
    if ($inchars[0] eq '#STOP#') {
      last;
    }
    my $n=0;
    while ($#inchars > $n && exists $dict{join('',@inchars[0..$n])}) {
      $n++;
    }
    if ($n>0) {
      push @out,[$dict{join('',@inchars[0..$n-1])},$l];
    }
    my $di=scalar keys %dict;
    $l=max(int(log($di)/log(2))+1,$l);
    $dict{join('',@inchars[0..$n])}=$di;
    splice @inchars,0,$n;
  }
  push @out,[$self->{encode}{'#STOP#'},$l];
  my $bins=join('',map {sprintf('%0'.$_->[1].'b',$_->[0])} @out);
  my $ll=length($bins)%8;
  if ($ll>0) {
    $bins .= '0' x (8-$ll);
  }
  return pack('B*',$bins);
}

sub decode {
  my $self=shift;
  my $bitstr=shift;
  my %dict=%{$self->{encode}};
  my %decode=map {$dict{$_} => $_} keys %dict;
  my $l=int(log(scalar keys %dict)/log(2))+1 ;
  my @bins=split '',join('',map {sprintf('%08B',ord($_))} split '',$bitstr);
  my @out;
  my $conj='';
  while (@bins) {
    my @d=splice @bins,0,$l;
    while (scalar @d < 8) {
      unshift @d,'0';
    }
    my $b=pack('B*',join('',@d));
    my $code=ord($b);
    unless (exists $decode{$code}) {
      die "unable to decode $code\n";
    }
    if ($decode{$code} eq '#STOP#') {
      last;
    }
    push @out,$decode{$code};
    if ($conj) {
      my $nd=$conj.substr($out[-1],0,1);
      my $di=scalar keys %decode;
      $l=max(int(log($di+1)/log(2))+1,$l);
      $decode{$di}=$nd;
    }
    $conj=$out[-1];
  }
  return join('',@out);
}
