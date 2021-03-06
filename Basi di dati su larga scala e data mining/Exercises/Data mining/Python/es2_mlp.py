
# Import datasets, classifiers and performance metrics
from sklearn import datasets, neural_network, metrics, model_selection, utils

dataset = datasets.fetch_mldata("iris")

n_samples = len(dataset.data)
X = dataset.data
Y = dataset.target # labels

# Perturbation (data may be ordered)
random_state = utils.check_random_state(0)
permutation = random_state.permutation(X.shape[0])
X=X[permutation]
Y=Y[permutation]

# Create a classifier (neural network)
train_size = int(n_samples*0.75)
# divides the dataset into training and testing sets
X_train, X_test, Y_train, Y_test = model_selection.train_test_split(X, Y, train_size=train_size, test_size=n_samples-train_size)

classifier = neural_network.MLPClassifier(solver='adam', max_iter=500, hidden_layer_sizes=(30,30), activation='relu', random_state=1, shuffle=True, verbose=False) # MLP = Multi Layer Perceptron
classifier.fit(X_train,  Y_train)   # training

predicted = classifier.predict(X_test)

report = "Classification report for classifier {}:\n{}\n".format(classifier, metrics.classification_report(Y_test, predicted))
print(report)
cmatrix = "Confusion matrix\n{}".format(metrics.confusion_matrix(Y_test, predicted))
print(cmatrix)

# Cross validation
score = model_selection.cross_val_score(classifier, X, Y, cv=5) # divides into fifths
print("\nCross validation score: {}".format(score))
