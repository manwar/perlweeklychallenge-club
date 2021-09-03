use v6;

my @intervals = (1,4), (3,5), (6,8), (12, 13), (3,20);
my %vals;
my @conflicts;
for @intervals -> $interv {
    my $overlap = False;
    my ($st, $end) = $interv[0,1];
    for $st..$end -> $i {
        $overlap = True and next if %vals{$i}:exists;
        %vals{$i} = 1;
    }
    push @conflicts, $interv if $overlap;
}
say @conflicts;
