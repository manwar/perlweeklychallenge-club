use strict;
use warnings;
use List::Util qw/all/;

sub common_path {
    my @paths = @_;

    my @parts = map { [ split '/', $_ ] } @paths;

    my @common;
    for my $i ( 0 .. $#{ $parts[0] } ) {
        my $part = $parts[0][$i];
        last unless all { $_->[$i] eq $part } @parts;
        push @common, $part;
    }

    return join '/', @common;
}

my @paths = (
    "/a/b/c/1/x.pl",   "/a/b/c/d/e/2/x.pl",
    "/a/b/c/d/3/x.pl", "/a/b/c/4/x.pl",
    "/a/b/c/d/5/x.pl"
);
print common_path(@paths), "\n";    # Output: /a/b/c
