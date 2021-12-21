#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

say "@{[ ulam_expanded(1,2,1000) ]}";
say "@{[ ulam_map(1,2,1000) ]}";
say "@{[ ulam(1,2,1000) ]}";
say "@{[ ulam_expanded(1,2,100) ]}";
say "@{[ ulam_map(1,2,100) ]}";
say "@{[ ulam(1,2,100) ]}";
say "@{[ ulam(2,3,100) ]}";
say "@{[ ulam(2,5,100) ]}";

cmpthese( 200, {
  'u' => sub { ulam(1,2,1000) },
#  'm' => sub { ulam_map(1,2,1000) },
  'e' => sub { ulam_expanded(1,2,1000) },
} );

sub ulam {
  my%h=map{$_,$_}my@s=($_[0],my$n=$_[1]);
  for(my$c=0;@s<$_[2];++$n,$c=0){
    ($_>=$n/2)?(last):($h{$n-$_})&&$c++&&(last) for@s;
    push@s,$h{$n}=$n if$c==1;
  }
  @s;
}

sub ulam_expanded {
  my ($m, $n, $l) = @_;
  my @seq = ($m,$n);
  my %seq_hash = ( $m => 1, $n => 1 );
  while( @seq < $l ) {
    $n++;
    my $count = 0;
    foreach ( @seq ) {
      last if $_ >= $n/2;
      if( exists $seq_hash{ $n - $_ } ) {
        $count++;
        last if $count>1;
      }
    }
    if( $count == 1 ) {
      push @seq, $n;
      $seq_hash{ $n } = 1;
    }
  }
  return @seq;
}

sub ulam_map {
  my%seq_hash=map{$_,$_}my@seq=($_[0],my$n=$_[1]);
  for(;scalar @seq<$_[2];++$n){
    push@seq,$seq_hash{$n}=$n if 1==grep{2*$_<$n&&$seq_hash{$n-$_}}@seq;
  }
  @seq;
}

