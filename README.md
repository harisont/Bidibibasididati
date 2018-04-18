# Bidibibasididati
Courses (UniPG, year 2017-18): 
+ _Basi di dati e sistemi informativi_ (Raffaella Gentilini),
+ _Basi di dati su larga scala e data mining_ (Valentina Poggioni).

This repo contains a ton of exercises (with solutions likely to be correct) for both courses, some data mining notes written in markdown and a small personal project in SQL+python.

## On exercises
Unfortunately, all the exercises are in Italian. They sorted by the database or schema they use. 
The DMBS I used is postgres.

## On notes
I like to read my notes on my e-reader. If you'd like something similar, I suggest that you install __pandoc__ (what a wonderful software!) and run 
```
pandoc dm.md -o dm.epub 
```
If your reader renders math formulas poorly, use
```
pandoc dm.md -t epub2 -o dm.epub --webtex
```
For Pocketbook owners, I suggest that you use
```
pandoc dm.md -t epub2 -o dm.epub --css poketbook_style.css --webtex
```
even though I am still working on the CSS that produce the best output for such e-readers.

## On the personal project
The project (Life scheduler) is a really simple productivity tool that runs in a terminal. It is a blueprint for a slightly more complex Android app I may develop one day.
