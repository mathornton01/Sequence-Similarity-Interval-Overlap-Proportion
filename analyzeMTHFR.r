#!/usr/bin/Rscript

require(MultinomialCI); 

s1 <-  c(0.102719,0.057043,0.056056,0.089019,0.073136,0.038019,0.027101,0.055607,0.055966,0.045168,0.040142,0.052676,0.073046,0.053633,0.070623,0.110048)

l1 <- 33431; 

multinomialCI(round(s1*l1),0.05) -> m1; 

s2 <- c(0.056938,0.047170,0.081137,0.038188,0.073578,0.089383,0.022235,0.081284,0.063466,0.071074,0.089088,0.053895,0.029402,0.058901,0.085064,0.059196)

l2 <- 20373; 

multinomialCI(round(s2*l2),0.05) -> m2; 

s3 <- c(0.056903,0.050094,0.079701,0.038543,0.074047,0.088698,0.025169,0.078667,0.063408,0.068515,0.087847,0.055748,0.030944,0.059274,0.082741,0.059700)

l3 <- 16449; 

multinomialCI(round(s3*l3),0.05) -> m3; 
s4 <- c(0.057511,0.051675,0.088338,0.040239,0.075066,0.078549,0.016802,0.085420,0.067724,0.067818,0.076525,0.056664,0.037462,0.057794,0.087067,0.055346)

l4 <- 21248; 

multinomialCI(round(s4*l4),0.05) -> m4; 
s5 <- c(0.056398,0.046973,0.080582,0.037948,0.073452,0.090456,0.023337,0.080782,0.063229,0.071557,0.089409,0.053904,0.028872,0.059041,0.084721,0.059340)

l5 <- 20054; 

multinomialCI(round(s5*l5),0.05) -> m5; 
s6 <- c(0.055178,0.051172,0.087484,0.038290,0.074653,0.079927,0.018562,0.085455,0.066944,0.066335,0.079268,0.059489,0.035399,0.061112,0.086723,0.054012)

l6 <- 19718; 

multinomialCI(round(s6*l6),0.05) -> m6; 
s7 <-  c(0.098698,0.052939,0.062225,0.084083,0.073393,0.044929,0.014423,0.061363,0.050035,0.043557,0.048950,0.055141,0.075787,0.052716,0.072085,0.109675)

l7 <- 31338; 

multinomialCI(round(s7*l7),0.05) -> m7; 

S <- list(s1,s2,s3,s4,s5,s6,s7);
Scum<-lapply(1:7, function(i) {cumsum(S[[i]])});

png('16TransitionMTHFRAcrossSpecies.png',height=1000,width=1000); 
plot(Scum[[1]],type='l',col=rainbow(7)[1], main='A comparison of the MTHFR gene transition probabilities for seven species', 
     xlab = 'Lexicographical Ordering of Transition', ylab='Cummulative Probability of Transition'); 
lapply(2:7, function(i) {lines(Scum[[i]], col=rainbow(7)[i])});
legend('topleft', legend=c("dan rer", "homo sap", "mac mul", "mus muc", "pan trog", "rat nor", "xen trop"), col=rainbow(7), lty = 1); 
dev.off();

# Since there are now simultaneous multinomial confidence intervals for each of the transition 
# probabilities for each of the species, the number of overlapping intervals can be compared for 
# each of the sequences, to compute similarity scores with resolution of 4 bits.  I will write 
# an r function here that will compute the similarity score when given two matricies of interval 
# limits. 

compSim <- function(m1,m2) {
	rs <- nrow(m1); 
	overlap <- 0; 
	total <- rs; 
	for (i in 1:rs) {
		overlap <- overlap + (((m1[i,1] < m2[i,1]) & (m1[i,2] > m2[i,1])) | ( (m1[i,2] > m2[i,2]) & (m1[i,1] < m2[i,2])))
	}
	return(overlap/total); 
}

# Now build up the pair wise distances matrix that represents the distances between the organisms in 
# terms of the intersecting confidence intervals. 

M <- list(m1,m2,m3,m4,m5,m6,m7); 
Z <- matrix(nrow=7, ncol=7); 

for (i in 1:7){ 
	for (j in 1:7) {
	Z[i,j] <- compSim(M[[i]],M[[j]]); 	
	}
}

plot(hclust(as.dist(Z))); 

