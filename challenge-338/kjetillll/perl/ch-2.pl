use List::Util qw(max);

sub f             { my($a1, $a2) = @_; max map { //;     map abs( $' - $_ ), @$a2 } @$a1 }
sub f_less_memory { my($a1, $a2) = @_; max map { //; max map abs( $' - $_ ), @$a2 } @$a1 }

print f(            @$_)==$$_[2] ? "ok\n" : "error\n" and
print f_less_memory(@$_)==$$_[2] ? "ok\n" : "error\n" for 
[ [4, 5, 7],      [9, 1, 3, 4]        => 6 ],
[ [2, 3, 5, 4],   [3, 2, 5, 5, 8, 7]  => 6 ],
[ [2, 1, 11, 3],  [2, 5, 10, 2]       => 9 ],
[ [1, 2, 3],      [3, 2, 1]           => 2 ],
[ [1, 0, 2, 3],   [5, 0]              => 5 ],
