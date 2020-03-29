#!/usr/bin/perl
# Test: ./ch-6.p6

multi MAIN() {

    # 3 x 3 matrix
    my @three = (
        [1,2,3],
        [4,5,6],
        [7,8,9]
    );

    say 'Original ';
    print-matrix(@three);

    loop (my $i = 1; $i < 4; $i++) {
        say 'Rotate ' ~ 90 * $i;
        rotate-matrix(@three);
        print-matrix(@three) ;
    }
}

# Rotate the matrix
sub rotate-matrix(@m) {
    my $n = @m.elems;

    loop (my $i = 0; $i < Int($n / 2); $i++) {
    	loop (my $j = $i; $j < $n - $i - 1; $j++) {
    		my $temp = @m[$i; $j];
    		@m[$i; $j]           = @m[$n-$j-1; $i];
    		@m[$n-$j-1; $i]      = @m[$n-$i-1; $n-$j-1];
    		@m[$n-$i-1; $n-$j-1] = @m[$j; $n-$i-1];
    		@m[$j; $n-$i-1]      = $temp;
    	}
    }
}

# Print the matrix
sub print-matrix(@m) {
    for (@m) -> $row {
    	say $row.map(->
    		$value {
    			sprintf("%3d", $value)
    		}
    	).join;
    }
}
