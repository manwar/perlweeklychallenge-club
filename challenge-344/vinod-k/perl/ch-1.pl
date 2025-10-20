use strict;
use warnings;
use feature 'say';

sub add_to_array_form {
    my ($ints_ref, $x) = @_;

    my $int_form = join('', @$ints_ref);
    my $sum = $int_form + $x;
    my @result_array = split //, $sum;

    return @result_array;
}

#Testings
#Example 1
my @ints1 = (1, 2, 3, 4);
my $x1 = 12;
my @output1 = add_to_array_form(\@ints1, $x1);

say "Input Array: (". (join ', ', @ints1) . ")";
say "Input X: $x1";
say "Output Array: (". (join ', ', @output1) . ")\n";

#Example 2
my @ints2 = (2, 7, 4);
my $x2 = 181;
my @output2 = add_to_array_form(\@ints2, $x2);

say "Input Array: (". (join ', ', @ints2) . ")";
say "Input X: $x2";
say "Output Array: (". (join ', ', @output2) . ")\n";

#Example 3
my @ints3 = (9, 9, 9);
my $x3 = 1;
my @output3 = add_to_array_form(\@ints3, $x3);

say "Input Array: (". (join ', ', @ints3) . ")";
say "Input X: $x3";
say "Output Array: (". (join ', ', @output3) . ")\n";

#Example 4
my @ints4 = (1, 0, 0, 0, 0);
my $x4 = 9999;
my @output4 = add_to_array_form(\@ints4, $x4);

say "Input Array: (". (join ', ', @ints4) . ")";
say "Input X: $x4";
say "Output Array: (". (join ', ', @output4) . ")\n";

#Example 5
my @ints5 = (0);
my $x5 = 1000;
my @output5 = add_to_array_form(\@ints5, $x5);

say "Input Array: (". (join ', ', @ints5) . ")";
say "Input X: $x5";
say "Output Array: (". (join ', ', @output5) . ")\n";
