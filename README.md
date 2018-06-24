# Bidibibasididati
Courses (UniPG, year 2017-18): 
+ _Basi di dati e sistemi informativi_ (Raffaella Gentilini),
+ _Basi di dati su larga scala e data mining_ (Valentina Poggioni).

This repo contains a ton of exercises (with solutions likely to be correct) for both courses, some data mining notes written in markdown, a short report about Git's database and a small personal project in SQL+python.

## On exercises
Unfortunately, all the exercises are in Italian. Still, the _Basi di dati e sistemi informativi_ ones may be very useful for someone who needs to prepare that exam. They sorted by the database or schema they use. The scans of the assignment text are stored in [this](https://github.com/harisont/Bidibibasididati/blob/master/Basi%20di%20dati%20e%20sistemi%20informativi/Consegne%20esercizi.pdf) file. All exercises are solved except on the last page's ones, which is an exam. 
The DMBS I used is postgres.

## On notes
I like to read my notes on my e-reader. If you'd like something similar, I suggest that you install [pandoc](http://pandoc.org/) (what a wonderful software!) and run 
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
even though I am still working on the CSS to produce the best output for such e-readers.
__BE CAREFUL!__ these notes are just a draft and they are not exhaustive (they will probably never be). They only cover data preprocessing and association analysis. After some revision, they could be a good place to start from for someone who's less on a hurry.

## On the report
The report is about how Git stores data. My main source of information about this topic is [Pro Git](https://git-scm.com/book/en/v2), which is quite an interesting book. As the book hasn't be translated to Italian yet, I decided to write my report in Italian.

## On the personal project
The project (Life scheduler) is a really simple productivity tool that runs in a terminal. It is a blueprint for a slightly more complex Android app I may develop one day.
