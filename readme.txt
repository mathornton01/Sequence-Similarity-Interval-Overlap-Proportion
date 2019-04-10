Biosequence Transition Probability Similarity Scoring Software
By Micah


If you would like to estimate the sequence similarity and produce hierarchical dendrograms of orgnisms based on 
the number of overlapping confidence intervals then you should run the following code, please find some detailed 
descriptions of what is being done below: 

Step 0 (coming soon): Setting parameters for the lexical scanner (ie how many probabilites to compute etc...). 


Step 1: Compiling the Lexical Scanner with flex/lex

---> There should be a file called 16transitionprobestimator.lex - this is a lexical scanner that counts the single base pair transitions. 
---> You need to compile this file into an executable for your specific architecture, to do this you will need either lex or the modern flex. 
---> run the command:  "lex 16probestimator.lex" to produce the c-code for the lexical scanner: lex.yy.c. 
---> You need to compile the c code into an executable file using a c-compiler for your distribution, on linux you can do "gcc lex.yy.c"
---> You should produce an output file a.out (or named if you so choose with the -o flag on the gcc call). 

Step 2:  Running the lexical scanner and capturing output. 

---> once the executable is created sequences may be scanned and transition probabilities estimated. 
---> consider the files representing the MTHFR encoding gene in seven different species in the dat.tgz file. 
--------> These files contain rows with 36 characters that are ACGT, we need to remove the newlines \n to analyze them with the scanner. 
--------> on Linux and probably Mac OSx this is trivial using the tr utility.  as expressed in the getProbs script, which generates the 
--------> probabilities for all seven of the MTHFR files using the lines "cat dat/mthfr*****.seq | tr -d '\n' | ./a.out >> tmp1234.txt"
--------> This line concatenates the data in the .seq file to the input of the translate utility, with a -d (delete) flag indicating that all 
--------> newline characters '\n' are to be deleted, then pipe the results into the input of the lexical scanner, and store the outputted 
--------> results in the temporary file tmp1234.txt.  But you could also just remove the newlines in a text editor application, then paste
--------> the resulting gene sequence into the terminal from which the lexical scanner is called, upon execution (usually with ctrl+D) a call
--------> to the R function 'collection' - (c(.)) is listed with probabilities in order of their appearance from left to right, top to bottom
--------> of the probabilities in the probability transition matrix with rows and columns arranged in lexicographic ordering.  IE. 
-------->
-------->
--------> 		 A     C     T     G
-------->	     A P(AA) P(AC) P(AT) P(AG)
-------->	     
-------->	     C P(CA) P(CC) P(CT) P(CG) 		
-------->						======= OUTPUT ======>>>>>>>>>>>         c(P^(AA),P^(AC),P^(AT),P^(AG), ...., P^(GA), P^(GC), P^(GT), P^(GG))  *^ because these are estimates
-------->	     T P(TA) P(TC) P(TT) P(TG)
--------> 
-------->	     G P(GA) P(GC) P(GT) P(GG) 
--------> 
-------->
--------> Once these collections are listed for each of the sequences of interest, the final part of the analysis pipeline can take place. 

Step 3: Analyzing Scanner Estimates of Transition Probabilities. 

---> Once these estimates are attained many different statistical analyses may be conducted and are of possible interest. 
---> one item of interest is the simultaneous multinomial confidence intervals for the probability that if we randomly selected
---> a given substring of length (2 in this specific example with 16 probabilities) it would be any one of the sixteen possible. 
---> once we have these intervals for all 2-mer probabilities in each of the seven different species, a count of the number of 
---> overlapping intervals can be taken, and the proportion of the sixteen intervals that overlap (or average at each of several confidence 
---> levels if so desired) can be taken as an estimate of the similarity between two particular sequences. 
---> If this methodology (R package MultinomialCI produces simultaneous intervals for 16 probabilities) is applied for all pairs of sequences, 
---> a pairwise distances matrix can be computed which may be used as the basis to any number of hierarchical clustering procedures to produce 
---> a sample dendrogram of the clustering based on this.  (A preliminary example of the analysis that might be conducted is in analyzeMTHFR.r, 
---> which actually contains the scanner output for each of the attached seven sequences, and so may be run independently. 


