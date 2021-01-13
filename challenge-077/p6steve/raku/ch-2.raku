my \X = 'X'; 
my \O = 'O';

my @window = [ 
	[ O, O, O ],
	[ O, X, O ],
	[ O, O, O ], 
];

my @matrix1 = [ 
	[ O, O, X ],
	[ X, O, O ],
	[ X, O, O ], 
];

my @matrix2 = [
	[ O, O, X, O ],
	[ X, O, O, O ],
	[ X, O, O, X ],
	[ O, X, O, O ],
];

sub x-walk( @x ) {
	my $count = 0;
	loop (my $m=0; $m < @x[*]; $m++) {		#matrix  cols 
		loop (my $n=0; $n < @x; $n++) {		#... and rows 
			next unless @x[$m;$n] eq X;
			my @w = @window;
			my $x-hits = 0;
			loop (my $i=0; $i <= 2; $i++) {			#window cols 
				my $m-win = $m-1 + $i;
				next unless 0 <= $m-win < @x[*];
				loop (my $j=0; $j <= 2; $j++) {		#... and rows 
					my $n-win = $n-1 + $j;
					next unless 0 <= $n-win < @x;
					@w[$i;$j] = @x[$m-win;$n-win];
					$x-hits++ if @w[$i;$j] eq X;
				}
			}
			$count++ unless $x-hits > 1;
		}
	} 
	return $count;
}

say x-walk( @matrix1 );
say x-walk( @matrix2 );

