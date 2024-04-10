#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc postderef say signatures state };

my @examples = (

    'PeRlwEeKLy',
    'ChaLlenge',
    'The',
);

for my $example (@examples) {
    my $output = greatest_letter($example);
    say <<"END";
    Input:  \$str = "$example"
    Output: "$output"
END
}

sub greatest_letter ($str) {
    my @letters = split //, $str;
    my %hash;
    for my $l (@letters) {
        my $L = uc $l;
        $hash{$L} ||= '';
        if ( $L eq uc $l ) {
            if ( $L eq $l ) {    # uppercase
                if ( $hash{$L} !~ /U/ ) {
                    $hash{$L} .= 'U';
                }
            }
            else {               # lowercase
                if ( $hash{$L} !~ /L/ ) {
                    $hash{$L} .= 'L';
                }
            }
        }
    }
    my @contenders =
        grep { length $hash{$_} == 2 }
        sort { $b cmp $a }
        keys %hash;
    return @contenders ? shift @contenders : '';
}
