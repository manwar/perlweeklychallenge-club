#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    {
        list => [ "the", "weekly", "challenge" ],
        char => "e",
    },
    {
        list => [ "perl", "raku", "python" ],
        char => "p",
    },
    {
        list => [ "abc", "def", "bbb", "bcd" ],
        char => "b",
    },
);

for my $example (@examples) {
    my $list   = join ',', map { qq{"$_"} } $example->{list}->@*;
    my $char   = $example->{char};
    my @output = find_words($example);
    my $output = join ', ', @output;
    say <<"END";
    Input:  \@list = ($list)
            \$char = "$char"
    Output: ($output)
END
}

sub find_words ($obj) {
    my @list = $obj->{list}->@*;
    my $char = $obj->{char};
    return grep { $list[$_] =~ /$char/ } 0 .. $#list;
}
