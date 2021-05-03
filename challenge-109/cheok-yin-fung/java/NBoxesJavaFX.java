// The Weekly Challenge - 109
// Task 2 Four Squares(Rectangles) Puzzle
// Run with Box.java and Point.java
// JavaFX Usage may refer to https://github.com/openjfx/samples/tree/master/HelloFX
// Coding References:
// https://www.tutorialspoint.com/how-to-create-a-rectangle-using-javafx
// https://www.javatpoint.com/javafx-text

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.BitSet;


// JavaFX /*

import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.*;

// */ JavaFX 

public class NBoxesJavaFX extends Application
// public class NBoxesJavaFX   // for non-JavaFX
{

       static Box[] box = new Box[] { 
             new Box( new Point(9,6), new Point(24,15) ),
             new Box( new Point(20,10), new Point(35,19) ),
             new Box( new Point(31,6), new Point(46,15) ),
             new Box( new Point(42,10), new Point(56,19) )
        };

       static Point[] point = new Point[] {
            new Point(16,8),  //a
            new Point(22,12), //b
            new Point(28,16), //c
            new Point(33,12), //d
            new Point(38,8),  //e
            new Point(44,12), //f
            new Point(49,16)  //g
        };

    public static final int N = box.length;
    public static final int M = point.length;

    public static int[] oneOfAns = new int[M];
    public static ArrayList<int[]> finalAnswers = new ArrayList<>();

// ========== BEGIN: functions for permutations ==================
    public static ArrayList<Integer> copy(ArrayList<Integer> val)
    {
        ArrayList<Integer> a = new ArrayList<>();
        for (int i=0; i < val.size(); i++) {
            a.add(Integer.valueOf(val.get(i)));
        }
        return a;
    }

    public static ArrayList<int[]> permutations(int[] values)
    {
        int m = values.length;
        ArrayList<ArrayList<Integer>> arr = new ArrayList<>();
        ArrayList<Integer> temp = new ArrayList<>();
        temp.add(Integer.valueOf(values[0]));
        arr.add(temp);
        for (int i = 2; i <= m; i++) {
            int cp = arr.size();
            for (int c=0; c < i-1; c++) 
                for (int d=0; d < cp; d++) {
                    arr.add( copy( arr.get(d)  ) );
                }
            int count = 0;
            int parameter = arr.size()/i;
            for (int k=0; k < i ; k++) {
                for (int c = 0; c < parameter; c++) {
                   ArrayList<Integer> item = arr.get(count);
                   item.add(k, Integer.valueOf(values[i-1]));
                   count++;
                }
            }
            
        }
        
        ArrayList<int[]> ans = new ArrayList<>();
        Iterator<ArrayList<Integer>> i_arr = arr.iterator();
        while (i_arr.hasNext()) {
            ans.add(toIntArray( i_arr.next() ));
        }
        return ans;
    }

    public static int[] toIntArray (ArrayList<Integer> sth) {
        int[] ans = new int[sth.size()];
        for (int i = 0; i < sth.size(); i++ )
            ans[i] = sth.get(i);
        return ans;
    }

// =========== END: functions for permutations ==================

// =========== BEGIN: functions for JavaFX ========================
// /*
    public void start(Stage stage) 
    {
      Group group = new Group();
      
      Rectangle[] shape = new Rectangle[N];
        for (int i=0; i<N; i++) {
            shape[i] = new Rectangle();
            shape[i].setX(box[i].topLeft().x()*15.0);
            shape[i].setY(box[i].topLeft().y()*15.0);
            shape[i].setWidth((box[i].width()+5)*15.0);
            shape[i].setHeight(box[i].height()*15.0);
            shape[i].setFill(Color.TRANSPARENT);
            shape[i].setStrokeWidth(1.0);
            shape[i].setStroke(Color.DARKSLATEGREY);  
            group.getChildren().add(shape[i]);
        }

        Text[] text = new Text[M];
        Font font = Font.font("verdana", FontWeight.BOLD, FontPosture.REGULAR, 15); 
        for (int j=0; j<M; j++) {
            text[j] = new Text();
            text[j].setFont(font);
            text[j].setX(point[j].x()*15.0);
            text[j].setY(point[j].y()*15.0);
            text[j].setText(Integer.toString(oneOfAns[j]));
            group.getChildren().add(text[j]);
        } 

      Scene scene = new Scene(group, 1000, 600, Color.WHITE);
      stage.setTitle("One of the Solutions for the N-Boxes");
      stage.setScene(scene);
      stage.show();
    }

    public static void printing() 
    {
        launch(); 
    }
// */
// =========== END: functions for JavaFX ========================

    public static void main(String... args)
    {

        
        BitSet[] board = new BitSet[N];  

        for (int i=0; i<N; i++) {
            board[i] = new BitSet(M);
            for (int j=0; j<M; j++) 
                board[i].set( j, box[i].isEnclosed(point[j]) );
        }        

        ArrayList<int[]> p = permutations(new int[] {1,2,3,4,5,6,7});

        

        Iterator<int[]> i_p = p.iterator();
        while (i_p.hasNext()) {
            int[] now = i_p.next();

            boolean consistency = true;
            int sum = 0;
            for (int j=0; j<M; j++)
                if (board[0].get(j)) 
                    sum += now[j];

            for (int i=1; consistency && i<N; i++) {
                int currentSum = 0;
                for (int j=0; j<M; j++)
                    if (board[i].get(j)) 
                        currentSum += now[j];
                consistency = sum == currentSum;
            }

            if (consistency) {
                finalAnswers.add(now);
            }             
        }

        System.out.println("Number of solution(s): " + finalAnswers.size());
        if (finalAnswers.size() != 0) {
            System.out.println("|a, b, c, d, e, f, g|\n");
            for (int[] term: finalAnswers )
            {
                System.out.println(Arrays.toString(term));
            } 
            oneOfAns = finalAnswers.get((int)(Math.random()*finalAnswers.size()) );
            printing();   // JavaFX
        }
    }
}
