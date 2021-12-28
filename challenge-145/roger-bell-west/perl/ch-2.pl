#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 6;

is_deeply(eertree('redivider'),[qw(r redivider e edivide d divid i ivi v)],'example 1');
is_deeply(eertree('deific'),[qw(d e i ifi f c)],'example 2');
is_deeply(eertree('rotors'),[qw(r rotor o oto t s)],'example 3');
is_deeply(eertree('challenge'),[qw(c h a l ll e n g)],'example 4');
is_deeply(eertree('champion'),[qw(c h a m p i o n)],'example 5');
is_deeply(eertree('christmas'),[qw(c h r i s t m a)],'example 6');

sub eertree {
  my $st=shift;
  my $eertree=Local::Eertree->new();
  $eertree->add_str($st);
  my $result=[];
  $eertree->get_sub_palindromes($eertree->{rto},
                                [$eertree->{rto}],
                                [],
                                $result);
  $eertree->get_sub_palindromes($eertree->{rte},
                                [$eertree->{rte}],
                                [],
                                $result);
  my %q=map {$_ => 1} @{$result};
  my @res;
  foreach my $i (0..length($st)-1) {
    foreach my $j ($i..length($st)-1) {
      my $k=substr($st,$i,$j-$i+1);
      if (exists $q{$k}) {
        delete $q{$k};
        push @res,$k;
      }
    }
  }
  return \@res;
}

package Local::Eernode;

sub new {
  my $class=shift;
  my $self={
    edges => {},
    link => undef,
    len => 0,
    id => rand(),
      };
  bless $self,$class;
  return $self;
}

package Local::Eertree;

sub new {
  my $class=shift;
  my $self={
    nodes => [],
    rto => Local::Eernode->new(),
    rte => Local::Eernode->new(),
    S => ['0'],
      };
  $self->{rte}{link}=$self->{rto};
  $self->{rte}{id}='rte';
  $self->{rto}{link}=$self->{rto};
  $self->{rto}{len}=-1;
  $self->{rto}{id}='rto';
  $self->{maxSufT}=$self->{rte};
  bless $self,$class;
  return $self;
}

sub get_max_suffix_pal {
  my $self=shift;
  my $startnode=shift;
  my $a=shift;
  my $u=$startnode;
  my $i=scalar @{$self->{S}};
  my $k=$u->{len};
  while ($u->{id} ne 'rto' && $self->{S}[$i-$k-1] ne $a) {
    if ($u->{id} eq $u->{link}{id}) {
      last;
    }
    $u=$u->{link};
    $k=$u->{len};
  }
  return $u;
}

sub add {
  my $self=shift;
  my $a=shift;
  my $q=$self->get_max_suffix_pal($self->{maxSufT},$a);
  my $newnode=!(exists $q->{edges}{$a});
  if ($newnode) {
    my $p=Local::Eernode->new();
    push @{$self->{nodes}},$p;
    $p->{len}=$q->{len}+2;
    if ($p->{len}==1) {
      $p->{link}=$self->{rte};
    } else {
      $p->{link}=$self->get_max_suffix_pal($q->{link},$a)->{edges}{$a} or die "bad link";
    }
    $q->{edges}{$a}=$p;
    $self->{maxSufT}=$q->{edges}{$a};
    push @{$self->{S}},$a;
  }
  return $newnode;
}

sub add_str {
  my $self=shift;
  my $st=shift;
  foreach my $a (split '',$st) {
    $self->add($a);
  }
}

sub get_sub_palindromes {
  my $self=shift;
  my $nd=shift;
  my $nodestohere=shift;
  my $charstohere=shift;
  my $result=shift;
  foreach my $lnkName (keys %{$nd->{edges}}) {
    my $nd2=$nd->{edges}{$lnkName};
    $self->get_sub_palindromes($nd2,[@{$nodestohere},$nd2],[@{$charstohere},$lnkName],$result);
  }
  if ($nd->{id} ne 'rto' && $nd->{id} ne 'rte') {
    my $temp=join('',@{$charstohere});
    my $revtemp=join('',reverse(@{$charstohere}));
    my $assembled='';
    if ($nodestohere->[0]{id} eq 'rte') {
      $assembled = $revtemp . $temp;
    } else {
      $assembled = $revtemp . substr($temp,1);
    }
    push @{$result},$assembled;
  }
}
