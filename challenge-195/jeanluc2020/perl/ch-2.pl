#!/usr/bin/perl

my @list = (1,1,2,6,2);
print "(" . join(",", @list) . ") => " . smallest_even_integer(@list) . "\n";
@list = (1,3,5,7);
print "(" . join(",", @list) . ") => " . smallest_even_integer(@list) . "\n";
@list = (6,4,4,6,1);
print "(" . join(",", @list) . ") => " . smallest_even_integer(@list) . "\n";

sub smallest_even_integer {
   # we need only even numbers
   my @list = only_even(@_);
   return -1 unless @list; # no even numbers found
   my $map;
   # count each number in %$map, key is the number, value its count
   map { $map->{$_}++ } @list;
   # sort @list by the count for each number descending
   # if that's equal sort by the number ascending
   my @sorted = sort { $map->{$b} <=> $map->{$a} || $a <=> $b } @list;
   # solution is in the first element of the sorted array
   return $sorted[0];
}

sub only_even {
   my @result = ();
   foreach my $elem (@_) {
      push @result,$elem unless $elem % 2;
   }
   return @result;
}
