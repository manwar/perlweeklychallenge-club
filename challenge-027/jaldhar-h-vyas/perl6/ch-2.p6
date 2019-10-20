#!/usr/bin/perl6

my @history;

sub historical($value) is rw {
    my $storage = $value;
    @history.push("Storing <$value> (was [])");
    
    Proxy.new(
        FETCH => method () {
            return $storage;
        },

        STORE => method ($new) {
            @history.push("Storing <$new> (was [$storage])");
            $storage = $new;
        },
    )
}
 
my $x := historical(10);
$x = 20;
$x -= 5;

 @history.join("\n").say;