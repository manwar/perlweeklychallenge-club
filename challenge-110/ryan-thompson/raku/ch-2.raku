#!/usr/bin/env raku

# ch-2.raku - Transpose a CSV file
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Str $file ) {
    ([Z] $file.IO.lines.map(*.split(','))).map(*.join(','))».say;
}
