use v5.36;

sub has_only_odd_digits           ( $N ) { !grep { ($_ % 2)==0 } split '', $N }
sub sum_of_number_and_its_reverse ( $N ) { $N + scalar reverse $N             }
sub is_reversable ( $N ) {
    return has_only_odd_digits sum_of_number_and_its_reverse $N;
}

say join ',', grep { is_reversable $_} 1..99;

# Three alternative approaches, all based on analyis that is only valid for 2-digits:
# (See blog post for the analysis.)
#
#
# use List::Util qw<sum>;
# say join ',', grep { my $s = sum split ''; $s % 2 and $s <= 9 } 10..99;
#
#
# Via decomposition of the odd multiples of 11:
# use ntheory qw<forpart>;
# my @r;
# sub collect { push @r, join('', @_), join('', reverse @_) }
# for my $odd ( 1, 3, 5, 7, 9 ) {
#     push @r, $odd . '0';
#     forpart \&collect, $odd, { n => 2 };
# }
# say join ',', sort @r;
#
#
# Correct for 2-digit, but no longer comprehensible:
# say join ',', sort map {
#     my $N = $_;
#     map { 9 * $_ + $N } 1 .. $N;
# } 1, 3, 5, 7, 9;
