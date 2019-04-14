import sys
from itertools import product 

# filename is the name of the written flex file
# bpnum is the number of base pairs, note there 
# will be 4^bpnum of probabilities estimated. 

def genFlex(filename, bpnum):
    perms = [''.join(i) for i in product(['A','C','G','T'],repeat=int(bpnum))]
    with open(filename, 'w') as lexfile: 
        lexfile.write('%{\n')
        lexfile.write('double transition_probabilities['+str(4**int(bpnum))+'] = {0};\n')
        lexfile.write('int count = 0;\n')
        lexfile.write('%}\n\n%%\n')
        i=0
        for p in perms: 
            lexfile.write(p[0] + '/' + p[1:] + ' {transition_probabilities[' + str(i) + ']++;count++;}\n')
            i = i+1
        lexfile.write('%%\n\n')
        lexfile.write('int yywrap(){}\n')
        lexfile.write('int main(){\n') 
        lexfile.write('yylex();\n')
        lexfile.write('printf("\\n c(%f,",transition_probabilities[0]/count);\n')
        lexfile.write('for(int i = 1; i<'+str(len(perms))+';i++){\n') 
        lexfile.write('    printf("%f,",transition_probabilities[i]/count);\n') 
        lexfile.write('}\n')
        lexfile.write('printf("%f)\\n",transition_probabilities['+str(len(perms)-1)+']/count);\n')
        lexfile.write('return(0);\n')
        lexfile.write('}')








if __name__ == "__main__": 
    argc = len(sys.argv) 
    if (argc != 3): 
        exit() 
    else: 
        genFlex(sys.argv[1], sys.argv[2]) 
