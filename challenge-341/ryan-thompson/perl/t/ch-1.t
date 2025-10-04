#!perl

require './ch-1.pl';

use Test2::V0;

# Scalar (count)
is  pssible('Hello world',               'd'     ), 1;
is  pssible('apple banana cherry',       'a', 'e'), 0;
is  pssible('Coding is fun',             ()      ), 3;
is  pssible('The Weekly Challenge',      'a', 'b'), 2;
is  pssible('Perl and Python',           'p'     ), 1;

# Array
is [pssible('Hello world',               'd'     )], ['Hello'];
is [pssible('Foo bar baz',               'z'     )], ['Foo', 'bar'];
is [pssible('All words impossible',      'l', 'd')], [ ];

# Degenerate
is  pssible(''),   0;
is [pssible('')], [ ];

# hack3r! but not really.
ok dies { pssible('foo', 'a](?{ warn })[') };

done_testing;
