#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (qw{ abccccd aaabcddddeefff abcdd });

for my $example (@examples) {
    my @output = group_position($example);
    my $output = join ', ', map { qq{"$_"} } @output;
    say <<"END";
    Input:  \$str = "$example"
    Output: $output
END
}

sub group_position ($example) {
    return grep { length $_ > 2 } $example =~ m{
            # (\w) matches any word character
            # (\w)\1{2,} matches when there's one characters
            #   that is followed by two or more identical 
            #   characters. The form is { at least, no more than}
            # ((\w)\1) would give problems because it's trying to
            #   use the outer match
            # ((\w)\2) would return first the repeated characters 
            #   (like "aa") and then the first match itself ("a")
            # ((\w)\2{2,}) returns the "aaaaa" and then the "a"
            # 
            # there is perhaps magic that allows (\w) to be used 
            # within the regex but pass out, but I don't know it.
            # Therefore the grep.
            # 
            # also //x allows you to comment your complex regular
            # expressions.

            ( (\w)\2{2,} )
            }gmx;
}

