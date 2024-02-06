#!/usr/bin/env raku
use Test;

is-deeply most-freq-word("Joe hit a ball, the hit ball flew far after it was hit.", "hit"), ("ball",);
is-deeply most-freq-word("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"), ("Perl",);

sub most-freq-word($p, $w)
{
    my $b = $p.split(/<[\W]>/, :skip-empty).BagHash;
    $b{$w}:delete;
    $b.maxpairs>>.key
}
