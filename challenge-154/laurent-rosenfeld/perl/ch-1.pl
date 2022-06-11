use strict;
use warnings;
use feature "say";

my @permutations;
my %given_perm = map { $_ => 1 } qw/
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP /;

sub permute {
    my ($str, @vals) = @_;
    if (scalar @vals == 0) {
        push @permutations, $str;
        return;
    }
    permute("$str" . $vals[$_], @vals[0..$_-1],
        @vals[$_+1..$#vals]) for 0..$#vals;
}
permute "", split //, (keys %given_perm)[0];
for my $perm (@permutations) {
    say "$perm is missing" unless exists $given_perm{$perm};
}
