 import weka.core.Instances;
 import java.io.BufferedReader;
 import java.io.FileReader;

public class Test01 {

	public static Instances readWekaFile(String file){
			// ref to instances
			Instances data = null;
			try {
				BufferedReader reader = new BufferedReader(new FileReader(file));
				data = new Instances(reader);
				reader.close();
			} catch ( Exception e ) {
				//none
			} finally {
				return data;
			}

	}

	public static String wekaTypeToString(int type)	{
		switch(type) {
			case 0:  return "numeric";
			case 1:  return "nominal";
			case 2:  return "string";
			case 3:  return "date";
			case 4:  return "relational";
			default: return "unknow";
		}
	}

	public static int tryStrToInt(String str,int default_int){
			try {
				return Integer.parseInt(str);
			} catch ( NumberFormatException e ) {
				//none
			}
			return default_int;
	}

	public static void main(String[] args){
			// get name of input file
			if( args.length < 2 ) return;
			// read a  weka file
			Instances data = readWekaFile(args[1]);
			// test
			if ( data == null ) return;
			// set class index
			if (data.classIndex() == -1) {
			    if( args.length > 2 ) data.setClassIndex(tryStrToInt(args[2], data.numAttributes() - 1));
				else   			      data.setClassIndex(data.numAttributes() - 1);
			}
			// print info
			System.out.println("File name: " + args[1] + " {");
			System.out.println("\tAttributes: {");
			for(int i=0;  data.numAttributes()!=i ;++i) {
				System.out.println("\t\ttype(attribute["+i+"]) -> " + wekaTypeToString(data.attribute(i).type()));
			}
			System.out.println("\t}");
			System.out.println("\tlen(Classes) -> " + data.numClasses());
			System.out.println("\tlen(Instances) -> " + data.numInstances());
			System.out.println("}");
	}

}
