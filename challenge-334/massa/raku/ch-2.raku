@points = ([1, 2], [3, 1], [2, 4], [2, 3]);
$x = 3;
$y = 4;
say @points.grep({.[0] == $x or .[1] == $y}, :p).sort({abs($x - .value.[0])+abs($y - .value.[1])}).head.?key // -1

@points = ([3, 4], [2, 3], [1, 5], [2, 5]);
$x = 2;
$y = 5;
say @points.grep({.[0] == $x or .[1] == $y}, :p).sort({abs($x - .value.[0])+abs($y - .value.[1])}).head.?key // -1

@points = ([2, 2], [3, 3], [4, 4]);
$x = 1;
$y = 1;
say @points.grep({.[0] == $x or .[1] == $y}, :p).sort({abs($x - .value.[0])+abs($y - .value.[1])}).head.?key // -1

@points = ([0, 1], [1, 0], [0, 2], [2, 0]);
$x = 0;
$y = 0;
say @points.grep({.[0] == $x or .[1] == $y}, :p).sort({abs($x - .value.[0])+abs($y - .value.[1])}).head.?key // -1

@points = ([5, 6], [6, 5], [5, 4], [4, 5]);
$x = 5;
$y = 5;
say @points.grep({.[0] == $x or .[1] == $y}, :p).sort({abs($x - .value.[0])+abs($y - .value.[1])}).head.?key // -1
