import java.util.concurrent.*;

public class SleepSort {
  public static void main(String[] args) throws InterruptedException {
    int[] nums = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
    ExecutorService executor = Executors.newCachedThreadPool();

    CountDownLatch latch = new CountDownLatch(nums.length);
    for (final int num : nums) {
      executor.execute(() -> {
        try {
          TimeUnit.SECONDS.sleep(num);
          System.out.print(num + " ");
        } catch (InterruptedException e) {
          Thread.currentThread().interrupt();
        } finally {
          latch.countDown();
        }
      });
    }

    latch.await();
    executor.shutdown();
  }
}
