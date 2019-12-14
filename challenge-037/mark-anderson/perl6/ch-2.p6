#!/usr/bin/env perl6
use HTTP::UserAgent;
use DOM::Tiny;

my $dt = DateTime.new(secs(11) - secs(12));

say "Dec has " ~ ($dt.hour,$dt.minute,$dt.second).join(":") ~ " less daylight";

sub secs($month) {
    my $link = "https://www.timeanddate.com/sun/uk/london?month=$month&year=2019";

    my $ua = HTTP::UserAgent.new;

    my $dom = DOM::Tiny.parse($ua.get($link).content);

    # load the 'Length' column values
    my $c = $dom.find('td[class="c tr sep-l"]').map(*.text);

    # convert the hh::mm::ss to seconds and sum them
    $c.map({DateTime.new("1970-01-01T$_.subst(/^(\d):/, {0 ~ $0})").posix}).sum;
}
