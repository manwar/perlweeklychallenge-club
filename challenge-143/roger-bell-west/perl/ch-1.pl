#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(exval("10 + 20 - 5"),25,'example 1');
is(exval("(10 + 20 - 5) * 2"),50,'example 2');
is(exval("10 + 20 - 5 * 2"),20,'example 3');

sub exval {
  my $expr=shift;
  my @op=("(",")","+","-","*");
  my %opp=map {$op[$_] => $_} (0..$#op);
  my @re=("-?[0-9]+");
  foreach my $op (@op) {
    push @re,quotemeta($op);
  }
  my $re='('.join('|',@re).')';
  my @opstack;
  my @valstack;
  foreach my $token ($expr =~ /$re/g) {
    if ($token =~ /^-?[0-9]+$/) {
      push @valstack,0+$token;
    } elsif ($token eq '(') {
      push @opstack,$token;
    } elsif ($token eq ')') {
      while ($opstack[-1] ne '(') {
        push @valstack,operate(pop @opstack,pop @valstack,pop @valstack);
      }
      pop @opstack;
    } elsif (exists $opp{$token}) {
      while (scalar @opstack > 0 && $opp{$opstack[-1]} >= $opp{$token}) {
        push @valstack,operate(pop @opstack,pop @valstack,pop @valstack);
      }
      push @opstack,$token;
    } else {
      die "bad token $token\n";
    }
  }
  while (scalar @opstack > 0) {
    push @valstack,operate(pop @opstack,pop @valstack,pop @valstack);
  }
  return $valstack[0];
}

sub operate {
  my ($op,$a,$b)=@_;
  if ($op eq '+') {
    return $b+$a;
  } elsif ($op eq '-') {
    return $b-$a;
  } elsif ($op eq '*') {
    return $b*$a;
  }
  die "unknown operator $op\n";
}
