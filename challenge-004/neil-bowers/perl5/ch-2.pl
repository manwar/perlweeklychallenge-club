use File::Slurper qw/ read_lines /;

my $word_file       = '/Users/neilb/lib/lexicon.txt';
my $input_signature = signature($ARGV[0]);

print join("\n", grep { signature($_) eq $input_signature } read_lines($word_file)), "\n";

sub signature
{
    return join('', sort split('', $_[0]))
}
