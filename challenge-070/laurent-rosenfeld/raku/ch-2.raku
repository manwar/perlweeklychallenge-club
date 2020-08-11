use v6;
my @gray = [0], [0, 1]; # No need to have [1, 2, 4, 3] here

sub next-gray (Int $in) {
    my $fmt = "%0" ~ $in ~ "s"; # build the formatting string
    my @s1 = map { .fmt('%b').fmt($fmt) }, | @gray[$in];
    my @s2 = reverse map { '1' ~ $_ }, @s1;
    @s1 = map { '0' ~ $_ }, @s1;
    my @gray-seq = |@s1, |@s2;
    my @result = map { .parse-base(2) },  @gray-seq;
}

sub MAIN ($n where 1 <= * <= 5) { # we can start at 1
    for 1..^$n -> $i {
        @gray[$i+1] = next-gray $i;
    }
    say @gray[$n];
    say @gray;
}
