#!/usr/bin/env raku

my @A = 2, 1, 4, 5, 3, 7;
my $max-area = 0;
my @rect-indices;
my $rect-height;

exit if @A == 0;

for 1..@A -> $length {
    my @indices = |(0..(@A − $length) Z.. ($length − 1)..^@A).max: { @A[|$_].min }
    my $height = @A[@indices].min;
    my $area = $length × $height;
    if $area > $max-area {
    	$max-area = $area;
    	$rect-height = $height;
    	@rect-indices = @indices;
    }
}

print “$max-area\n\n”;

## Bonus ##
for @A.max...1 -> $height {
    print $height;
    for ^@A -> $index {
    	print “\t”;
    	my $number = @A[$index];
    	if $number ≥ $height {
    		## Extra bonus ##
    		if $index ∈ @rect-indices and $height ≤ $rect-height {
    			print “●”
    		} else {
    			print “○”
    		}
    	}
    }
    print “\n”;
}
print “\t” ~ @A.join(“\t”);
