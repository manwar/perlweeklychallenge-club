use v6.d;

my @A1 = (10, 20, 30, 40, 50);
my @B1 = (3, 4);

my @A2 = (7, 4, 2, 6, 3);
my @B2 = (1, 3, 4);

sub rotate-array-by(:@array, :@indices) {
    gather for @indices {
	take @array.rotate: $_;
    }
}

.say for rotate-array-by :array(@A1), :indices(@B1);
.say for rotate-array-by :array(@A2), :indices(@B2);
