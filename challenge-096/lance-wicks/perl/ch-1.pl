use strict;
use warnings;

use Test2::V0 -target => 'pw96';


can_ok($CLASS, 'reverse_words');

is $CLASS->reverse_words(
        'The Weekly Challenge' 
    ), 
    'Challenge Weekly The'
    , 'Example one is correct';


is $CLASS->reverse_words(
        '    Perl and   Raku are  part of the same family  ' 
    ), 
    'family same the of part are Raku and Perl'
    , 'Example two is correct';

done_testing;
