use v5.30.0;
my @truth = qw( 1110111 0010010 1011101 1011011 0111010 1101011 0101111 1010010 1111111 1111010 );
my $N = $ARGV[0] || 200;

my $vert = 2;
my $horiz = 2*$vert + 1;
    
sub hor {
    my ($newline_flag, $i, @a) = @_;
    if ($a[$i]) {
	print " ";
	print "-" x $horiz;
	($newline_flag) ? { say " " } : { print " " };
    } else {
	($newline_flag) ? { say " " x $horiz } : { print " " x ($horiz + 2) }
    }
}

sub ver {
    my ($newline_flag, $i, @a) = @_;

    if ($a[$i]) {
	print "|";
    } else {
	print " ";
    }
    print " " x $horiz;
    if ($a[$i + 1]) {
	($newline_flag) ? { say "|" } : { print "|" };	
    } else {
	($newline_flag) ? { say " " } : { print " " };	
    }
}
    
sub d {
    my @num = @_;
    my $last = pop @num;
    foreach (@num) {
	my @a = split("", $truth[$_]);
	hor(0,0, @a);
    }
    my @b = split("", $truth[$last]);    
    hor(1,0, @b);

    my $N = $vert;
    do {
	$N--;    
	foreach (@num) {
	    my @a = split("", $truth[$_]);
	    ver(0,1, @a);
	}
	ver(1,1,@b);
    } while ($N > 0);
    
    foreach (@num) {
	my @a = split("", $truth[$_]);
	hor(0,3, @a);
    }
    hor(1,3, @b);

    $N = $vert;
    do {
	$N--;    
	foreach (@num) {
	    my @a = split("", $truth[$_]);	
	    ver(0,4, @a);
	}
	ver(1,4, @b);
    } while ($N > 0);

    foreach (@num) {
	my @a = split("", $truth[$_]);	
	hor(0,6, @a);	
    }
    hor(1,6, @b);
}

my @nums = split("",$N);
d(@nums);
