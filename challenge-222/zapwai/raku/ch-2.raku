my @ints = (2, 7, 4, 1, 8, 1);
say " Input: " ~ @ints;
if @ints > 2 {
    repeat {
	my $n1 = (0 .. @ints.elems-1).rand.round;
	my $x = @ints.splice($n1,1);
	my $n2 = (0 .. @ints.elems-1).rand.round;
	my $y = @ints.splice($n2,1);
	@ints.push($y - $x) unless $y - $x == 0;
	say "$x, $y --> " ~ @ints;
    } while (@ints > 2);
}
@ints.elems == 2 ?? (my $o = @ints[1] - @ints[0]) !! ($o = @ints[0]);
say "Output: $o";
