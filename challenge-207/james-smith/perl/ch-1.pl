#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ [qw(Hello Alaska Dad Peace)],  'Alaska Dad' ],
 [ [qw(OMG Bye)               ],  '' ],
);

sub keyboard_words { grep {   m{^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$}i } @_ }
sub keyboard_word  { $_[0] =~ m{^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$}i      }

done_testing();

is( "@{[ keyboard_words(          @{$_->[0]} ) ]}", $_->[1] ) for @TESTS;

## This one looks for all keyboard words in a file...

m{^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$}i && print while <>;
