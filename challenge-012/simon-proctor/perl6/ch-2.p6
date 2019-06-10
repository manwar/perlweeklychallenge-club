#!/usr/bin/perl6

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a list of paths returns the longest shared path between them
multi sub MAIN(
    *@paths, #= List of paths to check
    :$seperator = $*SPEC.dir-sep #= Optional directory seperator. Defaults to the system standard.
) {
    my @checks = @paths.sort( { $^b.codes <=> $^a.codes } )[0].split($seperator)[1..*-2];
    my $path = $seperator;
    my $new-path = $path;
    while ( all( @paths ) ~~ / ^ $new-path / ) {
        $path = $new-path;
        $new-path ~= ( @checks.shift ~ $seperator );
    };
    say $path;
}
