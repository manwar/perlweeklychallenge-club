import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class ShortestTimeTest {

  public static int shortestTimeInMinutes(String[] times) {
    int minDiff = 24 * 60; // maximum possible difference in minutes
    for (int i = 0; i < times.length - 1; i++) {
      for (int j = i + 1; j < times.length; j++) {
        String[] parts1 = times[i].split(":");
        String[] parts2 = times[j].split(":");
        int h1 = Integer.parseInt(parts1[0]);
        int m1 = Integer.parseInt(parts1[1]);
        int h2 = Integer.parseInt(parts2[0]);
        int m2 = Integer.parseInt(parts2[1]);
        int diff = Math.abs((h1 - h2) * 60 + (m1 - m2));
        if (diff > 12 * 60) { // account for circular time
          diff = 24 * 60 - diff;
        }
        if (diff < minDiff) {
          minDiff = diff;
        }
      }
    }
    return minDiff;
  }

  @Test
  public void testExample1() {
    String[] times = {"00:00", "23:55", "20:00"};
    assertEquals(5, shortestTimeInMinutes(times));
  }

  @Test
  public void testExample2() {
    String[] times = {"01:01", "00:50", "00:57"};
    assertEquals(4, shortestTimeInMinutes(times));
  }

  @Test
  public void testExample3() {
    String[] times = {"10:10", "09:30", "09:00", "09:55"};
    assertEquals(15, shortestTimeInMinutes(times));
  }
}
