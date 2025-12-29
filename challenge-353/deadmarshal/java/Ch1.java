import java.util.Arrays;
import java.util.Comparator;

int max_words(String[] arr) {
  return Arrays.stream(arr)
    .map(s -> s.split("\\s+").length)
    .max(Comparator.naturalOrder())
    .orElse(0);
}

void main() {
  IO.println(max_words(new String[]{"Hello world",
    "This is a test","Perl is great"}));
  IO.println(max_words(new String[]{"Single"}));
  IO.println(max_words(new String[]{"Short",
    "This sentence has six words in total",
    "A B C",
    "Just four words here"}));
  IO.println(max_words(new String[]{"One","Two parts","Three part phrase",""}));
  IO.println(max_words(new String[]{"The quick brown fox jumps over the lazy dog",
    "A",
    "She sells seashells by the seashore",
    "To be or not to be that is the question"}));
}
