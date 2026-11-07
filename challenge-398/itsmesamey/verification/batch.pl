use strict;
use warnings;
use JSON::PP ();
use Fcntl qw(O_WRONLY O_CREAT O_EXCL);

# Transport only. The candidate scripts contain all task logic.
die "usage: batch.pl CANDIDATE_DIR\n" unless @ARGV == 1;
my $candidate_dir = $ARGV[0];
require "$candidate_dir/ch-1.pl"; ## no critic (Modules::RequireBarewordIncludes) -- runtime-selected .pl path
require "$candidate_dir/ch-2.pl"; ## no critic (Modules::RequireBarewordIncludes) -- runtime-selected .pl path
my $json = JSON::PP->new->canonical(1)->utf8(1);
sysopen(my $metadata, 'native-metadata.json', O_WRONLY | O_CREAT | O_EXCL)
    or die "cannot create native metadata\n";
print {$metadata} $json->encode({
    perl_version => '' . $^V,
    modules => {
        'Math::BigInt' => '' . Math::BigInt->VERSION,
        'JSON::PP' => '' . JSON::PP->VERSION,
    },
}), "\n";
close($metadata) or die "cannot close native metadata\n";
my %seen;
while (my $line = <STDIN>) {
    die "request line too large\n" if length($line) > 1048576;
    my $request = $json->decode($line);
    die "invalid request envelope\n"
        unless ref($request) eq 'HASH'
        && defined($request->{id}) && !ref($request->{id})
        && defined($request->{task}) && !ref($request->{task})
        && ($request->{task} == 1 || $request->{task} == 2)
        && ref($request->{input}) eq 'ARRAY';
    die "duplicate request id\n" if $seen{$request->{id}}++;
    my $response = {id => $request->{id}, task => 0 + $request->{task}};
    my $answer;
    my $ok = eval {
        $answer = $request->{task} == 1
            ? main::divisible_average(@{$request->{input}})
            : main::string_difference(@{$request->{input}});
        die "candidate returned non-string result\n"
            unless defined($answer) && !ref($answer);
        1;
    };
    if ($ok) {
        # Concatenation ensures the JSON boundary carries decimal text.
        $response->{output} = '' . $answer;
    } else {
        my $error = "$@";
        $error =~ s/\s+\z//;
        $response->{error} = $error;
    }
    print $json->encode($response), "\n";
}
exit 0;

__END__

=head1 NAME

batch.pl - JSON Lines transport for the Weekly Challenge 398 checks

=head1 DESCRIPTION

Load the two supplied Perl scripts and call their public functions for each
JSON request. Preserve task 1 decimal inputs and outputs as strings and report
candidate exceptions as error records. This adapter contains no task algorithm.

Original verification code generated with OpenAI Codex assistance. MIT licensed.

=cut
