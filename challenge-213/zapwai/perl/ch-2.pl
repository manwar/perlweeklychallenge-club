use v5.30.0;
no warnings;
## ## Not finished, no time this week.
## ## ## ## ## ## ## ## ## ## ## ## 
#my @routes = ([1,2,6], [5,6,7]);
my @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8]);
my $source = 1;
my $destination = 7;
print "Input:  \@routes = ";
my $inpstr = "(";
for (0 .. $#routes) {
    $inpstr .= "[". join(",", @{$routes[$_]}) . "], ";
}
$inpstr = substr $inpstr, 0, -2;
$inpstr .= ")";
say $inpstr;
say "\t\$source = $source";
say "\t\$destination = $destination\n";

my @path;
# Check for existence of source / destination values.
my ($srcflag, $destflag);
# Store locations of source / destination values.
my (@src, @dest);
for my $i (0 .. $#routes) {
    if ($source ~~ @{routes[$i]}) {
	$srcflag = 1;
	push @src, $i;
    }
    if ($destination ~~ @{routes[$i]}) {
	$destflag = 1;
	push @dest, $i;
    }
}
say "-1 (\$source not present)" unless ($srcflag);
say "-1, (\$destination not present)" unless ($destflag);

# If source and dest are both in one route detect this first.
my $ref = intersection(\@src, \@dest);
say "They are both in at least one route: e.g. route $$ref[0]" if (@$ref);
say "";
say "The source ($source) is in route " . join(",",@src);
say "The destination ($destination) is in route " . join(",", @dest);

say "";
my @links;		     # array refs containing the intersections
my (@A, @B);		     # begin/end routes
my @Z;
for my $i (0 .. $#routes - 1) {
    for my $j ($i + 1 .. $#routes) {
	my $t = intersection(\@{$routes[$i]}, \@{$routes[$j]});
	print "route $i intersects with route $j: ";
	say "@$t";
	foreach (@$t) {
	    push @A, $i;
	    push @B, $j;
	    push @links, $t;
	    $Z[$i][$j] = $t;
	}
    }
}

my @chain;
say "-" x 32;
foreach my $s (@src) {		# could be multiple, bug
  loop:    while (1) {
	push @chain, $s;
	if ($chain[$#chain] == $chain[$#chain - 1]) {
	    say "uhoh";
	}
	my $k = array_search($s, @A); # could be multiple, bug
	$s = $B[$k];
	foreach my $r (@dest) {
	    if ($s == $r) {
		push @chain, $s;
		last loop;
	    } else {
		# buggy, no chain -> exit
	    }
	}
    }
    say "Route Path: @chain";
}

my $output;
foreach (0 .. $#chain) {
    if ($_ == 0) {
	list_inter_path($source, @{$links[0]} ,$chain[$_]);
    } elsif ($_ == $#chain) {
	list_inter_path(@{$links[$#links]}, $destination ,$chain[$_]);
    } else {
	list_inter_path(@{$links[0]}, @{$links[1]} ,$chain[$_]);
    }
}

# Example
# list_inter_path(1,3,0);
# list_inter_path(3,8,2);
# list_inter_path(8,7,3);

sub list_inter_path {
    my ($start, $end, $rt) = @_;
    my $start_index = array_search($start,@{$routes[$rt]});
    my $end_index = array_search($end,@{$routes[$rt]});
    my @out = @{$routes[$rt]}[$start_index .. $end_index];
    unless (@out) {
	@out = @{$routes[$rt]}[$end_index .. $start_index];
	@out = reverse @out;
    }
    $output .= join ("",@out);
    $output .= "->";
}
$output = substr $output, 0, -2;
say $output;
sub intersection {
    my ($aref, $bref) = @_;
    my @A = @$aref;
    my @B = @$bref;
    my @ans;
    foreach (@A) {
	push @ans, $_ if ($_ ~~ @B);
    }
    \@ans
}
# Shamelessly stolen from stack exchange bc I liked it
sub array_search { my ($element, @array) = @_; foreach (0..$#array) { if ($array[$_] eq $element) { return $_; } } return -1; }
