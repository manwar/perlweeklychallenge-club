use POSIX qw(floor);
@a = (0..9,'A'..'Y');
$a = $ARGV[0];
while ($a) {
    push @b, $a[$a%35];
    $a=floor($a/35);
}
print join''=>(reverse@b)."\n";
