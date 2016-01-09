%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assessed Prolog Lab Exercise 2 - Natural Language
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rules defining sentence, noun_phrase and verb_phrase:

sentence(S):- noun_phrase(NP), verb_phrase(VP), append(NP, VP, S).

noun_phrase(NP):- article(A), noun(N), append(A, N, NP). 

verb_phrase(V):- verb(V).
verb_phrase(VP):- verb(V), noun_phrase(NP), append(V, NP, VP).

% The Lexicon:

article([the]).
article([a]).
article([an]).

noun([grass]).
noun([cow]).
noun([girl]).
noun([boy]).
noun([apple]).
noun([song]).

verb([eats]).
verb([sings]).
verb([chews]).
verb([kicks]).

% (1)(a) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% count_sentences(+Text, ?Count) - for a conjunction of sentences, Text,
% separated by the word 'and', Count is the number of sentences in Text

count_sentences([], 1). 

count_sentences([H|T], X):-
    H = and,
    count_sentences(T, Y),
    X is Y+1.

count_sentences([H|T], X):-
    H \= and,
    count_sentences(T, X).
    

% (1)(b) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% actions(+Actor, +Text, ?As) - As is a list of actions that the Actor does
% according to the Text.

actions(_, [_], []).

actions(Actor, [H1,H2|T] , As):-
    H1 = Actor,
    verb([H2]),
    actions(Actor, [H2|T], NewAs),
    append([H2], NewAs, As).

actions(Actor, [H1,H2|T] , As):-
    H1 = Actor,
    \+ verb([H2]),
    actions(Actor, [H2|T], NewAs),
    append([], NewAs, As).

actions(Actor, [H1,H2|T] , As):-
    H1 \= Actor,
    actions(Actor, [H2|T], As).


% (2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rules defining which letters are vowels:
vowel(a).
vowel(e).
vowel(i).
vowel(o).
vowel(u).


% article_vowel(?A) - article A is an apporpriate article for a noun beginning
% with a vowel (i.e. 'an' or 'the').

article_vowel(A):-
    article(A),
    A \= [a].


% article_consonant(?A) - article A is an apporpriate article for a noun 
% beginning with a consonant (i.e. 'a' or 'the').

article_consonant(A):-
    article(A),
    A \= [an].


% noun_phrase_better(?NP) - NP is a noun phrase whereby the article matches
% the noun in noun phrases (based on whether the first letter of the noun
% is a consonant or a vowel).

noun_phrase_better(NP):- 
    article_vowel(A), 
    noun([Noun]),
    atom_chars(Noun, [H|_]),
    vowel(H),
    append(A, [Noun], NP). 

noun_phrase_better(NP):- 
    article_consonant(A), 
    noun([Noun]),
    atom_chars(Noun, [H|_]),
    \+ vowel(H),
    append(A, [Noun], NP). 


% (3)(a/b) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% cadvs(?L) means L is a conjunction of adverbs. When there are more than
% two adverbs, all but the final two are separated by commas, and only the 
% final two are separated by the word "and"

cadvs(L):-
    cadvs_acc(L, []).


% cadvs_acc(L, AccList) is an accumulator function, with AccList tracking the
% adverbs on the list L through each stage of the recursion (avoid duplication)

cadvs_acc([H], []):-
    adverb([H]).

cadvs_acc([H1, and, H3], AccList):-
    adverb([H1]),
    adverb([H3]),
    nonmember(H1, AccList),
    nonmember(H3, AccList),
    H1 \= H3.

cadvs_acc([H1, ',', H3, H4, H5 | T], AccList) :-
    adverb([H1]),
    nonmember(H1, AccList),
    cadvs_acc([H3, H4, H5 | T], [H1 | AccList]).


% (3)(b) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Facts defining a list of adverbs:

adverb([slowly]).
adverb([deliberately]).
adverb([merrily]).
adverb([sweetly]).


% (3)(c) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% verb_phrase_better(?V) means V is a verb phrase, i.e. V is either (i) a verb
% (ii) a verb followed by a noun_phrase_better, (iii) a conjunction of adverbs
% followed by a verb or (iv) a conjunction of adverbs, followed by a verb, 
% followed by a noun_phrase_better.

verb_phrase_better(V):-
    verb(V).

verb_phrase_better(VP):-
    verb(V),
    noun_phrase_better(NP),
    append(V, NP, VP).

verb_phrase_better(VP):-
    cadvs(L),
    verb(V),
    append(L, V, VP).

verb_phrase_better(VP):-
    cadvs(L),
    verb(V),
    append(L, V, X), 
    noun_phrase_better(NP), 
    append(X, NP, VP).


% (3)(d) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sentence_better(?S) means S is a noun_phrase_better, followed by a 
% verb_phrase_better

sentence_better(S):-
    noun_phrase_better(NP), 
    verb_phrase_better(VP), 
    append(NP, VP, S).

