#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

while (<>) {
    my $changes = y/e/E/;
    say $_, $changes
}
