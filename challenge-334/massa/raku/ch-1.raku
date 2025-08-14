$x = 0;
$y = 2;
@ints = (-2, 0, 3, -5, 2, -1);
say @ints[$x .. $y].sum;

$x = 1;
$y = 3;
@ints = (1, -2, 3, -4, 5);
say @ints[$x .. $y].sum;

$x = 3;
$y = 4;
@ints = (1, 0, 2, -1, 3);
say @ints[$x .. $y].sum;

$x = 0;
$y = 3;
@ints = (-5, 4, -3, 2, -1, 0);
say @ints[$x .. $y].sum;

$x = 0;
$y = 2;
@ints = (-1, 0, 2, -3, -2, 1);
say @ints[$x .. $y].sum;
