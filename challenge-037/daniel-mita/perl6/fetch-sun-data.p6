#!/usr/bin/env perl6

# Data from https://sunrise-sunset.org/api
use WWW;
use JSON::Fast;

my ( $lat, $lng ) = 51.5, -0.1;
my Date @dates = gather {
  given Date.new(:year(2019), :month(11)) {
    .take;
    &?BLOCK(.succ) if .succ.year == 2019;
  }
};

my %results;
my Promise @promises;
for @dates -> $date {
  @promises.push(Promise.start({
    %results{$date}<sunrise sunset day_length> =
      jget('https://api.sunrise-sunset.org/json'
      ~ "?lat=$lat"
      ~ "&lng=$lng"
      ~ "&date=$date"
      ~ '&formatted=0'
    )<results><sunrise sunset day_length>;
  }))
}
await @promises;
%results.keys.sort.map({ $_ => %results{$_} }).&to-json.say;
