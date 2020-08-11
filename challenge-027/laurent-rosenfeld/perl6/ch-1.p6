use v6;

role Point {
    has $.x;
    has $.y;

    method gist {
        return "\n- Abscissa: $.x\n- Ordinate: $.y.";
    }
}
class Segment {
    has Point $.start;
    has Point $.end;

    method slope {
        return ($.end.y - $.start.y) / ($.end.x - $.start.x);
    }
    method y-intercept {
        my $slope = self.slope;
        return $.start.y - $slope * $.start.x;
    }
    method line-coordinates {
        return self.slope, self.y-intercept;
    }
}
sub compute-intersection (Segment $s1, Segment $s2) {
    my $abscissa = ($s2.y-intercept - $s1.y-intercept) /
                   ($s1.slope - $s2.slope);
    my $ordinate = $s1.slope * $abscissa + $s1.y-intercept;
    my $intersection = Point.new( x => $abscissa, y => $ordinate);
}
multi MAIN ( $a1, $b1, # start of line segment 1
             $a2, $b2, # end of line segment 1
             $a3, $b3, # start of line segment 2
             $a4, $b4  # end of line segment 2
         ) {
    exit unless valid-args |@*ARGS;
    my $segment1 = Segment.new(
            start => Point.new(x => $a1, y => $b1),
            end   => Point.new(x => $a2, y => $b2)
                              );
    my $segment2 = Segment.new(
            start => Point.new(x => $a3, y => $b3),
            end   => Point.new(x => $a4, y => $b4)
                              );
    say "Segments are parallel or colinear." and exit
        if $segment1.slope == $segment2.slope;
    say "Coordinates of intersection point: ",
        compute-intersection $segment1, $segment2;
}
multi MAIN () {
    say "Using default input values for testing. Should display poinr (2, 4).";
    my $segment1 = Segment.new(
            start => Point.new(x => 3, y => 1),
            end   => Point.new(x => 5, y => 3)
                              );
    my $segment2 = Segment.new(
            start => Point.new(x => 3, y => 3),
            end   => Point.new(x => 6, y => 0)
                              );
    say  "Coordinates of intersection point: ",
        compute-intersection $segment1, $segment2;
}
sub valid-args ( $a1, $b1, # start of line segment 1
                 $a2, $b2, # end of line segment 1
                 $a3, $b3, # start of line segment 2
                 $a4, $b4  # end of line segment 2
         ) {
    unless @*ARGS.all ~~ /<[\d]>+/ {
        say "Non numeric argument. Can't continue.";
        return False;
    }
    if $a1 == $a2 and $b1 == $b2 {
        say "The first two points are the same. Cannot draw a line.";
        return False;
    }
    if $a3 == $a4 and $b3 == $b4 {
        say "The last two points are the same. Cannot draw a line.";
        return False;
    }
    if $a1 == $a2 and $a3 == $a4 {
        say "The two segments are vertical. No intersection.";
        return False;
    }
    if $a1 == $a2 {
        # First segment is vertical but not the second one
        my $segment2 = Segment.new(
                start => Point.new(x => $a3, y => $b3),
                end   => Point.new(x => $a4, y => $b4)
            );
        my $ordinate = $segment2.slope
            * $a1 + $segment2.y-intercept;
        my $interception = Point.new(x => $a1, y => $ordinate);
        say "Coordinates of intersection point: ", $interception;
        return False;
    }
    if $a3 == $a4 {
        # Second segment is vertical but not the first one
        my $segment1 = Segment.new(
                start => Point.new(x => $a1, y => $b1),
                end   => Point.new(x => $a2, y => $b2)
            );
        my $ordinate = $segment1.slope
            * $a3 + $segment1.y-intercept;
        my $interception = Point.new(x => $a3, y => $ordinate);
        say "Coordinates of intersection point: ", $interception;
        return False;
    }
    return True;
}

