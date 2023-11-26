use v5.30;
my @matrix = ([1,1,0], [1,0,1], [0,0,0]);
my @new;

foreach my $r (@matrix) {
    my $row = join "", @$r;
    my $rev = reverse $row;
    my @dig = split("",$rev);
    my @current;
    foreach my $val (@dig) {
	push @current, ($val == 0) ? 1 : 0;
    }
    push @new, \@current;
}
say "Input:";
say @$_ for (@matrix);
say "\nOutput:";
say @$_ foreach (@new) ;


