### Providing no argument, the script will use sample data similar to the examples in the challenge's task
###
### Example usage: perl %script% -3,1 1,3 -1,-3 2,2
###
### Input: Rectangle 1 => (-1,-3), (2,2)
###        Rectangle 2 => (-3,1), (1,3)
### 
### Output: 21
##
#
use strict;
use warnings;
use Data::Dumper;

### Take four arguments as lower (i.e. botton-left) and higher (i.e. top-right) coordinates of 1st and 2nd rectangles
### For example "rec1_xl,rec1_yl" "rec1_xh,rec1_yh" "rec2_xl,rec2_yl" "rec2_xh,rec2_yh"
### Parse arguments and assign to array which is in turn used to create data structure to href by the order of labes 

sub recArea {
	my @val = ( map{@$_} map{@$_} @{shift @_} );
	my $debug = shift;
	my $val = {};
	
	foreach ( map{ [ $_ =~ /(\w+)/g ] } qw/r-1-x-l r-1-y-l r-1-x-h r-1-y-h r-2-x-l r-2-y-l r-2-x-h r-2-y-h/ ){
		$val->{$_->[0]}->{$_->[1]}->{$_->[2]}->{$_->[3]} = shift @val;
	}
	
	### Calculate and add width,height,area of both rectangles
	
	my $rec = $val->{r};
	foreach my $r ( keys %$rec ){
		foreach ( map{ [ $_ =~ /(\w+)/g ] } qw/W-x H-y/ ){
			$rec->{$r}->{$_->[0]} = $rec->{$r}->{$_->[1]}->{h} - $rec->{$r}->{$_->[1]}->{l};
		}
		$rec->{$r}->{A} = $rec->{$r}->{W} * $rec->{$r}->{H};
	}
	
	### Create and add overlap value between both rectangles for x and y axis 
	foreach ( qw/x y/ ) {
		my ($r1_l, $r1_h, $r2_l, $r2_h) = ($rec->{1}->{$_}->{l}, $rec->{1}->{$_}->{h}, $rec->{2}->{$_}->{l}, $rec->{2}->{$_}->{h});
		$val->{o}->{$_} = $r1_l >= $r2_h || $r2_l >= $r1_h ? 0 :
				$r1_h <= $r2_h && $r1_l >= $r2_l ? $r1_h - $r1_l :
				$r1_h >= $r2_h && $r1_l <= $r2_l ? $r2_h - $r2_l :
				$r1_h > $r2_h && $r1_l > $r2_l ? $r2_h - $r1_l :
				$r1_h < $r2_h && $r1_l < $r2_l ? $r1_h - $r2_l : undef;
	}

	{
		last unless $debug;
		print Dumper $val;
	}
	return $rec->{1}->{A} + $rec->{2}->{A} - ( $val->{o}->{x} * $val->{o}->{y} ); 
}

my @sample;
{
	last unless @ARGV;
	my $argv = {@ARGV};
	my $sample;
	while (my($bl,$tr)=each%$argv){
		push @$sample, [ [$bl=~/(-?\d+)/g], [$tr=~/(-?\d+)/g] ]; 
	}
	push @sample,$sample;
}
{
	last if @sample;
	push @sample, [ [[-1,0],[2,2]], [[0,-1],[4,4]] ];
	push @sample, [ [[-3,1],[1,3]], [[-1,-3],[2,2]] ];
}

foreach (@sample) {
	my $i = 1;
	foreach (@$_) {
		printf "%s Rectangle $i => %s\n", $i++==1 ? "Input:" : "      ", join(", ", map{"(".join(",",@$_).")"} @$_); 
	}
	printf "\nOutput: %s\n\n", recArea($_); 
}

