use strict;
use warnings;
use feature qw/say/;

my @intervals = ([1,4], [3,5], [6,8], [12, 13], [3,20]);
my %vals;
my @conflicts;
for my $interv (@intervals) {
    my $overlap = 0;
    my ($st, $end) =  @$interv[0..1];
    for my $i ($st..$end) {
        $overlap = 1, next if exists $vals{$i};
        $vals{$i} = 1;
    }
    push @conflicts, $interv if $overlap;
}
say join ", ", @$_ for @conflicts;
