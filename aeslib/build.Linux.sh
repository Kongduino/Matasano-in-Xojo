#! /bin/sh
gcc -Wall -O3 -DTRACE_KAT_MCT -DINTERMEDIATE_VALUE_KAT   -c -o rijndael-api-fst.o rijndael-api-fst.c
gcc -Wall -O3 -DTRACE_KAT_MCT -DINTERMEDIATE_VALUE_KAT   -c -o rijndael-alg-fst.o rijndael-alg-fst.c
gcc -o aes.so -shared rijndael-alg-fst.o rijndael-api-fst.o
sudo cp aes.so /usr/local/lib/
