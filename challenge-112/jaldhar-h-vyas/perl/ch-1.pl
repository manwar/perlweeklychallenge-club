#!/usr/bin/perl
use 5.020;
use warnings;

my $path = shift // die "Must specify a path.";

$path =~ s{ /+ }   {/}gmsx;
$path =~ s{ / \z } {}msx;

my @dirs = split m{/}, $path;

for my $i (0 .. scalar @dirs - 1) {
    if ($dirs[$i] eq q{..}) {
        my $j = $i - 1;
        while ($j != 0 && $dirs[$j] eq q{}) {
            $j--;
        }
        $dirs[$j] = q{};
        $dirs[$i] = q{.};
    }
    if ($dirs[$i] eq q{.}) {
        $dirs[$i] = q{};
    }
}

say q{/} . (join q{/}, grep { $_ } @dirs);