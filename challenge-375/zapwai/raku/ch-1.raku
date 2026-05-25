sub proc(@a, @b) {
    say "Input:  @array1 = " ~ @a ~"\n\t@array2 = " ~ @b;
    my $first = @a.Bag;
    my $second = bag @b;
    my $cnt = 0;
    for $first.keys -> $key {
	next if $first{$key} > 1;
	$cnt++ if $second{$key} == 1;
    }
    say "Output: $cnt\n";
}

my @array1 = < apple banana cherry >;
my @array2 = < banana cherry date >;
proc(@array1, @array2);
@array1 = < a ab abc >;
@array2 = < a a ab abc >;
proc(@array1, @array2);
@array1 = < orange lemon >;
@array2 = < grape melon >;
proc(@array1, @array2);
@array1 = < test test demo >;
@array2 = < test demo demo >;
proc(@array1, @array2);
@array1 = < Hello world >;
@array2 = < hello world >;
proc(@array1, @array2);
