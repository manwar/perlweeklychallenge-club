const std = @import("std");
const File = std.fs.File;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const argv = std.os.argv;

    const file = try switch (argv.len) {
        1 => std.io.getStdIn(),
        2 => try std.fs.cwd().openFileZ(argv[1], File.OpenFlags{}),
        else => error.InvalidArguments,
    };
    defer file.close();

    try stdout.print("{}\n", .{try findMissing(&file)});
}

fn findMissing(file: *const File) !u32 {
    const in = file.reader();
    var buf: [10]u8 = undefined;

    var min: u32 = std.math.maxInt(u32);
    var max: u32 = 0;
    var sum: u32 = 0;

    while (try in.readUntilDelimiterOrEof(buf[0..], ',')) |number| {
        var n = try std.fmt.parseInt(u32, number, 10);
        sum += n;
        if (n < min) min = n;
        if (n > max) max = n;

        try in.skipUntilDelimiterOrEof('\n');
    }

    const sumWithoutMissing = @divExact((max - min + 1) * (max + min), 2);
    return sumWithoutMissing - sum;
}
