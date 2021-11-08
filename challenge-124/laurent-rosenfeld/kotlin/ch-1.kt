fun main() {
    val lines = arrayOf("   ^^^^^", "  ^     ^",
        " ^       ^", "^         ^",  "     ^");

    for (i in arrayOf(0, 1, 2, 3, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4)) {
        println(lines[i]);
    }
}
