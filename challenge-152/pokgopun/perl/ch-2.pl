### Providing no argument, the script will use sample data similar to the examples in the challenge's task
###
### Example usage: perl %script% -3,1 1,3 -1,-3 2,2
###
### Input: Rectangle 1 => (-3,-1), (1,3)
###        Rectangle 2 => (-1,-3), (2,2)
### 
### Output: 25
##
#
use strict;
use warnings;
use Data::Dumper;

### Take four arguments as lower (i.e. botton-left) and higher (i.e. top-right) coordinates of 1st and 2nd rectangles
### For example "rec1_xl,rec1_yl" "rec1_xh,rec1_yh" "rec2_xl,rec2_yl" "rec2_xh,rec2_yh"
### Parse arguments and assign to array which is in turn used to create data structure to href by the order of labes 

sub recCov {
	### get array of rectangle's coordinates
	my @rec = @{shift @_};
	### get debug toggle
	my $debug = shift;
	### every rectangle get an id start from 1
	my @rec_id = 1..@rec;
	### every rectangle's coordinate gets a position id, this will be 0 and 1 which are bottom left and top right for 2D rectangle
	my @pos_id = 0..$#{$rec[0]};
	### every axis in a coordinate, this will be x and y for 2D rectangle
	my @axis = @{["x".."z"]}[0..$#{$rec[0]->[0]}];
	### extract all the numbers from array of rectangle's cooridate, this will be converted to hash using rec_id, pos_id and axis_id
	my @val = ( map{@$_} map{@$_} @rec );
	my $val = {};
	foreach my $rec_id (@rec_id){
		foreach my $pos_id (@pos_id){
			foreach my $axis (@axis){
				push @{$val->{r}->{$rec_id}->{$axis}}, shift @val;
			}
		}
		$val->{r}->{$rec_id}->{c} = eval(join( " * ", map{ "abs(".join( " - ", @{$val->{r}->{$rec_id}->{$_}} ).")" } @axis ));
	}
	sub cTree {
		my($c,$n,$e,$res) = @_;
		if ( @$c == $n || @$c + @$e == $n ) {
			my @res = @{[@$c,@$e]}[0..$n-1];
			if ($res) {
				push @$res, \@res;
			} else {
				printf "%s\n", join(", ",@res);
			}
		} else {
			{
				my $ct = [@$c,@{$e}[0]];
				shift @$e if @$e;
				&cTree($ct,$n,[@$e],$res);
				redo if @$ct + @$e > $n;
			}
		}
	}
	my $o_rec = [];
	&cTree([],2,[@rec_id],$o_rec);
	foreach my $op (@$o_rec) {
		my $o_pair = join("_",@$op);
		my $ra = $val->{r}->{$op->[0]};
		my $rb = $val->{r}->{$op->[1]};
		foreach my $axis (@axis) {
			my $ra0 = $ra->{$axis}->[0]; 
			my $ra1 = $ra->{$axis}->[-1]; 
			my $rb0 = $rb->{$axis}->[0]; 
			my $rb1 = $rb->{$axis}->[-1]; 
			$val->{o}->{$o_pair}->{$axis} = $ra0 >= $rb1 || $rb0 >= $ra1 ? 0 :
				$ra1 <= $rb1 && $ra0 >= $rb0 ? $ra1 - $ra0 :
				$ra1 >= $rb1 && $ra0 <= $rb0 ? $rb1 - $rb0 :
				$ra1 > $rb1 && $ra0 > $rb0 ? $rb1 - $ra0 :
				$ra1 < $rb1 && $ra0 < $rb0 ? $ra1 - $rb0 : undef;
		}
		$val->{o}->{$o_pair}->{c} = eval(join(" * ",values %{$val->{o}->{$o_pair}}));
	}
	{
		last unless $debug;
		print Dumper $val;
	}
	my $sum_c = eval(join( " + ", map{ $val->{r}->{$_}->{c} } @rec_id)); 
	my $sum_o = eval(join( " + ", map{ $val->{o}->{join("_",@$_)}->{c} } @$o_rec )); 
	return $sum_c - $sum_o;
}

my @sample;
{
	last unless @ARGV;
	my $sample;
	while (@ARGV) {
		push @$sample, [ map{ [$_ =~ /(-?\d+)/g] } splice(@ARGV,0,2)];
	}	
	push @sample,$sample;
}
{
	last if @sample;
	push @sample, [ [[-1,0],[2,2]], [[0,-1],[4,4]] ];
	push @sample, [ [[-3,-1],[1,3]], [[-1,-3],[2,2]] ];
}

foreach (@sample) {
	my $i = 1;
	foreach (@$_) {
		printf "%s Rectangle $i => %s\n", $i++==1 ? "Input:" : "      ", join(", ", map{"(".join(",",@$_).")"} @$_); 
	}
	printf "\nOutput: %s\n\n", recCov($_); 
}

