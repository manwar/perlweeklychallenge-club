use strict;
use warnings;
use List::Util qw(shuffle);

sub secret_santa {
    my (@names) = @_;
    my %family_map;
    my %assignments;

    # Extract family names and map them
    foreach my $name (@names) {
        my ($family_name) = $name =~ /(\w+)$/;
        push @{ $family_map{$family_name} }, $name;
    }

    while (1) {
        my @shuffled = shuffle(@names);
        %assignments = ();
        for my $i ( 0 .. $#names ) {
            my $giver    = $names[$i];
            my $receiver = $shuffled[$i];
            $assignments{$giver} = $receiver;
            last if ( $giver =~ /(\w+)$/ )[0] eq ( $receiver =~ /(\w+)$/ )[0];
        }
        return \%assignments if keys(%assignments) == @names;
    }
}

# Test and Output
my @names    = ( 'Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross' );
my $assigned = secret_santa(@names);

while ( my ( $giver, $receiver ) = each %$assigned ) {
    print "$giver -> $receiver\n";
}
