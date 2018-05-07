import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.core.Utils;
import weka.classifiers.*;
import weka.classifiers.functions.*;
import java.util.Random; 
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;

//CrossValidation
//https://weka.wikispaces.com/Generating+cross-validation+folds+(Java+approach)
class Test02WekaOld{

	// n tests
	static final int startSeed  = 4832169;
	static final int runs  = 100;
	static final int folds = 6;

	// type of Classifier
	static final String   classifierName    = "MultilayerPerceptron"; 

	//http://weka.sourceforge.net/doc.stable/weka/classifiers/functions/MultilayerPerceptron.html#MultilayerPerceptron--
	/**
	 -L <learning rate>
	  Learning Rate for the backpropagation algorithm.
	  (Value should be between 0 - 1, Default = 0.3).
	 -M <momentum>
	  Momentum Rate for the backpropagation algorithm.
	  (Value should be between 0 - 1, Default = 0.2).
	 -N <number of epochs>
	  Number of epochs to train through.
	  (Default = 500).
	 -V <percentage size of validation set>
	  Percentage size of validation set to use to terminate
	  training (if this is non zero it can pre-empt num of epochs.
	  (Value should be between 0 - 100, Default = 0).
	 -S <seed>
	  The value used to seed the random number generator
	  (Value should be >= 0 and and a long, Default = 0).
	 -E <threshold for number of consequetive errors>
	  The consequetive number of errors allowed for validation
	  testing before the netwrok terminates.
	  (Value should be > 0, Default = 20).
	 -G
	  GUI will be opened.
	  (Use this to bring up a GUI).
	 -A
	  Autocreation of the network connections will NOT be done.
	  (This will be ignored if -G is NOT set)
	 -B
	  A NominalToBinary filter will NOT automatically be used.
	  (Set this to not use a NominalToBinary filter).
	 -H <comma seperated numbers for nodes on each layer>
	  The hidden layers to be created for the network.
	  (Value should be a list of comma separated Natural 
	  numbers or the letters 'a' = (attribs + classes) / 2, 
	  'i' = attribs, 'o' = classes, 't' = attribs .+ classes)
	  for wildcard values, Default = a).
	 -C
	  Normalizing a numeric class will NOT be done.
	  (Set this to not normalize the class if it's numeric).
	 -I
	  Normalizing the attributes will NOT be done.
	  (Set this to not normalize the attributes).
	 -R
	  Reseting the network will NOT be allowed.
	  (Set this to not allow the network to reset).
	 -D
	  Learning rate decay will occur.
	  (Set this to cause the learning rate to decay).
	**/
	static final String[] classifierOptions = new String[] {
		"-L", "0.3",
		"-H", "6,3"
	}; 
	

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

	public static int tryStrToInt(String str,int default_int){
		try {
			return Integer.parseInt(str);
		} catch ( NumberFormatException e ) {
			//none
		}
		return default_int;
	}

	public static String putAStringAtStartRow(String startRow, String inputRows){
		String output = new String();
		Scanner scanner = new Scanner(inputRows);
		while (scanner.hasNextLine()) output += startRow + scanner.nextLine() + "\n";
		scanner.close();
		return output;
	}

	public static void main(String args[]) throws Exception {	
	
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

		// classifier
		Class<?> classClassifier = Class.forName("weka.classifiers.functions."+classifierName);
		Classifier classifier =  (Classifier)classClassifier.newInstance();
		classifier.setOptions(classifierOptions);
	
		// seed
  	    	int seed  = startSeed - 1;

		// perform cross-validation
		for (int i = 0; i != runs; ++i) {

		  // new random generator
		  seed += 1;
		  Random rand = new Random(seed);

		  //new random data
		  Instances randData = new Instances(data);
		  randData.randomize(rand);
		  if (randData.classAttribute().isNominal()) randData.stratify(folds);
			
		  Evaluation eval = new Evaluation(randData);

		  //train
		  for (int n = 0; n < folds; n++) {

			// gent train set and test set
			Instances train = randData.trainCV(folds, n);
			Instances test = randData.testCV(folds, n);

			// new classifier
			Classifier classifierCopy = null;
			classifierCopy = Classifier.makeCopy(classifier);
			classifierCopy.buildClassifier(train);

			// eval new model
			eval.evaluateModel(classifierCopy, test);
		  }

		  // output evaluation
		  System.out.println();
		  System.out.println("Step " + (i+1) + "/" + runs + " {");
		  System.out.println("\tClassifier: " + classifierName + " " + Utils.joinOptions(classifierOptions));
		  System.out.println("\tDataset: " + data.relationName());
		  System.out.println("\tFolds: " + folds);
		  System.out.println("\tSeed: " + seed);
		  System.out.println("\tCross-validation ( Folds: " + folds + " ) results { ");
		  System.out.println(putAStringAtStartRow("\t\t",eval.toSummaryString("",true)));
		  System.out.println("\t}");
		  System.out.println("}");
		}
	}
}
