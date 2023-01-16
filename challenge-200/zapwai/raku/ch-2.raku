my @truth = qw/ 1110111 0010010 1011101 1011011 0111010 1101011 0101111 1010010 1111111 1111010 /;
my $N = @*ARGS[0] || 200;
my $vert = 2;			#size of numbers.
my $horiz = 2*$vert + 1;

sub hor ($newline_flag, $i, @a) {
    if @a[$i] == 1 {
	print " ";
	print "-" x $horiz;
	if $newline_flag { say " " }
	else { print " " }
    } else {
	if $newline_flag { say " " x $horiz }
	else { print " " x ($horiz + 2) }
    }
}

sub ver ($newline_flag, $i, @a) {
    if @a[$i] == 1 {
	print("|");
    } else {
	print " ";
    }
    print " " x $horiz;
    if @a[$i + 1] == 1 {
	if $newline_flag { say "|" } else { print "|" };	
    } else {
	if $newline_flag { say " " } else { print " " };	
    }
}

sub d (@num) {
    my $last = pop @num;
    for (@num) {
	my @a = split("", @truth[$_], :skip-empty);
	hor(0,0, @a);
    }
    my @b = split("", @truth[$last], :skip-empty);    
    hor(1,0,@b);

    my $n = $vert;
    repeat {
	$n--;
	for (@num) {
	    my @a = split("", @truth[$_], :skip-empty);
	    ver(0,1, @a);
	}
	ver(1,1,@b);
    } while ($n > 0);
    
    for @num {
	my @a = split("", @truth[$_], :skip-empty);
	hor(0,3, @a);
    }
    hor(1,3, @b);

    $n = $vert;

    repeat {
	$n--;    
	for @num {
	    my @a = split("", @truth[$_], :skip-empty);	
	    ver(0,4, @a);
	}
	ver(1,4, @b);
    } while ($n > 0);

    for @num {
	my @a = split("", @truth[$_], :skip-empty);	
	hor(0,6, @a);	
    }
    hor(1,6, @b);
}
my @nums = split("",$N, :skip-empty);
d(@nums);
