void main(List<String> args) {
  final int lw =
      args.isNotEmpty && int.tryParse(args[0]) != null ? int.parse(args[0]) : 0;
  final input =
      '''Write a script that can wrap the given paragraph at a specified column using the greedy algorithm.''';
  //Iterable<Match> matches = RegExp(r'(.+?(?:\s|\n|$))').allMatches(input);
  final Iterable<Match> matches = RegExp(r'\S+').allMatches(input);
  var buf = StringBuffer();
  var sl = lw;
  for (final Match m in matches) {
    String w = m[0]!;
    if (w.length + 1 > sl) {
      /*
      if (buf.isNotEmpty) {
        print(buf);
      }
      buf.clear();
      buf.write(w);
      */
      /**/
      if (buf.isNotEmpty) {
        buf.write('\n');
      }
      buf.write(w);
      /**/
      sl = lw - w.length;
    } else {
      if (buf.isNotEmpty) {
        buf.write(' ');
        sl--;
      }
      buf.write(w);
      sl -= w.length;
    }
  }
  print(buf);
}
