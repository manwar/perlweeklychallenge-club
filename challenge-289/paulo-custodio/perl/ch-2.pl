#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'shuffle';

@ARGV and srand(shift//0);

while (<>) {
    s/(\w)(\w*)(\w)/$1 . join('', shuffle(split '', $2)) . $3/ge;
    print;
}
