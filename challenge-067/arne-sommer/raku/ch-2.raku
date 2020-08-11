#! /usr/bin/env raku

unit sub MAIN ($S where $S.chars > 0);

my %button;

%button<1> = <_ , @>;
%button<2> = <a b c>;
%button<3> = <d e f>;
%button<4> = <g h i>;
%button<5> = <j k l>;
%button<6> = <m n o>;
%button<7> = <p q r s>;
%button<8> = <t u v>;
%button<9> = <w x y z>;
%button<*> = (' ',);

my @solutions;

off-we-go("", $S);

say "[", @solutions.map({ "\"{ $_ }\"" }).join(", "), "]" if @solutions;

sub off-we-go ($so-far, $to-do)
{
  if $to-do.chars == 0
  {
    @solutions.push: $so-far;
    return;
  }

  my $current   = $to-do.substr(0,1);
  my $remainder = $to-do.substr(1);

  die "Illegal character $current" unless %button{$current};

  for @(%button{$current}) -> $character
  {
    off-we-go($so-far ~ $character, $remainder);
  }
}
