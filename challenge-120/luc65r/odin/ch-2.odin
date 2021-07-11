package main

import "core:fmt"
import "core:os"
import "core:strconv"

main :: proc() {
    h, _ := strconv.parse_uint(os.args[1][:2], 10);
    m, _ := strconv.parse_uint(os.args[1][3:5], 10);
    d := abs(f64(h % 12) - f64(m) * 11 / 60);
    fmt.printf("%.0f°\n", min(d, 12 - d) * 30);
}
