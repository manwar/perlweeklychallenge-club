#!/usr/bin/env raku

sub MAIN(
  IO() $input-file = 'temperature.txt' #= temperature file to read
) {
  $input-file
    .lines
    .map: { .split: ', ' andthen .[0].Date, .[1] } andthen
    .sort
    .rotor: 2 => -1 andthen
    .map: -> (($, $previous-temp), ($current-date, $current-temp)) { $current-temp > $previous-temp ?? $current-date !! Empty } andthen
    .join: "\n" andthen
    .say;
}

sub MAIN1(
  IO() $input-file = 'temperature.txt' #= temperature file to read
) {
  my %daily-temperatures = $input-file
    .lines
    .map: { .split: ', ' andthen slip .[0].Date, .[1] };
  my $pivot-date = %daily-temperatures.keys.min;
  my @hot-days = gather while %daily-temperatures{$pivot-date} -> $previous-temp {
    my $current-date = $pivot-date.succ;
    LEAVE $pivot-date = $current-date;
    if %daily-temperatures{$current-date} -> $current-temp {
      take $current-date if $current-temp > $previous-temp;
    }
  };
  @hot-days
    .join: "\n" andthen
    .say;
}
