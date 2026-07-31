import std.stdio;
import std.string;
import std.utf;
import std.range;
import std.algorithm.searching;
import std.conv;

string[] specialBinarySubstrings(string b) {
  string[] res;
  dchar[] chars = b.dup.to!(dchar[]);
  foreach(pos; 0..chars.length) {
    foreach(length; 2..chars.length - pos + 1) {
      string sub = cast(string)std.utf.toUTF8(chars[pos..pos+length]);
      if(!sub.canFind("01") && !sub.canFind("10")) continue;
      int idx = -1;
      for(int i = 1; i < sub.length; i++) {
        if(sub[i] != sub[i-1]) {
          idx = i;
          break;
        }
      }
      if(idx == -1) continue;
      if(sub[0..idx].length == sub[idx..$].length) res ~= sub;
    }
  }
  return res;
}

void main() {
  writeln(specialBinarySubstrings("0101"));
  writeln(specialBinarySubstrings("000111"));
  writeln(specialBinarySubstrings("000011"));
  writeln(specialBinarySubstrings("10011100"));
  writeln(specialBinarySubstrings("00000"));
}
