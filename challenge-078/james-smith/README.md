Solutions by James Smith.

# Challenge 1 - leader

There are two solutions to this - the naive one works left to right, but the optimal one runs right to left.

```perl
sub leader {                            ## Most efficient way is to work backwards on this rather 
                                        ## than forwards...

  return 0 unless @_;                   ## If nothing passed return 0 as requested.

  my @R = my $max = pop @_;             ## Last one will always be a "leader"...
  foreach ( reverse @_ ) {              ## Work forward and unshift the value if it is now a leader
    unshift @R, $max = $_ if $max < $_; ## greater than max value (and update max at the same time)
  }

  return @R;                            ## Return array of leaders...
}
```

Notes:

 * This is an O(n) solution where the forward solution is O(n^2);

# Challenge 2 - left rotate

This is a simpler challenge as this is something Perl is even better at - rotating an array is just
an array slice of the array with the indicies itself rotated...

The index rotation is easy:         "offset" .. "size of list", 0 .. ("offset" - 1);

So the code reduces to:

```perl
sub rotate {
  my $a = shift;
  ## First parameter is an arrayref containing the values to be rotated
  ## Remaining parameters are the offsets for each rotation

  ## This is a great use of array slicing to achieve what we need
  ## Indexes go from offset -> size-1 & 0 -> offset-1
  ## Perl nicely handles the case where the value to the left of
  ## the double dot is higher than the value to the right

  print "  [@{[ @{$a}[ $_..(@{$a}-1), 0..($_-1) ] ]}]\n" foreach @_;

  ## Let us use the @{[ ]} trick to embed content into the print
  ## statement - this is a very useful and often under used feature
  ## of perl which makes for simpler code when rendering output...
  ## this is nice because print "@A" an print @A are subtly different
  ## with the "@A" putting spaces (default value of $")
}
```

Notes:

 * We use Arrayref slice notation @{ $arrayref }[ @index_list ] to do the rotation

 * We use "@{[ ... ]}" string interpolation to insert these values into the output...
