my $N = 4;
my @gray-code = <0 1>;

for 2..$N -> $i {
    my @rev-gray-code = @gray-code.reverse;
    @gray-code = @gray-code.map: { "0$_" };
    @rev-gray-code = @rev-gray-code.map: { "1$_" };
    @gray-code.append: @rev-gray-code;
}

@gray-code .= map: { :2($_) };
say @gray-code.join(', ');
