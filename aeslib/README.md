# aeslib

This could be a separate project, but since it was used first for Matasano, it found a nice home here...

I upload the pre-build dylib but you can do that (and install it) on your own, with `build.<platform>.sh`:

```bash
#! /bin/sh
gcc -Wall -g -c -O3 -DTRACE_KAT_MCT -DINTERMEDIATE_VALUE_KAT -o rijndael-api-fst.o rijndael-api-fst.c
gcc -Wall -g -c -O3 -DTRACE_KAT_MCT -DINTERMEDIATE_VALUE_KAT -o rijndael-alg-fst.o rijndael-alg-fst.c
gcc -o aes.dylib -dynamiclib rijndael-alg-fst.o rijndael-api-fst.o
sudo cp aes.dylib /usr/local/lib/
```
The code expects `aes.dylib` to be located in `/usr/local/lib/` but that can changed in the code. See the `aesLib` constant in the AES module. Here's a simple example:

```basic
Print "Key:"
keyMaterial=New MemoryBlock(32)
mb="YELLOW SUBMARINE"
keyMaterial=ComputeKeyMaterial(mb)
ShowHex(mb)
ShowHex(keyMaterial)
Print "=================="+EndOfLine.UNIX
Print "Encoded Buffer:"
Print "=================="
mb=DecodeBase64(Problem7Buffer)
ShowHex(mb)
Print "=================="+EndOfLine.UNIX
Print "Decoded Buffer:"
Print "=================="
rslt=AES_DECRYPT(keyMaterial, mb)
Print(rslt)
```

Both `AES_DECRYPT` and `AES_ENCRYPT` have a `_VERBOSE` option if you're interested in seeing what's happening. The code is pretty self-explanatory.

There are a few auxiliary functions that can come in handy:

* `Public Function GetBestScore(tmp0 As MemoryBlock) As BestScorer()`
* `Public Function ASCII2Hex(s As String) As MemoryBlock`
* `Public Function HammingDistance(tmp0 As MemoryBlock, tmp1 As MemoryBlock) As Integer`
* `Public Function ScoreString(mb As MemoryBlock) As Integer`
* `Public Function xorStrings(mb0 As MemoryBlock, mb1 As MemoryBlock) As MemoryBlock`
* `Public Sub BubbleSort(Byref A() As HammingScore)`
* `Public Sub InitProblems()`
* `Public Sub ShowHex(s As MemoryBlock, myWidth As Integer = 16, highlight As String = "", hlMsg As String = "")`
