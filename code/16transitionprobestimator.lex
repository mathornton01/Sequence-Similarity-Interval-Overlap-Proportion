%{ 
double transition_probabilities[16] = {0};
int count = 0; 
%} 

%% 
A/A {transition_probabilities[0]++;count++;}
A/C {transition_probabilities[1]++;count++;}
A/G {transition_probabilities[2]++;count++;}
A/T {transition_probabilities[3]++;count++;}
C/A {transition_probabilities[4]++;count++;}
C/C {transition_probabilities[5]++;count++;}
C/G {transition_probabilities[6]++;count++;}
C/T {transition_probabilities[7]++;count++;}
G/A {transition_probabilities[8]++;count++;}
G/C {transition_probabilities[9]++;count++;}
G/G {transition_probabilities[10]++;count++;}
G/T {transition_probabilities[11]++;count++;}
T/A {transition_probabilities[12]++;count++;}
T/C {transition_probabilities[13]++;count++;}
T/G {transition_probabilities[14]++;count++;}
T/T {transition_probabilities[15]++;count++;}
%% 

int yywrap(){}
int main(){
yylex(); 
printf("\n c(%f,", transition_probabilities[0]/count); 
for(int i = 1; i < 15; i++){
	printf("%f,",transition_probabilities[i]/count); 
}
printf("%f)\n",transition_probabilities[15]/count); 
printf("%d", count); 
return(0); 
}
