// The Weekly Challenge - 110
// Task 2 Transpose File

import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;
import java.util.ArrayList;

// Usage: java TransposeFile [CSV file]

public class TransposeFile
{
    private static int maxNumOfColOriginally = 1;
    private static int numOfRowOriginally;
    public static void main(String[] args) throws Exception 
    {
        try { 
            File file = new File(args[0]);
            Scanner sc = new Scanner(file);
            ArrayList<ArrayList<String>> original = new ArrayList<>();
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                ArrayList<String> row_in = new ArrayList<>();
                row_in = parse(line.trim());
                original.add(row_in);
            }
            numOfRowOriginally = original.size();

        //For testing  
         /*   System.out.println("Original File:");
            for (ArrayList<String> row : original) { 
                for (String item : row) 
                    System.out.println(item);
                System.out.println("");
            }                    
            System.out.println("original rows num:" + numOfRowOriginally);
            System.out.println("original max col num:" + maxNumOfColOriginally); */

            int maxRow = maxNumOfColOriginally;
            for (int i=0; i < maxRow; i++) {
                if (original.get(0).size() > i )
                    System.out.print(original.get(0).get(i));
                for (int k=1; k < numOfRowOriginally; k++) {
                    if (i < original.get(k).size() )
                        System.out.print("," + original.get(k).get(i));
                    else
                        System.out.print(",");
                }
                System.out.println();
            }
    
        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
            System.exit(0);
        } catch (IndexOutOfBoundsException e) {
            System.out.println("Usage: java TransposeFile [CSV file]");
            System.exit(0);
        } catch (Exception e) {
            System.out.println("Error(s) in input file.");
        }
    }

    private static ArrayList<String> parse(String into)
    {
        ArrayList<String> group = new ArrayList<>();
        String[] pre_group = into.split(",");
        for (int j=0, i = 0; i < pre_group.length; ) {
            j = i;
            String term = pre_group[i];
            if (pre_group[i].startsWith("\"") && !pre_group[i].endsWith("\"") ) {
                do {
                    j = j+1;
                    term += "," + pre_group[j];
                } while (!pre_group[j].endsWith("\"")) ;
                group.add(term);
                i = j+1;
            } else if (pre_group[i].startsWith("\"") && pre_group[i].length() == 1) {
                do {
                    j = j+1;
                    term += "," + pre_group[j];
                } while (!pre_group[j].endsWith("\"")) ;
                group.add(term);
                i = j+1;
            } else {
                group.add(term);
                i = i+1;
            }
        }
        if (maxNumOfColOriginally < group.size())
            maxNumOfColOriginally = group.size(); 
        return group;
    }

}
