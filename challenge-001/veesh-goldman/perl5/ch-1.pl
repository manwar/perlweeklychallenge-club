my $string = 'Perl Weekly Challenge';
my $count;
$count++ while $string =~ s/e/E/;
print "$count -- $string\n\n";

# throws error: Substitution replacement not terminated
#$_ = 'Perl Weekly Challenge';
#$%++ while s/e/E;
#print "$% -- $_\n\n";

$_ = 'Perl Weekly Challenge';
print y/e/E/," -- $_\n\n";

# cheeky?
#$_ = 'Perl Weekly Challenge';
#print y/e/E/r; die 5;
