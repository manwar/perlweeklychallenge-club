use v5.38;

sub proc($a, $b) {
    my @a = @$a;
    my @b = @$b;
    say "Input:  \@array1 = (@a),\n\t\@array2 = (@b)";
    my (%a, %b);
    foreach (@a) {$a{$_}++;}
    foreach (@b) {$b{$_}++;}
    foreach my $key (keys %a) {
	$b{$key} = 0 unless ($b{$key});
    }
    my $cnt = 0;
    for my $key (keys %a) {
	next if ($a{$key} != 1);
	$cnt++ if ($b{$key} == 1);
    }
    say "Output: $cnt\n";
}

my @array1 = qw( apple banana cherry );
my @array2 = qw( banana cherry date);
proc(\@array1, \@array2);
@array1 = qw( a ab abc );
@array2 = qw( a a ab abc);
proc(\@array1, \@array2);
@array1 = qw/ orange lemon/;
@array2 = qw/ grape melon/;
proc(\@array1, \@array2);
@array1 = qw| test test demo|;
@array2 = qw| test demo demo|;
proc(\@array1, \@array2);
@array1 = qw[ Hello world ];
@array2 = qw[ hello world ];
proc(\@array1, \@array2);
