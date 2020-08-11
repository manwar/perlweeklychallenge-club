#!/usr/bin/env perl6

unit sub MAIN(
  :$sleep where { \($_) ~~ &sleep.signature } = 0, #= Add a sleep to emulate time passing
  Bool :$all-times, #= Print the times where nothing happens (recommended with --sleep)
);

constant @guest-list = (
  { name => 'Alex',    in => '09:10', out => '09:45' },
  { name => 'Arnold',  in => '09:15', out => '09:33' },
  { name => 'Bob',     in => '09:22', out => '09:55' },
  { name => 'Charlie', in => '09:25', out => '10:05' },
  { name => 'Steve',   in => '09:33', out => '10:01' },
  { name => 'Roger',   in => '09:44', out => '10:12' },
  { name => 'David',   in => '09:57', out => '10:23' },
  { name => 'Neil',    in => '10:01', out => '10:19' },
  { name => 'Chris',   in => '10:10', out => '11:00' },
);
my %present is SetHash; # To contain @guest-list indexes

my Bool $light;
sub lightswitch ( --> Nil ) {
  "Light has been switched {$light.=not ?? 'on' !! 'off'}".say;
}

sub sign-in ( $i --> Nil ) {
  lightswitch unless $light; # Pretty dark, let's hit the switch
  %present{$i}++;
  "@guest-list[$i]<name> has signed in".say;
}

sub sign-out ( $i --> Nil ) {
  %present{$i}--;
  "@guest-list[$i]<name> has signed out".say;
  if %present ~~ ∅ {
    'Looks like nobody is here'.say;
    lightswitch;
  }
  else {
    say 'Leave light on for ' ~ %present.keys.map({ @guest-list[$_]<name> }).join(', ');
  }
}

my $light-duration = 0;
loop (
  my $d = Date.today.DateTime.later(:9hours);
  $d.hour < 11 || $d.minute == 0;
  $d.=later(:1minute)
) {
  $light-duration++ if $light;

  my $t = $d.hh-mm-ss.substr(0, *-3); # Don't care about seconds
  my %sign;
  for <in out> -> $k {
    %sign{$k} = @guest-list.pairs.grep(*.value{$k} eq $t).map(*.key);
  }

  if %sign<in out>.any {
    "\n$t".say;
    sign-in($_)  for %sign<in> .values;
    sign-out($_) for %sign<out>.values;
  }
  elsif $all-times {
    "\n$t: Nothing happened".say;
  }

  sleep $sleep;
}

"\nLight was on for $light-duration minutes".say;
