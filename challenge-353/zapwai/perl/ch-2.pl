use v5.38;

sub proc($c, $n, $s) {
    my @codes = @$c;
    my @names = @$n;
    my @status = @$s;
    say "Input: \n codes: @codes \n names: @names \n status: @status";
    my @cat = ("electronics", "grocery", "pharmacy", "restaurant");
    my @valid;
    for my $i (0 .. $#codes) {
	if ($status[$i] ne "true") {
	    push @valid, "false";
	    next;
	}
	my $flag = 0;
	foreach (@cat) {
	    $flag++ if ($_ eq $names[$i]);
	}
	if ($flag == 0) {
	    push @valid, "false";
	    next;
	}
	my @l = split '', $codes[$i];
	unless (@l) {
	    push @valid, "false";
	    next;
	}
	$flag = 0;
	for my $letter (@l) {
	    next if ($letter =~ /[a-z]/i);
	    next if ($letter =~ /[0-9]/);
	    next if ($letter eq '_');
	    $flag = 1;
	}
	push @valid, ($flag) ? "false" : "true"; 
    }
    say "Output: @valid\n";
}

my @codes = ("A123", "B_456", "C789", "D\@1", "E123");
my @names = ("electronics", "restaurant", "electronics", "pharmacy", "grocery");
my @status = ("true", "false", "true", "true", "true");
proc(\@codes, \@names, \@status);

@codes  = ("Z_9", "AB_12", "G01", "X99", "test");
@names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown");
@status = ("true", "true", "false", "true", "true");
proc(\@codes, \@names, \@status);

@codes  = ("_123", "123", "", "Coupon_A", "Alpha");
@names  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery");
@status = ("true", "true", "false", "true", "true");
proc(\@codes, \@names, \@status);

@codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4");
@names  = ("electronics", "electronics", "grocery", "grocery");
@status = ("true", "true", "true", "true");
proc(\@codes, \@names, \@status);

@codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99");
@names  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics");
@status = ("true", "true", "true", "true", "false");
proc(\@codes, \@names, \@status);
