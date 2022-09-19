void main() {
  print('|    n | F(n) | M(n) |\n${"".padRight(22, "-")}');
  for (int n = 0; n <= 20; n++) {
    print(
        '| ${n.toString().padLeft(4, " ")} | ${female(n).toString().padLeft(4, " ")} | ${male(n).toString().padLeft(4, " ")} |');
  }
}

int female(int n) {
  if (n == 0) {
    return 1;
  }
  return n - male(female(n - 1));
}

int male(int n) {
  if (n == 0) {
    return 0;
  }
  return n - female(male(n - 1));
}
