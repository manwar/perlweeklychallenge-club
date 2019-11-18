#!perl
use strict;

my $bound = $ARGV[0] || 11;

my $usage = "Usage: $0 \{Table width as a positive integer}";
die $usage unless $bound >0;
die $usage unless $bound =~ m/^\d*$/; #complain for non digits
 
my @bounds = (1..$bound);
my @col_widths = dynamic_widths($bound);
my $width_used = -$col_widths[0]-1;
$width_used += $_ +1 foreach @col_widths;

my $v = '|';
print left_pad($col_widths[0], 'x'.$v,@bounds)."\n"; #Top line
print '-' x ($col_widths[0]-1). '+'. '-' x $width_used."\n";
	  
for my $x (@bounds) {
	my $col_width = $col_widths[$x];
	my @results = ($x.$v); # First column has (v)ert separator appended
	for my $y ( @bounds) {
	  $results[$y] = $x * $y if $x <= $y;
	}
	print left_pad($col_width, @results)."\n";
}

sub val_char_width($) {
	return	-int(-2*log(shift) / log(10))+1;
}

sub dynamic_widths($) {
	my $bound = shift;
	my @widths = val_char_width($bound);
	for my $i ( 1..$bound) {
		push @widths, val_char_width($i);
	}	
	return @widths;
}

sub left_pad($@) {
	my ($width, @values) = @_;
	my @line;
	for my $width (@col_widths) {
		my $this_val   = shift @values;
		push @line, sprintf("%${width}s",$this_val);
	}
	return join(' ',@line);
}
