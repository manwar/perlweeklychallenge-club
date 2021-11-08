package main

import "core:fmt"
import "core:os"
import "core:strconv"

main :: proc() {
    n, _ := strconv.parse_uint(os.args[1], 10);
    fmt.println(n & 0x55 << 1 | n & 0xAA >> 1);
}
