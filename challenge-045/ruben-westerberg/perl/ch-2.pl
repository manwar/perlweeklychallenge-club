#!/usr/bin/env perl
use strict;
use warnings;
open my $f,"<",$0;
print $_ for ( <$f> );
