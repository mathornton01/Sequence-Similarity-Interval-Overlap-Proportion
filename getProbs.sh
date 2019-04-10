#!/bin/bash 
touch tmp1234.txt; 
cat dat/mthfrdanrer.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
cat dat/mthfrhomosap.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
cat dat/mthfrmacmul.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
cat dat/mthfrmusmuc.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
cat dat/mthfrpantrog.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
cat dat/mthfrratnor.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
cat dat/mthfrxentrop.seq | tr -d '\n' | ./16transprob.out >> tmp1234.txt
sed '/^ /!d' tmp1234.txt >> probs.txt
