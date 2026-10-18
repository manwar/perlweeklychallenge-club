#! /usr/bin/env raku

subset ComplexStr where * ~~ /^ \-? \d+ \+ \(? \-? \d+ \)? i $/;

unit sub MAIN (ComplexStr $num1, ComplexStr $num2, :v(:$verbose));

sub gen-complex(Str $s)
{
  $s ~~ /^ (\-?\d+) \+ \(? (\-?\d+) \)? i $/;
  Complex.new($0.Int, $1.Int);
}

my $complex1 = gen-complex($num1);
my $complex2 = gen-complex($num2);
my $product  = $complex1 * $complex2;

if $verbose
{
  say ": Real: { $complex1.re } * { $complex2.re } - { $complex1.im } * { $complex2.im } = { $product.re }";
  say ": Imag: { $complex1.re } * { $complex2.im } + { $complex1.im } * { $complex2.re } = { $product.im }";
}

say "{ $product.re }+{ $product.im < 0 ?? "({ $product.im })" !! $product.im }i";
