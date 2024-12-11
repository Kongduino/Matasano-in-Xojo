# Matasano/RB

The first set of [Matasano challenges](https://cryptopals.com/sets/1), in Real Basic/Xojo. This is a very old project, which I am updating to a modern version of Xojo. This project has all the files need to build the project, including a Rijndael AES dynamic library (see folder). The library is precompiled, but the original files and build scripts for Mac OS X and Linux are there too.

Around my birthday in 2013 (I was bored, it's in August...) I emailed the Matasano guys and asked for the set of challenges (there was only one set back then). I got them 4 days later. I had a look, did a couple of problems. Then got frustrated with #4 I think, and shelved that "for later". I came back to it a couple of times, grrrr, same thing.

Here comes Christmas 2017, again I'm bored, and I wanted to do something different. I dug out the challenges, saw that the Matasano had been busy, and started working anew on Set 1. Since I wanted to do something that hasn't been done (AFAIK), I did them in RealBasic, aka Xojo (I use an old version). I had old code to interface with an AES library, so that helped a little.

Two days later I have the 8 challenges done (and 9, 10 from Set 2). The problems are run in a console app, as I wanted fast execution during my iterations. As you'll see, except for problem 4, which takes a second on my old MacBook Air, the whole set is done in less than two seconds:

```sh
dda$ time ./MataConsole
real    0m1.758s
user    0m1.675s
sys     0m0.036s
```

And the output is quite verbose too.

While RB/Xojo is cross-platform, I am not sure how to make it run on Windows, as I have no clue how to compile the rijndael lib to/on Windows. But Linux and Mac users should be able to run everything easily.

RB/Xojo has Base64Encode/Decode, which has been renamed `Encode-/DecodeBase64`, so I didn't have to write anything for it – I consider this is not cheating, rather using my language of choice to its maximum... :-) I could write B64 routines, but they probably would be slower than the original.

Likewise, I'd love to convert the Rijndael code to RB, but what's the point?

Play that funky music :-)

### UPDATE 2024/12/04

Running it on my MacBook M4 Pro, it is markedly faster:

```sh
./MataConsole  0.28s user 0.01s system 98% cpu 0.301 total
```

Still works like a charm. Just had to recompile easLib. I believe there are AES routines in Xojo now, but why bother :-)

Problem 11 is not finished yet – I know exactly what to do (famous last words) but need time.

Let me elaborate on this one. The challenge states:

## An ECB/CBC detection oracle
Now that you have ECB and CBC working:

Write a function to generate a random AES key; that's just 16 random bytes.

Write a function that encrypts data under an unknown key --- that is, a function that generates a random key and encrypts under it.

The function should look like:

```
encryption_oracle(your-input)
=> [MEANINGLESS JIBBER JABBER]
```

Under the hood, have the function append 5-10 bytes (count chosen randomly) before the plaintext and 5-10 bytes after the plaintext.

Now, have the function choose to encrypt under ECB 1/2 the time, and under CBC the other half (just use random IVs each time for CBC). Use rand(2) to decide which to use.

Detect the block cipher mode the function is using each time. You should end up with a piece of code that, pointed at a block box that might be encrypting ECB or CBC, tells you which one is happening.

This is – I think – easy. Since I decide the input, I provide the oracle with a long string of the same `A` character:

```
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```

Which means that if the oracle uses ECB, the output will have at least two instances of the same 16-byte blocks. Consider this: the header that obfuscates the encryption is 5 to 10 bytes. So 6 to 11 bytes of the plaintext proper is consumed by the first 16-byte block. Which is why, since I can't predict how many chars are consumed, I need to stay on a single character, `A` in this instance. Then I need at least 2 block-fulls to ensure repetition. 11 + 16 + 16: 43 bytes. I put 64 just... because... :-)

So when getting back the ciphertext, like in the example below (the oracle prints which algorithm it uses for debugging purposes), If I can find a repeating 16-byte block, it's ECB. Lines `001`, `002` and `003` repeat themselves exactly. Pretty simple to check.

```
==============================
Problem 11
==============================
 ECB/CBC detection oracle
AES_ECB_ENCRYPT
Len of clearText = 80
Output
    +------------------------------------------------+ +----------------+
    |.0 .1 .2 .3 .4 .5 .6 .7 .8 .9 .a .b .c .d .e .f | |      ASCII     |
    +------------------------------------------------+ +----------------+
000.|78 68 14 52 E6 19 AB DF 48 5C 9B 5F B8 C5 05 13 | |xh.R....H\._....|
001.|84 DF D3 AD 09 59 61 9F 53 46 7D 4D 2B E3 90 E8 | |.....Ya.SF}M+...|
002.|84 DF D3 AD 09 59 61 9F 53 46 7D 4D 2B E3 90 E8 | |.....Ya.SF}M+...|
003.|84 DF D3 AD 09 59 61 9F 53 46 7D 4D 2B E3 90 E8 | |.....Ya.SF}M+...|
004.|32 3E 7C FB E6 F4 AB A5 D0 AE 02 2B 60 0D 85 87 | |2>|........+`...|
    +------------------------------------------------+ +----------------+
```

### Challenge 12

It took me a while to understand what I had to do BUT I got it!

> Rollin' in my 5.0
> With my rag-top down so my hair can blow
> The girlies on standby waving just to say hi
> Did you stop? No, I just drove by
