use strict;
use warnings;
##
# Compute a linear regression and output an SVG plot of the points
# and regression line.  
##
sub svg_begin{
    return <<BEGIN;
           <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
           <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
           <svg height="100%" width="100%" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
BEGIN
}

sub svg_end{
    return "</svg>";
}

sub svg_point{
    my($x, $y) = @_;
    return "<circle cx=\"$x\" cy=\"$y\" r=\"1\" />";
}

sub svg_line{
    my($x0, $y0, $x1, $y1) = @_;
    return "<line x1=\"$x0\" x2=\"$x1\" y1=\"$y0\" y2=\"$y1\" />";
}

sub svg{
    my @lines = @_;
    my $svg = svg_begin;
    for my $line (@_){
        $svg .= svg_point(@{$line}) if @{$line} == 2;
        $svg .= svg_line(@{$line})  if @{$line} == 4;
    }
    return $svg . svg_end;
}

sub linear_regression{
    my(@points) = @_;
    # 1. Calculate average of your X variable.
    my $sum = 0;
    my $x_avg;
    map{$sum += $_->[0]} @points;
    $x_avg = $sum / @points;
    # 2. Calculate the difference between each X and the average X.
    my @x_differences = map{$_->[0] - $x_avg} @points;
    # 3. Square the differences and add it all up. This is Sx.
    my $sx = 0;
    my @squares = map{$_ * $_} @x_differences;
    map{$sx += $_} @squares;
    # 4. Calculate average of your Y variable.
    $sum = 0;
    my $y_avg;
    map{$sum += $_->[1]} @points;
    $y_avg = $sum / @points;
    my @y_differences = map{$_->[1] - $y_avg} @points;
    # 5. Multiply the differences (of X and Y from their respective averages) and add them all together.  This is Sxy.
    my $sxy = 0;
    @squares = map {$y_differences[$_] * $x_differences[$_]} 0 .. @points - 1;
    map {$sxy += $_} @squares;
    # 6. Using Sx and Sxy, you calculate the intercept by subtracting Sx / Sxy * AVG(X) from AVG(Y).
    my $m = $sxy / $sx;
    my $y_intercept = $y_avg - ($sxy / $sx * $x_avg);
    my @sorted = sort {$a->[0] <=> $b->[0]} @points;
    my $max_x = $sorted[@points - 1]->[0];
    return [0, $y_intercept, $max_x + 10, $m * ($max_x + 10) + $y_intercept];
}

MAIN:{
    my @points;
    while(<DATA>){
        chomp;
        push @points, [split(/,/, $_)];
    }
    push @points, linear_regression(@points);
    print svg(@points);    
}


__DATA__
333,129
39,189
140,156
292,134
393,52
160,166
362,122
13,193
341,104
320,113
109,177
203,152
343,100
225,110
23,186
282,102
284,98
205,133
297,114
292,126
339,112
327,79
253,136
61,169
128,176
346,72
316,103
124,162
65,181
159,137
212,116
337,86
215,136
153,137
390,104
100,180
76,188
77,181
69,195
92,186
275,96
250,147
34,174
213,134
186,129
189,154
361,82
363,89
