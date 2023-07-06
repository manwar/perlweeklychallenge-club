use strict;
use warnings;

sub can_form_target {
    my ( $source, $target ) = @_;
    my %source_chars = map { $_ => 1 } split //, $source;
    foreach my $char ( split //, $target ) {
        return 0 unless $source_chars{$char}--;
    }
    return 1;
}

print can_form_target( "abc",               "xyz" )  ? "true\n" : "false\n";    # Output: false
print can_form_target( "scriptinglanguage", "perl" ) ? "true\n" : "false\n";    # Output: true
print can_form_target( "aabbcc",            "abc" )  ? "true\n" : "false\n";    # Output: true
