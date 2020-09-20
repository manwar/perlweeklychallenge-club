.say for left-rotate((10, 20, 30, 40, 50), (3, 4));

.say for left-rotate((7, 4, 2, 6, 3), (1, 3, 4));

sub left-rotate(@A, @B) { gather take @A.rotate($_).Array for @B }
