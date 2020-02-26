#!/usr/bin/env perl

use strict;
use warnings;

use Cwd qw{abs_path};

my $file = abs_path($0);
if ( -f $file && open my $fh, '<', $file ) {
    print join '', <$fh>;
}
