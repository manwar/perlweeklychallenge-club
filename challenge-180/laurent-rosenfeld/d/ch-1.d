import std.stdio;
import std.array;

void main() {
    string[] tests = [ "Perl Weekly Challenge", "Long Live Perl" ];
    foreach(test; tests) {
        int[string] histo;
        string[] chars = test.split("");
        foreach (ch; chars) {
            histo[ch]++;
        }
        for (int i = 0; i < chars.length; i++) {
            if (histo[chars[i]] == 1) {
                writeln(test, ": ", i);
                break;
            }
        }
    }
}
