#!/usr/bin/env perl6
     
# Just brute force.

my $mdy = sub ($self) { 
              sprintf "%02d%02d%04d", .month, .day, .year given $self;
          }

my $dt = Date.new(
    year      => 2000,
    month     => 1,
    day       => 1,
    formatter => $mdy
);

while ($dt.year < 3000) {
    my $str = sprintf "%s", $dt;

    if ($str eq $str.flip) {
        printf "%02d/%02d/%04d\n", .month, .day, .year given $dt;
    }

    #$dt += 1; # Formatting may be lost with this line 
               # so I'm doing the below hack for now.
               # (The issue has been fixed in Rakudo Star RC-1)
    $dt = $dt.succ.clone(formatter => $mdy);
}
