#! /usr/bin/env raku

unit sub MAIN ($order   where $order   ~~ /^ <[\d\s]>+ $/,
               $friends where $friends ~~ /^ <[\d\s]>+ $/,
	       :v(:$verbose));

my @order    = $order.words>>.UInt;

die "Order does not have 1 as lowest value" unless @order.min == 1;
die "Order does not have the size as highest value" unless @order.max == @order.elems;
die "Order has duplicates" if @order.repeated;

my @friends  = $friends.words>>.UInt;

die "Friends is not inside order" if @friends.min < 1 || @friends.max > @order.max;
die "Friends is not sorted" unless [<] @friends;

my %position = @order.antipairs;
my @result   = @friends.sort: { %position{$_} };

if $verbose
{
  for @result -> $id
  {
    say ": ID $id finished { ordinal(%position{$id} + 1) }.";
  }
}

say "({ @result.join(", ") })";

sub ordinal(Int $n)
{
  given $n
  {
    when 1  { "1st" }
    when 2  { "2nd" }
    when 3  { "3rd" }
    default { $_ ~ "th" }
  }
}
