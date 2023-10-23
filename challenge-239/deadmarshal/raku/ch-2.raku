#!/usr/bin/env raku

sub consistent-strings(@arr,$allowed)
{
  (@arr.map:{$_.comb (<=) $allowed.comb}).grep({$_ == True}).elems
}

say consistent-strings(['ad','bd','aaab','baa','badab'],'ab');
say consistent-strings(['a','b','c','ab','ac','bc','abc'],'abc');
say consistent-strings(['cc','acd','b','ba','bac','bad','ac','d'],
		       'cad');
