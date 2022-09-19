class IntSample does Associative {
    has @!data;
    submethod BUILD(:@data) {
        @!data = sort @data;
    }
    method AT-KEY($scale) {
        given $scale {
            when Whatever { @!data[@!data - 1] }
            when WhateverCode { @!data[.(@!data - 1)] }
            when Int { @!data[$_] }
            when * %% 0.5 { (.[$scale.floor] + .[$scale.ceiling]) / 2 given @!data }
            default { @!data[.round] }
        }
    }
    
}

say IntSample.new(data => $*IN.lines>>.Int){0,*/4,*/2,* * 3/4, *}
