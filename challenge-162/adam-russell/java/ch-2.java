import java.util.*;

class Playfair {
    private final String ALPHABET = "abcdefghiklmnopqrstuvwxyz";
    private final String KEY = "playfair example";
    private char[][] matrix;
    
	private String removeDuplicates(String s){
	    char[] chars = s.toCharArray();
        ArrayList al = new ArrayList();
        for(int i = 0; i < chars.length; i++){
            Character c = new Character(chars[i]);
            if(al.indexOf(c) == -1){
                al.add(c);
            }
        }
        int j = 0;
		Iterator iter = al.iterator();
		char[] deduplicated = new char[al.size()];
		while(iter.hasNext()){
		    Character c = (Character) iter.next();
		    deduplicated[j] = c.charValue();
		    j++;
		}
		return new String(deduplicated);
	}

	private String prepareText(String plainText){
	    char c;
		String s = "";
		plainText = plainText.replaceAll(" ", "");
		for(int i = 0; i < plainText.length(); i++) {
			c = plainText.charAt(i);
			s += plainText.charAt(i);
			if(i < plainText.length() - 1){
				if(plainText.charAt(i) == plainText.charAt(i + 1)){
					s += "x";
				}
			}
		}
		if(s.length() % 2 != 0)
			s += "x";
		return s;
	}

	private int[] findIJ(char a, char b){
		int[] y = new int[4];
		if(a == 'j'){
			a = 'i';
		}
		else if(b == 'j'){
			b = 'i';
		}
		for(int i = 0; i < 5; i++){
			for(int j = 0; j < 5; j++){
				if(this.matrix[i][j] == a){
					y[0] = i;
					y[1] = j;
				}
				else if(this.matrix[i][j] == b){
					y[2] = i;
					y[3] = j;
				}
			}
		}
		if(y[0] == y[2]){
			y[1] += 1;
			y[3] += 1;
		}
		else if(y[1] == y[3]){
			y[0] += 1;
			y[2] += 1;
		}
		for(int i = 0; i < 4; i++){
			y[i] %= 5;
		}
		return y;
	}

    public Playfair(){
		String key = removeDuplicates(this.KEY);
		char[] c = this.ALPHABET.toCharArray();
		char[] ch = key.replaceAll(" ", "").toCharArray();
        for(int i = 0; i < c.length; i++) { 
            for(int j = 0; j < ch.length; j++){ 
                if(c[i] == ch[j]){ 
                    c[i] = ' ';
                }
            }
        } 
        String alphabet = new String(c);
        alphabet = alphabet.replaceAll(" ", "");
		char[] chars = key.replaceAll(" ", "").toCharArray();
		char[] letters = alphabet.toCharArray();
		this.matrix = new char[5][5];
		int indexOfAlphabet = 0, indexOfKey = 0;
		for(int i = 0; i < 5; i++) {
			for(int j = 0; j < 5; j++) {
				if(indexOfKey < key.replaceAll(" ", "").length()){
					this.matrix[i][j] = chars[indexOfKey++];
				}
				else{
					this.matrix[i][j] = letters[indexOfAlphabet++];
				}
			}
		}
    }

	public String encrypt(String plainText){
	    plainText = prepareText(plainText);
		char ch[] = plainText.toCharArray();
		int a[] = new int[4];
		for(int i = 0; i < plainText.length(); i += 2) {
			if(i < plainText.length() - 1) {
				a = findIJ(plainText.charAt(i), plainText.charAt(i + 1));
				if(a[0] == a[2]){
					ch[i] = this.matrix[a[0]][a[1]];
					ch[i + 1] = this.matrix[a[0]][a[3]];
				}
				else if(a[1] == a[3]){
					ch[i] = this.matrix[a[0]][a[1]];
					ch[i + 1] = this.matrix[a[2]][a[1]];
				}
				else{
					ch[i] = this.matrix[a[0]][a[3]];
					ch[i + 1] = this.matrix[a[2]][a[1]];
				}
			}
		}
		return new String(ch);
	}

	public static void main(String[] args){
		String plainText = "hide the gold in the tree stump";
		Playfair cypher = new Playfair();
		String encoded = cypher.encrypt(plainText);
		System.out.println(encoded);
	}
}
