use Modern::Perl;
use List::Util qw<uniq head>;
use List::Lazy qw<lazy_list>;
use ntheory    qw<is_prime>;

my $Padovan = lazy_list {
    push  @$_, $_->[-2] + $_->[-3];
    shift @$_;
} [1, 1, 1];

my $prime_pad = $Padovan->grep( sub { is_prime($_) } );

say join ', ', uniq $prime_pad->next(11);
