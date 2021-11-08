var lines = [ "   ^^^^^", "  ^     ^",
                         " ^       ^", "^         ^",
                         "     ^"];
var indexes = [ 0, 1, 2, 3, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4 ];

void main() {
    for (int i = 0; i < 18; i++ ) {
        print(lines[indexes[i]]);
    }
}
