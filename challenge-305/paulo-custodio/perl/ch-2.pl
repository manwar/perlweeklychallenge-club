#!/usr/bin/env perl

use Modern::Perl;

my @words = split ' ', <>;
my @alien = split ' ', <>;

say "(", join(", ", special_sort(\@words, \@alien)), ")";

sub special_sort {
    my ($words, $alien_array_ref) = @_;
    my $alien = join '', @$alien_array_ref;
    my $alpha = join '', 'a' .. 'z';

    # Pre-build the transliteration command for efficiency
    my $to_alpha   = "tr/\Q$alien\E/\Q$alpha\E/";

    return map  { $_->[0] }             # 3. Extract original words
           sort { $a->[1] cmp $b->[1] } # 2. Sort by translated version
           map  {                       # 1. Create [original, translated] pairs
               my $translated = $_;
               eval "\$translated =~ $to_alpha";
               [ $_, $translated ]
           } @$words;
}
