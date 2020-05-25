# Test: perl6 ch-1.p6 -u
use Getopt::Long;
get-options("u" => my $unique);

# Hash to store unique emails
my %unique_emails;

sub MAIN() {
    # Data
    my @data = qw /
    	name@example.org
    	rjt@cpan.org
    	Name@example.org
    	rjt@CPAN.org
    	user@alpha.example.org
    /;

    my @sorted_data = @data.sort(&by-domain);
    @sorted_data = @sorted_data.grep(&make-unique)
    	if ($unique);

    say @sorted_data.join("\n");
}

# Check if the email is unique
sub make-unique(Str $email)  {
    my ($user, $domain) = split-email($email);
    my $unique_email = $user ~ '@' ~ $domain.lc;

    return False
    	if (%unique_emails{$unique_email});

    %unique_emails{$unique_email} = 1;
    return True;
}

# Sort by domain function
sub by-domain {
    my ($user_a, $domain_a) = split-email($^a);
    my ($user_b, $domain_b) = split-email($^b);
    $domain_a.lc cmp $domain_b.lc or
    $user_a      cmp $user_b;
}

# Split email into username and domain
sub split-email(Str $email) {
    return $email.split('@');
}
