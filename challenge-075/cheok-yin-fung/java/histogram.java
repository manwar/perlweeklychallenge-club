import java.util.Scanner;

// not yet produce the "image" of histogram, 25th Aug

public class histogram {
    static public void main(String[] args) {
        int maxarea = 0;
    //    int[] A = new int[] {3, 2, 3, 5, 7, 5};
      //  int[] A = new int[] {2, 1, 4, 5, 3, 7};
     //   int[] A = new int[] {1, 2, 3, 4, 5};
        Scanner scn = new Scanner(System.in);
        System.out.println("Input number of items of the histogram:");
        int size = scn.nextInt();
        int[] A = new int[size];
        System.out.println("Input items of the histogram:");
        for (int k = 0; k < size; k++) {
            A[k] = scn.nextInt();
        }
        for (int winsize = 1; winsize <= A.length; winsize++) {
            for (int i = 0; i+winsize-1 < A.length; i++) {
                int area;
                int minele = 128;
                int[] Baby = new int[winsize];
                for (int j = 0; j < winsize; j++) {
                    Baby[j] = A[i+j];
                    if (Baby[j] < minele) {
                        minele = Baby[j];
                    }
                }
                area = winsize*minele;
//         the followings need import java.util.Arrays and java.util.Collections
//                List b = arrays.asList(ArrayUtils.toObject(Baby));  
//                area = winsize*(Collections.min(b));
                if (area>maxarea) {
                    maxarea = area;
                }
            }
        }
        System.out.println(maxarea);

    }
}


// references:
// https://stackoverflow.com/questions/2795350/how-to-put-a-scanner-input-into-an-array-for-example-a-couple-of-numbers
// https://stackoverflow.com/questions/1484347/finding-the-max-min-value-in-an-array-of-primitives-using-java
