use strict;
use warnings;

sub common_chars {
    my @words = @_;
    my %common = map { lc($_) => 1 } split //, $words[0];
    for my $word (@words[1..$#words]) {
        my %chars = map { lc($_) => 1 } split //, $word;
        for my $char (keys %common) {
            delete $common{$char} unless exists $chars{$char};
        }
    }
    return [sort keys %common];
}

# Test Cases
print join(", ", @{common_chars("Perl", "Rust", "Raku")});  # r
print join(", ", @{common_chars("love", "live", "leave")});  # e, l, v

