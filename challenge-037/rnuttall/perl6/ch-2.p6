#!/usr/bin/env perl6

# Write a script to find out the DayLight gain/loss in the month of December 2019 as compared
# to November 2019 in the city of London.
# You can find out sunrise and sunset data for November 2019 and December 2019 for London.

use DateTime::Format;
use LWP::Simple;
use HTML::Parser::XML;

# pull and cache the URL
sub GetPage($url,$fn --> Str) {
    my $content = slurp($fn);

    if $content {
        return $content;
    }
    else {
        $content = LWP::Simple.get($url);
        spurt($fn, $content) or die "Can't save cached file";
        say "Saved Cached file for $fn";
        return $content;
    }
}

# Parse the daylength for each day of a month from the named URL and sum them up, returning result in seconds
sub GetDaytime($url,$fn --> Int:D) {
    my $parser  = HTML::Parser::XML.new;
    my $xmldoc  = $parser.parse(GetPage($url,$fn));
    my $daytime = 0;

    my $table = $xmldoc.root.elements(:TAG<table>, :RECURSE)[0]; # There is only one table
    for $table.elements(:TAG<tr>, :RECURSE) -> $tr {
        my $td = $tr.elements(:TAG<td>, :RECURSE);
        next unless $td.elems == 12;                             # Ignore header row
        my $daylen = $td[2].nodes[0].text;                       # Daylength is in 3rd column ...
        $td[2].nodes[0].text ~~ /(\d+) ':' (\d+) ':' (\d+)/;     # ... as HH:MM:SS
        $daytime += $0*60*60 + $1*60 + $2;
    }
    return $daytime;
}

sub MAIN($year = 2019) {
    my $daytimeDec = GetDaytime('https://www.timeanddate.com/sun/uk/london?month=12&year=2019','London-2019-12');
    my $daytimeNov = GetDaytime('https://www.timeanddate.com/sun/uk/london?month=11&year=2019','London-2019-11');

    say "December $year has a total of $daytimeDec seconds daylength in London";
    say "November $year has a total of $daytimeNov seconds daylength in London";
    my $diff = $daytimeNov - $daytimeDec;
    say "November is longer by $diff seconds, or ", ($diff.polymod(60, 60, 24, 7) Z <sec min hr d wk>).grep(*[0]).reverse.join(", ");
}