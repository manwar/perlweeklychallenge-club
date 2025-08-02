sub split-strings(@words, $separator) {
    # Flatten the split results and remove empty strings
    return flat(@words.map(*.split($separator))).grep(*.chars);
}

# Tests
use Test;
is-deeply split-strings(<one.two.three four.five six>, '.'), <one two three four five six>;
is-deeply split-strings(<$perl$$ $$raku$>, '$'), <perl raku>;

# Sample Outputs
say split-strings(<one.two.three four.five six>, '.').join(",");
say split-strings(<$perl$$ $$raku$>, '$').join(",");
