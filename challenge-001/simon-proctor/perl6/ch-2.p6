#sub prefix:<fb> (Int $i) {
#    $i %% 15 ?? "FizzBuzz"
#    !! $i %% 5 ?? "Buzz"
#    !! $i %% 3 ?? "Fizz"
#    !! $i
#}

#(1..20).map( fb * ).join("\n").say;


sub prefix:<fz> (Int $i) { $i %% 3 ?? "Fizz" !! "" }
sub prefix:<bz> (Int $i) { $i %% 5 ?? "Buzz" !! "" }
sub prefix:<fb> (Int $i) { (fz $i ~ bz $i) || $i.Str }

(1..20).map( fb * ).join("\n").say;
