#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

while (<>) {
    my %anagrams;
    #
    # Iterate over the words. We're assuming all the words are on
    # a single line, and the words don't contain a double quote.
    # (If we can't assume this, we could use a CSV parser instead).
    #
    foreach my $word (/"([^"]+)"/g) {
        #
        # Normalize each word: split into characters, sort them, join them.
        # Note that we're splitting on characters, not graphemes, nor
        # do we normalize the input. This may lead to unexpected results
        # when using accented letters and/or combining characters. But
        # that's what you get when using poor specifications.
        #
        my $normalized = join "" => sort split // => $word;
        push @{$anagrams {$normalized}} => $word;
    }
    #
    # Print them. We make this deterministic, so we can easily write tests
    #
    foreach my $key (sort keys %anagrams) {
        say join ", " => map {qq {"$_"}} @{$anagrams {$key}};
    }
}

__END__
