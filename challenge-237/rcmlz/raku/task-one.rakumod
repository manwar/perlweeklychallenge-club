unit module rcmlz::raku::task-one:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr237/rcmlz/raku/ -- test/challenge-nr237/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr237 -- test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr237; cat /tmp/nr237_task-one.csv

#|[
Given a year, a month, a weekday of month, and a day of week (1 (Mon) .. 7 (Sun)), 
- print the day.
]
our sub solution(%input) is export {
	my $last-day-in-month = Date.new(%input<year>, %input<month>, *).day;
	my $counter = %input<weekday-of-month>;
	for 1..$last-day-in-month -> $dom {
		$counter-- if %input<day-of-week> == Date.new(%input<year>, %input<month>, $dom).day-of-week;
		return $dom unless $counter
	}
	return 0
}