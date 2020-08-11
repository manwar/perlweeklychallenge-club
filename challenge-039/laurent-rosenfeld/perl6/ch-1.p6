use v6;

my $input =
   "1) Alex    IN: 09:10 OUT: 09:45
    2) Arnold  IN: 09:15 OUT: 09:33
    3) Bob     IN: 09:22 OUT: 09:55
    4) Charlie IN: 09:25 OUT: 10:05
    5) Steve   IN: 09:33 OUT: 10:01
    6) Roger   IN: 09:44 OUT: 10:12
    7) David   IN: 09:57 OUT: 10:23
    8) Neil    IN: 10:01 OUT: 10:19
    9) Chris   IN: 10:10 OUT: 11:00
    10) Liz    IN: 12:07 OUT: 17:05";

my %hm;
for 0..23 -> $hour {
    %hm{$hour}[$_] = 0 for 0..59;
}
for $input.lines {
    next unless /\S/;
    my ($in_h, $in_m, $out_h, $out_m) = map { +$_}, $/[0..3] if /(\d\d)':'(\d\d)\D+(\d\d)':'(\d\d)/;
    if ($out_h == $in_h) {
        %hm{$in_h}[$_] = 1 for $in_m..$out_m;
    } else {
        %hm{$in_h}[$_]  = 1 for $in_m..59; # end the first hour
        for $in_h + 1 .. $out_h -1 -> $hour {
            %hm{$hour}[$_] = 1 for 0..59; # If several hours
        }
        %hm{$out_h}[$_] = 1 for 0..$out_m; # Complete last hour
    }
}

my $total_on = 0;
for keys %hm -> $hour {
    $total_on += sum %hm{$hour};
}
say "Total time on: $total_on minutes.";
