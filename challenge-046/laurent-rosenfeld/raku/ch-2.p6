use v6;
constant MAX = 50;
my @rooms = 1 xx MAX + 1; # (first employee)
my $start = 1;
for 2..MAX {
    $start++;
    my $door = $start;
    while $door <= MAX {
        @rooms[$door] = @rooms[$door] ?? 0 !! 1;
        $door += $start;
    }
  # say [+] @rooms[1..MAX];
}
say join " ", @rooms[1..MAX];
