#!/usr/bin/env perl

use Modern::Perl '2018';
use Mojo::UserAgent;

my $ua = Mojo::UserAgent->new;

my $array = $ua->get("https://www.poemist.com/api/v1/randompoems")
            ->result->json;

foreach my $i (keys $array->@*) {
    printf "%-7s%s\n",   "URL:",   $array->[$i]->{url};
    printf "%-7s%s\n",   "Poet:",  $array->[$i]->{poet}->{name};
    printf "%-7s%s\n\n", "Title:", $array->[$i]->{title};
    say                            $array->[$i]->{content}, "\n";
}
