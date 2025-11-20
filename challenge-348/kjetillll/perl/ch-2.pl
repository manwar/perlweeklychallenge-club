sub f {
    my($source, $target, $count) = map { /(\d+):(\d+)/ ? $1 * 60 + $2 : $_ } @_, 0;
    $source > $target       ? f( $source, $target + 24 * 60, 0          ) :
    $source <= $target - 60 ? f( $source, $target - 60,      $count + 1 ) :
    $source <= $target - 15 ? f( $source, $target - 15,      $count + 1 ) :
    $source <= $target -  5 ? f( $source, $target -  5,      $count + 1 ) :
    $source <= $target -  1 ? f( $source, $target -  1,      $count + 1 ) :
    $count
}

print f("02:30", "02:45") == 1 ? "ok\n" : "error\n";
print f("11:55", "12:15") == 2 ? "ok\n" : "error\n";
print f("09:00", "13:00") == 4 ? "ok\n" : "error\n";
print f("23:45", "00:30") == 3 ? "ok\n" : "error\n";
print f("14:20", "15:25") == 2 ? "ok\n" : "error\n";
