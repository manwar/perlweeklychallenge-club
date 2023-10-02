use v5.30;
use Getopt::Std;
no warnings 'experimental';
my @ints = (2, 7, 4, 1, 8, 1);

my %op=();
getopts('bsriph',\%op);		# big, small, rand, shift, pop
die("Please select one option, (b)iggest, (s)mallest, (r)andom, sh(i)ft, or (p)op.")
    if ($op{b} + $op{r} + $op{s} + $op{p} + $op{i} + $op{h} > 1);
$op{b} = 1 if ($op{b} + $op{r} + $op{s} + $op{p} + $op{i} + $op{h} == 0);
my $method_flag =
    ($op{b} == 1) ? 'b'
    :($op{r} == 1) ? 'r'
    :($op{s} == 1) ? 's'
    :($op{i} == 1) ? 'i'
    :($op{p} == 1) ? 'p'
    : 'h';
if ($method_flag eq 'h') {
    say "Please select one option, (b)iggest, (s)mallest, (r)andom, sh(i)ft, or (p)op. Perl Weekly Challenge Week 222."; exit;
}
print "Using option $method_flag and taking selection ";
given ($method_flag) {
    when('b') { say "from two biggest entries"; }
    when('s') { say "from two smallest entries";}
    when('r') { say "from two random entries";  }
    when('i') { say "from two initial entries"; }
    when('p') { say "from two last entries";    }
}

say "Input: \@ints = (" . join(",",@ints) . ")";
while (@ints > 1) {
    my $i = get_index($method_flag, \@ints);
    my $x = splice @ints, $i, 1;    
    my $j = get_index($method_flag, \@ints);
    my $y = splice @ints, $j, 1;
    nicely_print($x,$y);
    push @ints, ($y - $x) unless ($y - $x == 0);
    say "(" . join(",",@ints) . ")";
}
say "Output: @ints";

sub nicely_print {
    my ($x, $y) = @_;
    my $cnt = 0;
    $cnt++ if ( $x < 0 );
    $cnt++ if ( $y < 0 );    
    $cnt++ if (abs $x > 9);
    $cnt++ if (abs $y > 9);
    my $width = 6 - $cnt;
    print " " x $width, "$x, $y --> ";
}

sub get_index() {
    my ($method_flag, $ref) = @_;
    my @ints = @$ref;
    my $i;
    given ($method_flag) {
	when('b') { $i = find_biggest($ref);}
	when('s') { $i = find_smallest($ref);}
	when('r') { $i = int rand(@ints);}
	when('i') { $i = 0; }
	when('p') { $i = $#ints;}
    }
    return $i;
}

sub find_biggest() {
    my $r = shift;
    my @ints = @$r;
    my $i;
    my $max = -10000;
    for my $j (0 .. $#ints) {
	if ($max < $ints[$j]) {
	    $max = $ints[$j] ;
	    $i = $j;
	}
    }
    return $i;
}

sub find_smallest() {
    my $r = shift;
    my @ints = @$r;
    my $i;
    my $min = 10000;
    for my $j (0 .. $#ints) {
	if ($min > $ints[$j]) {
	    $min = $ints[$j] ;
	    $i = $j;
	}
    }
    return $i;    
}
