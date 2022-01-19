#! /usr/bin/perl6

use Test;
plan 3;

is(exval("10 + 20 - 5"),25,'example 1');
is(exval("(10 + 20 - 5) * 2"),50,'example 2');
is(exval("10 + 20 - 5 * 2"),20,'example 3');

sub exval($expr) {
  my @op=("(",")","+","-","*");
  my %opp=map {@op[$_] => $_},(0..@op.end);
  my @re=("\\-? <[0..9]>+");
  for @op -> $op {
    @re.push('\\' ~ $op);
  }
  my $re='(' ~ join('|',@re) ~ ')';
  my @opstack;
  my @valstack;
  for ($expr ~~ m:g/<$re>/) -> $token {
    if ($token ~~ /^ '-'? <[0..9]>+ /) {
      push @valstack,0+$token;
    } elsif ($token eq '(') {
      push @opstack,$token;
    } elsif ($token eq ')') {
      while (@opstack[*-1] ne '(') {
        push @valstack,operate(@opstack.pop,@valstack.pop,@valstack.pop);
      }
      pop @opstack;
    } elsif (%opp{$token}:exists) {
      while (@opstack.elems > 0 && %opp{@opstack[*-1]} >= %opp{$token}) {
        push @valstack,operate(@opstack.pop,@valstack.pop,@valstack.pop);
      }
      push @opstack,$token;
     } else {
       die "bad token $token\n";
     }
  }
  while (@opstack.elems > 0) {
    push @valstack,operate(@opstack.pop,@valstack.pop,@valstack.pop);
  }
  return @valstack[0];
}

sub operate($op,$a,$b) {
  if ($op eq '+') {
    return $b+$a;
  } elsif ($op eq '-') {
    return $b-$a;
  } elsif ($op eq '*') {
    return $b*$a;
  }
  die "unknown operator $op\n";
}
