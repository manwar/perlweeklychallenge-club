my @arrivals   = <10:20 11:00 11:10 12:20 16:20 19:00>;
my @departures = <10:30 13:20 12:40 12:50 20:20 21:20>;
my @ts-arr = map { my ($m, $s) = split /\:/, $_; $m * 60 + $s;}, @arrivals;
my @ts-dep = map { my ($m, $s) = split /\:/, $_; $m * 60 + $s;}, @departures;
my $size = 0;
my $max-size = 0;
while @ts-arr.end != 0 {
    if @ts-dep.end == 0 {
        $max-size++;
    } elsif @ts-arr[0] <= @ts-dep[0] {
        shift @ts-arr;
        $size++;
        $max-size = $size if $size > $max-size;
        # say "$size $max-size";
    } else {
        shift @ts-dep;
        $size--;
    }
}
say $max-size;
