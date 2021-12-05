# matasano/RB

The first set of Matasano challenges, in Real Basic/Xojo.
This is all the files need to build the project, incling a Rijndael AES dynamic library (see folder).
The library is precompiled, but the original files and build scripts for Mac OS X and Linux are there too.

Around my birthday in 2013 (I was bored, it's in August...) I emailed the Matasano guys and asked for the set of challenges (there was only one set then). I got them 4 days later. I had a look, did a couple of problems. Then got frustrated with #4 I think, and shelved that "for later". I came back to it a couple of times, grrrr, same thing.

Here comes Christmas 2017, again I'm bored, and I wanted to do something different. I dug out the challenges, saw that the Matasano had been busy, and started working anew on Set 1. Since I wanted to do something that hasn't been done (AFAIK), I did them in RealBasic, aka Xojo (I use an old version). I had old code to interface with an AES library, so that helped a little.

Two days later I have the 8 challenges done (and 9, 10 from Set 2). The problems are run in a console app, as I wanted fast execution during my iterations. As you'll see, except for problem 4, which takes a second on my old MacBook Air, the whole set is done in less than two seconds:

dda$ time ./MataConsole
real    0m1.758s
user    0m1.675s
sys     0m0.036s

And the output is quite verbose too.

While RB/Xojo is cross-platform, I am not sure how to make it run on Windows, as I have no clue how to compile the rijndael lib to/on Windows. But Linux and Mac users should be able to run everything easily.

RB/Xojo has Base64Encode/Decode, so I didn't have to write anything for it – I consider this is not cheating, rather using my language of choice to its maximum... :-) I could write B64 routines, but they probably would be slower than the original.

Likewise, I'd love to convert the rijndael code to RB, but what's the point?

Play that funky music :-)
