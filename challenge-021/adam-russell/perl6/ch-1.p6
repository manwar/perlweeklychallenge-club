##
# Write a script to calculate the value of e.
##
sub e {
    my $quantity = 50; 
    my $digit_channel = Channel.new(); 
    $digit_channel.send(2);
    $digit_channel.send(".");
    e_calculation($digit_channel, $quantity);
    gather loop {
        take $digit_channel.poll() // do { 
            $quantity += 50; 
            e_calculation($digit_channel, $quantity);
            $digit_channel.receive();
        } 
    }  
} 

sub e_calculation($channel, $quantity) {
    my @d;
    my $n = $quantity;  
    my $m = 4;
    my @coefficients;
    my $test = ($n + 1) * (2.30258509);
    repeat {
        $m++;
    }while ($m * (log($m) - 1.0) + 0.5 * log(6.2831852 * $m) <= $test);
    @coefficients = (1) xx $m;
    for (1 .. $n) -> $i {
        my $carry = 0;
        loop (my $j = $m - 1; $j >= 2; $j--) {
            my $temp = @coefficients[$j] * 10 + $carry;
            $carry = floor($temp / $j);
            @coefficients[$j] = $temp - $carry * $j;
        }
        if ($i > $quantity - 50) { 
            $channel.send($carry); 
        }
    }
}

for e() -> $e {
    print $e; 
}  
