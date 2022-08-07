import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collections;

class ReversibleNumber{

	private boolean is_reversible(int x){
		char[] x_chars = String.valueOf(x).toCharArray();
		char[] x_chars_reversed = new char[x_chars.length];
		System.arraycopy(x_chars, 0, x_chars_reversed, 0, x_chars.length);
		ArrayList a = new ArrayList();
		for(int i = 0; i < x_chars_reversed.length; i++)
		    a.add(new Character(x_chars_reversed[i]));
		Collections.reverse(a);
		for(int i = 0; i < x_chars_reversed.length; i++)
		    x_chars_reversed[i] = ((Character)a.get(i)).charValue();
		int sum = Integer.valueOf(new String(x_chars)).intValue() +
		          Integer.valueOf(new String(x_chars_reversed)).intValue();
		char[] sum_chars = String.valueOf(sum).toCharArray();
		for(int i = 0; i < sum_chars.length; i++){
		    if(Integer.valueOf(new String(new char[]{sum_chars[i]})).intValue() % 2 == 0)
		        return false;
		}
		return true;
	}
	
	public ArrayList reversiblesUnderN(int n){
		ArrayList reversibles = new ArrayList();
		do{
			n--;
			if(is_reversible(n))
				reversibles.add(new Integer(n));
		}while(n > 0);
		Collections.reverse(reversibles);
        return reversibles;
    }
	
	public static void main(String[] args){
	    ReversibleNumber reversible = new ReversibleNumber();
	    ArrayList reversibles = reversible.reversiblesUnderN(100);
	    for(int i = 0; i < reversibles.size() - 1; i++){
	        System.out.print(reversibles.get(i) + ", ");
	    }
	    System.out.println(reversibles.get(reversibles.size() - 1));
	}

}