use v5.38;

sub proc($a1, $a2){
    my @arr1 = @$a1;
    my @arr2 = @$a2;
    print "Input:   \@arr1 = ";
    print '"'.$_.'" ' for (@arr1);
    print "\n\t \@arr2 = ";
    print '"'.$_.'" ' for (@arr2);
    print "\n";
    my ($s1, $s2);
    $s1 .= $_ for (@arr1);
    $s2 .= $_ for (@arr2);
    say "Output: " , ($s1 ne $s2) ? "false\n" : "true\n";
}

my @arr1 = ("a", "bc");
my @arr2 = ("ab", "c");
proc(\@arr1, \@arr2);
@arr1 = ("a", "b", "c");
@arr2 = ("a", "bc");
proc(\@arr1, \@arr2);
@arr1 = ("a", "bc");
@arr2 = ("a", "c", "b");
proc(\@arr1, \@arr2);
@arr1 = ("ab", "c", "");
@arr2 = ("", "a", "bc");
proc(\@arr1, \@arr2);
@arr1 = ("p", "e", "r", "l");
@arr2 = ("perl");
proc(\@arr1, \@arr2);
