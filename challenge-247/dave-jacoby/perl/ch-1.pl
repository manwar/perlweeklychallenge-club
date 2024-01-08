#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [
        'Mr. Wall',
        'Mrs. Wall',
        'Mr. Anwar',
        'Mrs. Anwar',
        'Mr. Conway',
        'Mr. Cross',
    ],

    [ 'Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', ],
);

for my $example (@examples) {
    my %output = secret_santa( $example->@* );
    my $input = join ",\n\t",
        map  { qq{"$_"} }                               # quote surname
        map  { $_->[0] }                                # remove surname element
        sort { $a->[1] cmp $b->[1] }                    # sort on surname
        map  { [ $_, ( reverse split /\s/, $_ )[0] ] }  # start schartzian transform on surname
        sort { $a cmp $b } $example->@*;                # sort alphabetically for consistency
    my $output = join "\n\t",
        map  { qq{$_ -> $output{$_}} }                  # combine santa and giftee 
        map  { $_->[0] }                                # remove surname element
        sort { $a->[1] cmp $b->[1] }                    # sort on surname
        map  { [ $_, ( reverse split /\s/, $_ )[0] ] }  # start schartzian transform on surname
        sort { $a cmp $b } keys %output;                # sort alphabetically for consistency

    say <<~"END";
    Input:  \$input = (
            $input
            );
    Output:
            $output
    END

}

# 1) everybody gets matched
# 2) nobody gets matched to themself
sub secret_santa (@input) {
    my %done;

    for my $name (@input) {
        my %chosen = reverse %done;
        my @others =
            sort { rand 10 <=> rand 10 }
            grep { $_ ne $name } @input;
        for my $giftee (@others) {
            next if $chosen{$giftee};
            $done{$name} = $giftee;
        }
    }
    return %done;
}
