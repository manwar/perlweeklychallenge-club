use strict;
use warnings;

sub split_strings {
    my ($words, $separator) = @_;

    # Flatten the split results and remove empty strings
    my @result = grep { $_ ne '' } map { split /\Q$separator\E/, $_ } @$words;

    return \@result;
}

# Tests
use Test::More tests => 2;
is_deeply(split_strings(["one.two.three", "four.five", "six"], "."), ["one", "two", "three", "four", "five", "six"]);

# Note: Escaping the $ character with a backslash
is_deeply(split_strings(["\$perl\$\$", "\$\$raku\$"], "\$"), ["perl", "raku"]);

# Sample Outputs
print join(",", @{split_strings(["one.two.three", "four.five", "six"], ".")}), "\n";

# Note: Escaping the $ character with a backslash
print join(",", @{split_strings(["\$perl\$\$", "\$\$raku\$"], "\$")}), "\n";
