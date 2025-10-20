#!/usr/bin/env perl

use Test::More;
use Test::Deep;

my @examples = (
    { input => { arr => [1, 2, 3, 4],    x => 12   }, exp => [1, 2, 4, 6]    },
    { input => { arr => [2, 7, 4],       x => 181  }, exp => [4, 5, 5]       },
    { input => { arr => [9, 9, 9],       x => 1    }, exp => [1, 0, 0, 0]    },
    { input => { arr => [1, 0, 0, 0, 0], x => 9999 }, exp => [1, 9, 9, 9, 9] },
    { input => { arr => [0],             x => 1000 }, exp => [1, 0, 0, 0]    },
);

foreach my $example (@examples) {
    is_deeply([add_to_array_form($example->{input}{arr}, $example->{input}{x})],
              $example->{exp});
}

done_testing;

sub add_to_array_form { map $_+0, split //, join('', @{$_[0]}) + $_[1] }
