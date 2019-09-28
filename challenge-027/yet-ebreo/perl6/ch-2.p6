# Write a script that allows you to capture/display historical data. It could be an object or a scalar. For example
# my $x = 10; $x = 20; $x -= 5;
# After the above operations, it should list $x historical value in order.

class hist {
    has @.history;
    has $!var handles <Str gist FETCH Numeric>;
    method STORE($val) {
        push @.history, $val;
        $!var = $val;
    }
}

my \x = hist.new(history => []);

x = 10; 
x = 20; 
x -= 5;
x = 3.1416;
x = Q[a quick brown fox jumps over the lazy dog];
x = 1e3;
x*= sqrt 3;
.say  for x.history;
