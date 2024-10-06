#!/usr/bin/perl

use strict;
use warnings;
use List::Util 'shuffle';


srand time;
while (<>) {
    print s{
            (?<![[:alpha:]].)
            (?<=[[:alpha:]])
            ([[:alpha:]]{2,})
            (?=[[:alpha:]])
            (?!.[[:alpha:]])
        }{join '', shuffle split //, $1}grex;
}
