import java.util.Arrays;
import java.util.Iterator;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

class Abecedarian{
    static final String FILENAME = "dictionary"; 
    private String filename;

    public Abecedarian(String _filename){
        this.filename = _filename;
    }
    
    public ArrayList abecedarians(){
        ArrayList abecedarians = new ArrayList();
        String line;
        try{
            InputStreamReader isr = new InputStreamReader(new FileInputStream(this.filename));
            BufferedReader br = new BufferedReader(isr);
            while((line = br.readLine()) != null){
                char[] chars = line.trim().toCharArray();
                Arrays.sort(chars);
                if(new String(chars).equals(line.trim())){
                    abecedarians.add(line.trim());
                }
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return abecedarians;
    }

    public static void main(String[] args){
        Abecedarian abc = new Abecedarian(FILENAME);
        Iterator iter = abc.abecedarians().iterator();
        while(iter.hasNext()){
            String s = (String) iter.next();
            System.out.println(s);
        }
    }
}