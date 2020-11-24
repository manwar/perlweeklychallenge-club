my @directions = [
    [ 1, 0],  # →
    [ 0, 1],  # ↓
    [-1, 0],  # ←
    [ 0,-1],  # ↑
];

sub turn ($curdir is rw, @boundary) of Nil  { # ⤵
    @boundary[$curdir] += ($curdir == 0|3) ?? 1 !! -1;
    $curdir = ($curdir + 1) % 4;
    return;
}

sub next-step (@cursor, $curdir) {
    @cursor >>+<< @directions[$curdir];
}

sub inside-boundary(@cursor, @boundary) of Bool {
    return ((@boundary[3] < @cursor[0] < @boundary[1])
            and (@boundary[0] < @cursor[1] < @boundary[2]));
}

sub spiral-matrix (@M) {
    my $width = @M[0].elems;
    my $height = @M.elems;
    my @cursor = [0,0];

    # The index here is arranged in thee way to make it easier to implement turn().
    my $curdir = 0;
    my @boundary = [
        -1,      # ↑
        $width,  # →
        $height, # ↓
        -1,      # ←
    ];

    my @spiral;
    while inside-boundary(@cursor, @boundary) {
        @spiral.push(@M[@cursor[1]][@cursor[0]]);

        my @next = next-step(@cursor, $curdir);
        unless inside-boundary(@next, @boundary) {
            turn($curdir, @boundary);
            @next = next-step(@cursor, $curdir);
        }

        @cursor = @next;
    }

    return @spiral;
}

sub print-matrix(@matrix) {
    for ^@matrix -> $y {
        say "[" ~ @matrix[$y].map(-> $it { sprintf("%2d", $it) }).join(" ") ~ "]";
    }
}

my @examples = (
    [[1,2],
     [3,4]],
    [[1,2,3],
     [4,5,6]],
    [[1,2,3],
     [4,5,6],
     [7,8,9]],
    [[1,2,3],
     [4,5,6],
     [7,8,9],
     [10,11,12],],
);

for @examples -> @M {
    say "----\nInput: ";
    print-matrix(@M);
    say "Output: " ~ spiral-matrix(@M).gist;
}
