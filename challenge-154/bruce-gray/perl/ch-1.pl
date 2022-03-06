use Modern::Perl;
use List::Permutor;

my @in = qw<
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP
>;
my %in_set = map { $_ => 1 } @in;

my $permutor = List::Permutor->new( split '', $in[0] );

while ( my @letters = $permutor->next() ) {
    my $word = join '', @letters;
    say $word if not $in_set{$word};
}
