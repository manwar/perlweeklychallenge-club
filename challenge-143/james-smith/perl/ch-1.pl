#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my(@s,@o);

## List of operators - Entries in each array are:
##  * precedence of operator
##  * function to be run when finding operator in infix stream
##  * function to be run when finding operator in rpn stream

my %f;
%f = (
  '('=>[0,sub{push@s,'(' },                                                       ],
  ')'=>[0,sub{push@o,$_ while($_=pop@s)ne'('},                                    ],
  '*'=>[2,sub{push@o,pop@s while@s&&$f{$s[-1]}[0]>1;push@s,'*'},sub{$s[-2]*=pop@s}],
  '+'=>[1,sub{push@o,pop@s while@s&&$f{$s[-1]}[0];  push@s,'+'},sub{$s[-2]+=pop@s}],
  '-'=>[1,sub{push@o,pop@s while@s&&$f{$s[-1]}[0];  push@s,'-'},sub{$s[-2]-=pop@s}],
);

my @TESTS = (
  [ '10 + 20 - 5', 25 ],
  [ '(10 + 20 - 5) * 2', 50 ],
  [ '(5 - 10) * -5', 25 ],
  [ '10 * 10 - 6 * 6 - 8 * 8', 0 ],
  [ '4 + 4 - 6 - 2', 0 ],
  [ '(10 + 10) * (10 - 10) * (10 + 10) * (20 - (((20))))', 0 ],
);

is( evaluate(        $_->[0]), $_->[1] ) foreach @TESTS;
is( evaluate_via_rpn($_->[0]), $_->[1] ) foreach @TESTS;
is( evaluate_rpn_hsh($_->[0]), $_->[1] ) foreach @TESTS;
is( eval(            $_->[0]), $_->[1] ) foreach @TESTS;
cmpthese( 20000, {
  'evaluate' => sub { evaluate($_->[0]) for @TESTS },
  'eval_rpn' => sub { evaluate_via_rpn($_->[0]) for @TESTS },
  'eval_hsh' => sub { evaluate_rpn_hsh($_->[0]) for @TESTS },
  'eval'     => sub { eval(    $_->[0]) for @TESTS },
});
done_testing();

sub evaluate  {
  my $str = shift;
  1 while $str =~ s/\(\s*([^()]*?)\s*\)/       evaluate($1)             /e;
  1 while $str =~ s/(-?\d+)\s*\*\s*(-?\d+)/    $1 * $2                  /e;
  1 while $str =~ s/(-?\d+)\s*([-+])\s*(-?\d+)/$2 eq '+' ? $1+$3 : $1-$3/e;
  return $str;
}

sub evaluate_via_rpn  {
  @s=();@o=();

  for ( $_[0] =~ m{(-?\d+|[-+*()])}g ) {
    if( m{\d} ) {
      push @o, $_;
    } elsif( $_ eq '(' ) {
      push @s, $_;
    } elsif( $_ eq ')' ) {
      push @o, $_ while ($_ = pop @s) ne '(';
    } else {
      push @o, pop @s while @s && $f{$s[-1]}[0] && $f{$_}[0]<=$f{$s[-1]}[0];
      push @s, $_;
    }
  }
  push @o, reverse @s;

  @s = ();
  ## Now evaluate the RPN tree...
    $_ eq '+' ? $s[-2] += pop @s
  : $_ eq '-' ? $s[-2] -= pop @s
  : $_ eq '*' ? $s[-2] *= pop @s
  :             (push @s, $_) for @o;
  $s[0];
}

## Code from hell... First for loop processes the infix into rpn
##                   Second for loop processes the rpn stream
sub evaluate_rpn_hsh  {
  @o=(); @s=();
  ($f{$_}) ? (&{$f{$_}[1]}) : (push@o,$_) for $_[0] =~ m{(-?\d+|[-+*()])}g;
  ($f{$_}) ? (&{$f{$_}[2]}) : (push@s,$_) for @o, reverse splice @s,0;
  $s[0];
}

