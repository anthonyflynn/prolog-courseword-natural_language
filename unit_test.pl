(1)(a)

count_sentences([the, boy, chews, an, apple], X).
    X = 1

count_sentences([the, boy, chews, an, apple, and, the, girl, kicks, the, boy], X).
    X = 2

count_sentences([the, girl, chews, an, apple, and, the, girl, sings, a, song, and, the, girl, kicks, the, cow], X).
    X = 3

count_sentences([the, girl, chews, an, apple, and, the, girl, sings, a, song, and, the, girl, kicks, the, cow], 3).
    yes

count_sentences([the, girl, chews, an, apple, and, the, girl, sings, a, song, and, the, girl, kicks, the, cow], 2).
    no

count_sentences([the, and, and, the, chews, and], X).
    X = 4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1)(b)

actions(boy, [the,boy,chews,an,apple,and,the,girl,kicks,the,boy],X).
    X = [chews]

actions(apple, [the,boy,chews,an,apple,and,the,girl,kicks,the,boy],X).
    X = [].

actions(girl, [the,girl,chews,an,apple,and,the,girl,sings,a,song,and,the,girl,kicks,the,cow], X).
    X = [chews, sings, kicks]

actions(cow, [the, cow, eats], X).
    X = [eats]

actions(cow, [the, cow, eats, an, apple], X).
    X = [eats]

actions(cow, [a, song, eats, an, apple, and, a, cow, chews], X).
    X = [chews]

actions(grass, [an, grass, kicks, an, apple, and, a, grass, chews, and, the, grass, chews], X).
    X = [kicks, chews, chews].

actions(cow, [a, cow, eats, and, a, cow, chews], [eats, chews]).
    yes

actions(cow, [a, cow, eats, and, a, cow, chews], [chews]).
    no

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(2)

article_vowel(X).
    X = [an]
    X = [the]

article_vowel([an]).
    yes

article_vowel([a]).
    no

article_vowel([the]).
    yes

article_consonant(X).
    X = [a]
    X = [the]

article_consonant([an]).
    no

article_consonant([a]).
    yes

article_consonant([the]).
    yes

noun_phrase_better(X).
    X = [the,apple]
    X = [an,apple]
    X = [the,grass]
    X = [the,cow]
    X = [the,girl]
    X = [the,boy]
    X = [the,song]
    X = [a,grass]
    X = [a,cow]
    X = [a,girl]
    X = [a,boy]
    X = [a,song]


noun_phrase_better([a,apple]).
    no

noun_phrase_better([an,apple]).
    yes

noun_phrase_better([the,apple]).
    yes

noun_phrase_better([a,cow]).
    yes

noun_phrase_better([an,cow]).
    no

noun_phrase_better([the,cow]).
    yes

noun_phrase_better([a,X]).
    X = grass
    X = cow
    X = girl
    X = boy
    X = song

noun_phrase_better([an,X]).
    X = apple

noun_phrase_better([the,X]).
    X = apple
    X = grass
    X = cow
    X = girl
    X = boy
    X = song

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(3)

verb_phrase([slowly, eats]).
    yes

verb_phrase([slowly, eats, an, apple]).
    yes

verb_phrase([slowly, eats, a, apple]).
    yes

cadvs([slowly,',',merrily,and,sweetly]).
    yes

cadvs([slowly,and,merrily,and,sweetly]).
    no

cadvs([slowly,',',merrily,and,slowly]).
    no

cadvs([slowly,',',merrily,',',sweetly]).
    no

cadvs(X).
    X = [slowly]
    X = [deliberately]
    X = [merrily]
    X = [sweetly]
    X = [slowly,and,deliberately]
     12 containing 2
    X = [slowly,',',deliberately,and,merrily]
     24 containing 3
    X = [slowly,',',deliberately,',',merrily,and,sweetly]
     24 containing 4

adverb(X).
    X = [slowly]
    X = [deliberately]
    X = [merrily]
    X = [sweetly]

adverb([slowly]).
    yes

adverb([heavily]).
    no



verb_phrase_better([slowly,',',merrily,and,sweetly,sings]).
    yes

verb_phrase_better([slowly,',',merrily,and,sweetly,sings,a,song]).
    yes

verb_phrase_better([sings,a,song]).
    yes

verb_phrase_better([sings,an,song]).
    no

verb_phrase_better([slowly,',',merrily,and,slowly,sings,a,song]).
    no

verb_phrase_better([eats]).
    yes

verb_phrase_better([jumps]).
    no

verb_phrase_better([slowly, eats]).
    yes

verb_phrase_better([slowly,and,merrily,eats]).
    yes

verb_phrase_better([slowly, jumps]).
    no

verb_phrase_better(X).
    many


sentence_better([a,boy,slowly,',',merrily,and,sweetly,eats,a,apple]).
    no

sentence_better([a,boy,slowly,',',merrily,and,sweetly,eats,an,apple]).
    yes

sentence_better([a,apple,slowly,',',merrily,and,sweetly,eats,an,apple]).
    no

sentence_better([a,boy,eats]).
    yes

sentence_better([an,boy,eats]).
    no

sentence_better([a,boy,slowly,eats]).
    yes

sentence_better([a,boy,slowly,and,merrily,eats]).
    yes

sentence_better([a,boy,slowly,and,sweetly,and,merrily,eats]).
    no

sentence_better([a,boy,slowly,',',sweetly,and,merrily,eats]).
    yes

sentence_better([the,boy,slowly,',',sweetly,and,merrily,eats]).
    yes

sentence_better([a,boy,slowly,',',sweetly,and,merrily,eats,the,grass]).
    yes

sentence_better([an,boy,slowly,',',sweetly,and,merrily,eats]).
    no

sentence_better([a,boy,slowly,',',sweetly,',',merrily,eats]).
    no
