#!/usr/bin/env raku

sub count-common(@arr1,@arr2)
{
  ((@arr1,@arr2).flat.Bag.values.grep: {$_ == 2}).elems
}

say count-common(['Perl','is','my','friend'],
		 ['Perl','and','Raku','are','friend']);
say count-common(['Perl','and','Python','are','very','similar'],
		 ['Python','is','top','in','guest','languages']);
say count-common(['Perl','is','imperative','Lisp','is','functional'],
		 ['Crystal','is','similar','to','Ruby']);

