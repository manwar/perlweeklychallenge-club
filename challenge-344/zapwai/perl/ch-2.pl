use v5.38;
use Algorithm::Permute;

sub proc($r, $s) {
    my @source = @$r;
    my @target = @$s;
    print "Input: \@source = ";
    print "[@$_]\t" for (@source);
    say "\n\t\@target = @target";
    my $t = join '', @target;

    my @piece;
    push @piece, join '', @$_ for (@source);
    my $o = "false";
    my @ind = (0 .. $#piece);
    my $p = Algorithm::Permute->new(\@ind);
    while (my @perm = $p->next) {
	my $permutation = "";
	for my $i (@perm) {
	    $permutation .= $piece[$i];
	}
	$o = "true" if ($permutation eq $t);
    }
    say "Output: $o\n";
}

my @source = ([2,3], [1], [4]);
my @target = (1, 2, 3, 4);  
proc(\@source, \@target);
@source = ([1,3], [2,4]);
@target = (1, 2, 3, 4);
proc(\@source, \@target);
@source = ([9,1], [5,8], [2]);
@target = (5, 8, 2, 9, 1);
proc(\@source, \@target);
@source = ([1], [3]);
@target = (1, 2, 3);
proc(\@source, \@target);
@source = ([7,4,6]);
@target = (7, 4, 6);
proc(\@source, \@target);
