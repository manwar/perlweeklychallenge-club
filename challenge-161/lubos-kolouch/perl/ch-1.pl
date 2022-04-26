package main;
use strict;
use warnings;

# glory for best belly boy!

sub is_abcd {
    my $what = shift;

    return $what eq join( '', sort( split //, $what ) );
}

open my $file, '<', 'dictionary.txt';

while (<$file>) {
    chomp;

    print "$_ is abcdrian \n" if is_abcd($_);
}
close $file;

use Test::More;

is( is_abcd('knotty'), 1 );
is( is_abcd('knotts'), '' );

done_testing;

1;
