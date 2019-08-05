use v6;

constant $share-fact = 0.01;
my $rest-of-the-pie = 1;
my ($max-guest, $max-sh) = 1, 0;
for 1..100 -> $guest-nr {
    my $share = $rest-of-the-pie * $guest-nr * $share-fact;
    ($max-guest, $max-sh) = ($guest-nr, $share) if $share > $max-sh;
    $rest-of-the-pie -= $share;
}
say "Lucky guest: $max-guest \tLargest share: $max-sh";
