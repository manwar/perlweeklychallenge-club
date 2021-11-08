lines := list("   *****", "  *     *", " *       *", "*         *", "     *", "")
indexes := list(0, 1, 2, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4, 5)
for (i, 0, 17, lines at(indexes at(i)) println)
