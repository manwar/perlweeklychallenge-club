#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 224 Task 1: Special Notes
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

sub special_notes {
    my ( $source, $target ) = @_;
    vsay "special_notes( '$source', '$target' )";

    my $ordered_source = join "", sort split '', $source;
    vsay "    ordered source: '$ordered_source'";

    my $pattern = '^.*' . join( '.*', sort split '', $target ) . '.*$';
    vsay "    target pattern: qr/$pattern/";

    vsay "    pattern match:  '$ordered_source' =~ /$pattern/";
    return $ordered_source =~ /${pattern}/ // 0;
}

run_tests;
