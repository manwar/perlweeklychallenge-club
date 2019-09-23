#! /usr/bin/perl

use strict;
use warnings;

use lib qw<blib/arch blib/lib>;
use Variable::Magic qw(wizard cast getdata VMG_UVAR);
use Storable qw(dclone);

my @history;

my $wiz=wizard(
  set => sub { warn "set\n";if (ref ${$_[0]}) {push @history,dclone(${$_[0]})} else {push @history,${$_[0]}} },
);

cast my ($x),$wiz;
$x=10;
$x+=5;
$x=[20];
# push @{$x},25; # this doesn't work
$x={a => 30};
# $x->{b}=30; # this doesn't work either

use Data::Dumper;
print Dumper(\@history);
