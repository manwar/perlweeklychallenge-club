use v6;

my $van-eck := 0, -> $a {
    state $index++;
    state %last-seen; LEAVE %last-seen{$a} = $index;
    %last-seen{$a}:exists ?? $index - %last-seen{$a} !! 0
} ... *;

say $van-eck[^30].join(', ');
say "Took " ~ (now - ENTER now) ~ " seconds";

say $van-eck[5000..^5030].join(', ');
say "Took " ~ (now - ENTER now) ~ " seconds";
