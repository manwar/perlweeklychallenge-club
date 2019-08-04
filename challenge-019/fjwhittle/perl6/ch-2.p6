#!/usr/bin/env perl6

#| Wrap the given file at the specified column using the greedy
#| algorithm.
unit sub MAIN(
  IO(Str) $file?,        #= File to wrap. Defaults to standard input.
  UInt :c(:$column) = 80 #= Column to wrap at. Defaults to 80.
);

($file // $*IN).comb(/ || )> \s *? \n
		       || <-[ \n ]> ** { 1..($column-1) } \S )> 
		          <?before [ \s || $ ]> <[ \s ] - [ \n ]>* \n ?
                       || \S ** { $column }
                   /)».put;

