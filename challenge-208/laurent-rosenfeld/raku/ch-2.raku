sub dupe-and-missing (@nums) { my ($dupe, $missing); for 1..@nums.end -> $i { if @nums[$i] == @nums[$i-1] { $dupe = @nums[$i]; } elsif @nums[$i] - @nums[$i-1] != 1 { $missing = @nums[$i-1] + 1; } } return “($dupe, $missing)” if $dupe and $missing; return “-1” unless $dupe or $missing; return “($dupe, -)” if $dupe; # no missing item return “(-, $missing)”; # no dupe }

for <1 2 2 4>, <1 2 3 4>, <1 2 3 3>, <1 2 4 5>, <1 1 3 4>, <1 3 4 5>, <1 2 2 3 5> -> @test { say “@test[]”.fmt(“%-12s => “), dupe-and-missing @test; }
