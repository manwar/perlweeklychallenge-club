#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub max_words{
  max map{scalar split} @{$_[0]}
}

printf "%d\n",max_words(['Hello world',
			 'This is a test','Perl is great']);
printf "%d\n",max_words(['Single']);
printf "%d\n",max_words(['Short',
			 'This sentence has six words in total',
			 'A B C',
			 'Just four words here']);
printf "%d\n",max_words(['One','Two parts','Three part phrase','']);
printf "%d\n",max_words(['The quick brown fox jumps over the lazy dog',
			 'A',
			 'She sells seashells by the seashore',
			 'To be or not to be that is the question']);

