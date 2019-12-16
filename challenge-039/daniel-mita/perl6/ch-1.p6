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

my Supplier $sign-in.=new;
my Supplier $sign-out.=new;

my Supplier $lightswitch.=new;
my Bool $light;

start react whenever $lightswitch.Supply {
  "Light has been switched {$light.=not ?? 'on' !! 'off'}".say;
}

start react {
  my %present is SetHash; # To contain @guest-list indexes

  whenever $sign-in.Supply {
    $lightswitch.emit(Nil) unless $light; # Pretty dark, let's hit the switch
    %present{$_}++;
    "@guest-list[$_]<name> has signed in".say;
  }

  whenever $sign-out.Supply {
    %present{$_}--;
    "@guest-list[$_]<name> has signed out".say;
    if %present ~~ ∅ {
      'Looks like nobody is here'.say;
      $lightswitch.emit(Nil);
    }
    else {
      say 'Leave light on for ' ~ %present.keys.map({ @guest-list[$_]<name> }).join(', ');
    }
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
  my @in  = @guest-list.pairs.grep(*.value<in>  eq $t).map(*.key);
  my @out = @guest-list.pairs.grep(*.value<out> eq $t).map(*.key);

  if @in.elems || @out.elems {
    "\n$t".say;
    $sign-in.emit($_)  for @in;
    $sign-out.emit($_) for @out;
  }
  elsif $all-times {
    "\n$t: Nothing happened".say;
  }

  sleep $sleep;
}

"\nLight was on for $light-duration minutes".say;
