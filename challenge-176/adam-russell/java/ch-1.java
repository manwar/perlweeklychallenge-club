import java.util.HashMap;

class PermutedMultiple{

    private static boolean isPermuted(int x, int y){
        char[] x_chars = String.valueOf(x).toCharArray();
        char[] y_chars = String.valueOf(y).toCharArray();
        if(x_chars.length != y_chars.length)
            return false;
        HashMap x_counts = new HashMap();
        HashMap y_counts = new HashMap();
        for(int i = 0; i < x_chars.length; i++){
            Integer c = Integer.valueOf(new String(new char[]{x_chars[i]}));
            if(x_counts.get(c) != null){
                int c_count = ((Integer)x_counts.get(c)).intValue() + 1;
                x_counts.put(c, new Integer(c_count));
            }
           else{
               x_counts.put(c, new Integer(1));
           }     
        }
        for(int i = 0; i < y_chars.length; i++){
            Integer c = Integer.valueOf(new String(new char[]{y_chars[i]}));
            if(y_counts.get(c) != null){
                int c_count = ((Integer)y_counts.get(c)).intValue() + 1;
                y_counts.put(c, new Integer(c_count));
            }
           else{
               y_counts.put(c, new Integer(1));
           }     
        }
        return y_counts.equals(x_counts);
    }

    public static int smallestPermutedMultiple(){
        int x = 0;
        do{
            x++;
        }while(!(isPermuted(x, 2*x) && isPermuted(2*x, 3*x) && isPermuted(3*x, 4*x) &&
                 isPermuted(4*x, 5*x) && isPermuted(5*x, 6*x)));
        return x;
    }

    public static void main(String[] args){
        System.out.println(smallestPermutedMultiple());
    }

}