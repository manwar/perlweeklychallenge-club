#! /usr/bin/env raku

subset SlashDate where * ~~ /^\d\d\d\d\/\d\d\/\d\d$/;

my $fmt = { sprintf "%04d/%02d/%02d", .year, .month, .day };

unit sub MAIN (SlashDate  $date  = "2021/09/18",
               SlashDate :$today = Date.new(DateTime.now, formatter => $fmt).Str,
	       :v($verbose));

my $date-iso = $date.subst("/", "-", :g);

my $earlier = Date.new($date-iso,                  formatter => $fmt);
my $now     = Date.new($today.subst("/", "-", :g), formatter => $fmt);

die "The date ($earlier) should be earlier than today ($now)" unless $earlier < $now;

my $diff = $now - $earlier;

say ": Today: $now" if $verbose;
say ": Difference: $diff days" if $verbose;

my $first = $earlier.earlier(day => $diff);
my $last  = $now.later(      day => $diff);

say "$first, $last";
