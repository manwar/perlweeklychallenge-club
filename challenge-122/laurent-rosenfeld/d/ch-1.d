import std.stdio;
import std.math;
import std.conv;

void main(string[] args) {
    int avg = std.conv.to!int(args[1]);
    printf ("%d ", avg);
    for (int i = 1; i < args.length - 1; i++) {
        avg = (avg * i + std.conv.to!int(args[i+1])) / (i + 1);
        printf("%3d ", avg);
    }
    printf("\n");
}
