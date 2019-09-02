#! /usr/bin/perl

use strict;
use warnings;

my $i=Local::InvIndex->new;
foreach my $file (@ARGV) {
  $i->add_doc_file($file);
}
my $w=$i->search('chimney');
foreach my $result (@{$w}) {
  print join(' ',@{$result}),"\n";
}

package Local::InvIndex;
use Lingua::Stem;

sub new {
  my $class=shift;
  my $self={};
  bless $self,$class;
  $self->{stemmer}=Lingua::Stem->new();
  $self->{stemmer}->stem_caching({-level => 2});
  $self->{index}={};
  return $self;
}

sub add_doc_string {
  my $self=shift;
  my $docname=shift;
  my @words;
  my @indices;
  my $line=0;
  foreach my $str (@_) {
    my @l=split /\n/,$str;
    foreach my $l (@l) {
      my @w=$self->splitline($l);
      push @indices,map {[$docname,$line,$_]} (0..$#w);
      push @words,@w;
      $line++;
    }
  }
  $self->{stemmer}->stem_in_place(@words);
  foreach my $i (0..$#words) {
    push @{$self->{index}{$words[$i]}},$indices[$i];
  }
}

sub add_doc_file {
  my $self=shift;
  my $filename=shift;
  my $buf;
  open I,'<',$filename or die "Can't open filename\n";
  while (<I>) {
    $buf.=$_;
  }
  close I;
  $self->add_doc_string($filename,$buf);
}

sub search {
  my $self=shift;
  my @search=shift;
  $self->{stemmer}->stem_in_place(@search);
  return $self->{index}{$search[0]} || [];
}

sub splitline {
  my $self=shift;
  my $line=shift;
  $line =~ s/[^A-za-z ]+/ /g;
  return grep /./,split ' ',lc($line);
}
