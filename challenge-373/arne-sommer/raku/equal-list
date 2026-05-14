#! /usr/bin/env raku

unit sub MAIN (*@arrays where @arrays.elems > 2,
               :s(:$separator) = '|';
               :v(:$verbose));

my $sep-at = @arrays.first($separator, :k) || die "Did not find array separator";

my @arr1 = @arrays[0 .. $sep-at -1];
my @arr2 = @arrays[$sep-at +1 .. *];

my $arr1 = @arr1.join;
my $arr2 = @arr2.join;

if $verbose
{
  say ":\@arr1: { @arr1.map({ '"' ~ $_ ~ '"' }).join(", ") } -> \"$arr1\"";
  say ":\@arr2: { @arr2.map({ '"' ~ $_ ~ '"' }).join(", ") } -> \"$arr2\"";
}

say $arr1 eq $arr2;
