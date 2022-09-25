#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

my @list1 = ([1,2], [3,4], [5,6], [1,2]);
my @list2 = ([9,1], [3,7], [2,5], [2,5]);

say unique-array(@list1);
say unique-array(@list2);

sub unique-array (@list)
{
  my @unique;
  my %seen;
  
  for @list -> $ref
  {
    next if %seen{$ref};
    @unique.push: $ref;
    %seen{$ref}++;
  }

  say ": Seen: " ~ %seen.raku if $verbose;
  return @unique;
}
