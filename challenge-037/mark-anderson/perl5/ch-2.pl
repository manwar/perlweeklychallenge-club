#!/usr/bin/env perl
use Modern::Perl '2018';
use Mojo::UserAgent;
use feature 'signatures';
no warnings 'experimental::signatures';

# make a date from the seconds difference and print the hh:mm:ss
my $hms = (split /\s/, Mojo::Date->new(secs(11) - secs(12)))[4];
say "Dec has $hms less daylight";

sub secs($month) {
    my $ua = Mojo::UserAgent->new;

    my $link = "https://www.timeanddate.com/sun/uk/london?month=$month&year=2019";

    # load the 'Length' column values into a collection
    my $c = $ua->get($link)->result->dom->find('td[class="c tr sep-l"]')->map('text');

    # convert the values from hh:mm:ss to seconds
    $c->map(sub { $_ = Mojo::Date->new("1970-01-01T$_")->epoch });

    # sum the seconds in the collection
    $c->reduce(sub { $a + $b });
}

# Output:
# Dec has 21:15:39 less daylight
