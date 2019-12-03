#!/usr/bin/env perl

use Modern::Perl '2018';
use Mojo::UserAgent;

my $ua = Mojo::UserAgent->new;

my $nov = "https://www.timeanddate.com/sun/uk/london?month=11&year=2019";
my $dec = "https://www.timeanddate.com/sun/uk/london?month=12&year=2019";

# load the 'Length' column values into a collection
my $nov_c = $ua->get($nov)->result->dom->find('td[class="c tr sep-l"]')->map('text');
my $dec_c = $ua->get($dec)->result->dom->find('td[class="c tr sep-l"]')->map('text');

# convert the values from hh:mm:ss to seconds
$nov_c->map(sub { $_ = Mojo::Date->new("1970-01-01T$_")->epoch });
$dec_c->map(sub { $_ = Mojo::Date->new("1970-01-01T$_")->epoch });

# sum the seconds in each collection
my $nov_sum = $nov_c->reduce(sub { $a + $b });
my $dec_sum = $dec_c->reduce(sub { $a + $b });

# make a date from the seconds difference and print the hh:mm:ss
my $hms = (split /\s/, Mojo::Date->new(abs($dec_sum - $nov_sum)))[4];
say "Dec has $hms", $dec_sum > $nov_sum ? " more " : " less ", "daylight";
