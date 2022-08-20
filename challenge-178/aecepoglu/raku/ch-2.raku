my $hrDay = 24×3600;

# takes day of week (1-7)
sub days-until-next-work ($w) { ((((($w-1 min 4) + 1) % 5) - $w) % 7) + 1}

sub add-work-duration (DateTime $d, Duration $dt=Duration.new(3.5×3600)) {
	my $todayStart = $d.truncated-to('day');
	my $todayShiftEnd = $todayStart + Duration.new(17÷24 × $hrDay);

	if ($todayShiftEnd-$d) > $dt {
		$d + $dt
	} else {
	   my $dow = $d.day-of-week;
		my $spentToday = ($dow ≤ 5) × (0 max $todayShiftEnd-$d);
		my $nextShiftStart = $todayStart + Duration.new((9÷24 + days-until-next-work $dow) × $hrDay);
		$nextShiftStart + ($dt - $spentToday);
	}
}

#add-work-duration DateTime.new('2022-08-01 10:30'.subst(' ', 'T')~':00')
#add-work-duration DateTime.new('2022-08-01 10:30'.subst(' ', 'T')~':00')
#add-work-duration DateTime.new('2022-08-06 16:00'.subst(' ', 'T')~':00')
