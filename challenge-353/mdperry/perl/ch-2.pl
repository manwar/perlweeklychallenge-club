#! /usr/bin/env perl

use v5.36;

my @codes = ();
my @names = ();
my @status = ();
my %examples = ();

while (<DATA>) {
    chomp;
    my @row = split(/\t/, $_);
    my $example = shift (@row);
    my $type = shift (@row);
    $examples{$example}++;
    if ($type =~ m/codes/) {
        push( @codes, \@row);
    }
    elsif ($type =~ m/names/) {
        push( @names, \@row);
    }
    else {
        push( @status, \@row);
    }
}

my @examples = sort (keys %examples);

my %categories = ( electronics => undef,
		   grocery => undef,
		   pharmacy => undef,
		   restaurant => undef,
 	         );
my @output = ();

my $i = 0;

foreach ( @codes ) {
    my @test_codes = @{ $codes[$i] };
    push ( @output, "false" ) foreach ( @test_codes );
    my @test_names = @{ $names[$i] };
    my @test_status = @{ $status[$i] };

    foreach my $j ( 0..$#test_status ) {
        if ( ( $test_status[$j] eq 'true' ) && ( exists $categories{$test_names[$j]} ) && ( $test_codes[$j] =~ m/^[\w]+$/ ) ) {
            $output[$j] = "true";
        }
        else {
  	    next;
        }
    }
    print $examples[$i], "\n";
    print "Output: (", join(", ", @output), ")\n\n";
    @output =();
    $i++;
}

__DATA__
Example 1	codes	A123	B_456	C789	D@1	E123
Example 1	names	electronics	restaurant	electronics	pharmacy	grocery
Example 1	status	true	false	true	true	true
Example 2	codes	Z_9	AB_12	G01	X99	test
Example 2	names	pharmacy	electronics	grocery	electronics	unknown
Example 2	status	true	true	false	true	true
Example 3	codes	_123	123		Coupon_A	Alpha
Example 3	names	restaurant	electronics	electronics	pharmacy	grocery
Example 3	status	true	true	false	true	true
Example 4	codes	ITEM_1	ITEM_2	ITEM_3	ITEM_4
Example 4	names	electronics	electronics	grocery	grocery
Example 4	status	true	true	true	true
Example 5	codes	CAFE_X	ELEC_100	FOOD_1	DRUG_A	ELEC_99
Example 5	names	restaurant	electronics	grocery	pharmacy	electronics
Example 5	status	true	true	true	true	false
