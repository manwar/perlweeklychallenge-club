<?php

class Point {

    public int $x;
    public int $y;

    public function __construct(int $x, int $y = 0) {
        $this->x = $x;
        $this->y = $y;
    }

}

class Rectangle {

    public Point $left;
    public Point $right;

    public function __construct(Point $left, Point $right) {
        $this->left = $left;
        $this->right = $right;
    }
    public function get_area() {
        return abs( $this->left->x - $this->right->x ) * abs( $this->left->y - $this->right->y );
    }
}



function get_total_area(Rectangle $first, Rectangle $second) {

    $area1 = $first->get_area();
    $area2 = $second->get_area();

    # calculate the overlapping area
    $x_dist = min( $first->right->x, $second->right->x ) - max( $first->left->x, $second->left->x );
    $y_dist = min( $first->right->y, $second->right->y ) - max( $first->left->y, $second->left->y );
    $area_i = 0;
    if (( $x_dist > 0 ) and ( $y_dist > 0 )) {
         $area_i = $x_dist * $y_dist;
    }

       return $area1 + $area2 - $area_i;
}

$first  = new Rectangle(new Point(-1, 0), new Point(2, 2) );
$second = new Rectangle(new Point(0, -1), new Point(4, 4) );

get_total_area( $first, $second ) == 22 or throw new Exception("Test 1 failed");

$first  = new Rectangle(new Point(-3, -1), new Point(1, 3) );
$second = new Rectangle(new Point(-1, -3), new Point(2, 2) );

get_total_area( $first, $second ) == 25 or throw new Exception("Test 2 failed");
?>
