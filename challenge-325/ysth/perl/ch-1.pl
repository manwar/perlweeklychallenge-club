use 5.036;

use Benchmark 'cmpthese';
use File::Slurp 'read_file', 'write_file';
use List::Util 'max';
use Inline 'C';

my $binary_array;
if (@ARGV) {
    $binary_array = [ map $_ eq 1 ? 1 : 0, @ARGV ];
}
else {
    # read or make some data
    my $FILENAME = 'digits.txt';
    my $digits;
    if (-r $FILENAME) {
        chomp($digits = read_file($FILENAME));
    }
    else {
        # a million random 0s and 1s.
        $digits = join "", map int 2*rand, 1..1e6;
        # ignore failure
        eval { write_file($FILENAME, $digits) };
    }
    $binary_array = [ split //, $digits ];
}

my %code = (
    naive_regex => sub { naive_regex($binary_array) },
    better_regex => sub { better_regex($binary_array) },
    loop_sentinel => sub { loop_sentinel($binary_array) },
    loop => sub { loop($binary_array) },
    mapping => sub { mapping($binary_array) },
    one_pass_regex => sub { one_pass_regex($binary_array) },
    inlinec_loop => sub { inlinec_loop($binary_array) },
);

# test first
my $expected = naive_regex($binary_array);
say $expected;
while (my ($name, $sub) = each %code) {
    $sub->($binary_array) == $expected
        or delete $code{$name}, say "$name incorrect\n";
}

cmpthese(-2, \%code);

sub naive_regex ($binary_array) {
    join('', @$binary_array) =~ /(1+)(?!.*?\1)/
        ? length $1
        : 0
}

sub better_regex ($binary_array) {
    join('', @$binary_array) =~ /(?<!1)(1++)(?!.*?\1)/
        ? length $1
        : 0
}

sub one_pass_regex ($binary_array) {
    join('', @$binary_array) =~ /(1++)(?:.*?(*MARK:go)\1(*SKIP:go)(*FAIL)|)/
        ? length $1
        : 0
}

sub loop ($binary_array) {
    my $current_sequence = 0;
    my $longest_sequence = 0;
    for my $value (@$binary_array) {
        if ($value) {
            ++$current_sequence;
        }
        else {
            if ($longest_sequence < $current_sequence) {
                $longest_sequence = $current_sequence;
            }
            $current_sequence = 0;
        }
    }
    if ($longest_sequence < $current_sequence) {
        $longest_sequence = $current_sequence;
    }
    return $longest_sequence;
}

sub loop_sentinel ($binary_array) {
    my $current_sequence = 0;
    my $longest_sequence = 0;
    # slightly simpler code, but at the cost of loading the array onto the stack
    for my $value (@$binary_array, 0) {
        if ($value) {
            ++$current_sequence;
        }
        else {
            if ($longest_sequence < $current_sequence) {
                $longest_sequence = $current_sequence;
            }
            $current_sequence = 0;
        }
    }
    return $longest_sequence;
}

sub mapping ($binary_array) {
    my $count = 0;
    # suppress "Found = in conditional, should be =="
    no warnings 'syntax';
    max( map { $_ ? ++$count : ($count = 0) || () } @$binary_array )
}

__END__
__C__
int inlinec_loop(SV *array) {
    int longest_sequence = 0;
    if (SvROK(array) && SvTYPE(SvRV(array)) == SVt_PVAV) {
        AV *av = (AV *)SvRV(array);
        int max_element = av_len(av);
        int current_sequence = 0;
        for (int i = 0; i <= max_element; ++i) {
            int value = SvIV(*av_fetch(av, i, 0));
            if (value) {
                ++current_sequence;
            }
            else {
                if (longest_sequence < current_sequence) {
                    longest_sequence = current_sequence;
                }
                current_sequence = 0;
            }
        }
        if (longest_sequence < current_sequence) {
            longest_sequence = current_sequence;
        }
    }
    return longest_sequence;
}
