/* exSystem.pro
  character identification game.  

    start with ?- go.     */

go :- hypothesize(Character),
      write('I guess that the character is: '),
      write(Character),
      nl,
      undo.

/* hypotheses to be tested */
hypothesize(quico)          :- quico, !.
hypothesize(chaves)         :- chaves, !.
hypothesize(nhonho)         :- nhonho, !.
hypothesize(senhor_barriga) :- senhor_barriga, !.
hypothesize(girafales)      :- girafales, !.
hypothesize(seu_madruga)    :- seu_madruga, !.
hypothesize(jaiminho)       :- jaiminho, !.
hypothesize(chiquinha)      :- chiquinha, !.
hypothesize(popis)          :- popis, !.
hypothesize(dona_florinda)  :- dona_florinda, !.
hypothesize(dona_clotilde)  :- dona_clotilde, !.
hypothesize(unknown).             /* no diagnosis */

/* character identification rules */
quico :- boy, 
         verify(has_multicolored_hat).

chaves :- boy,
          verify(lives_in_a_barrel). 

nhonho :- boy,
          verify(is_fat). % n precisa!

senhor_barriga :- adult_man,
                  verify(wears_suit),
                  verify(is_fat).

girafales :- adult_man,
             verify(wears_suit),
             verify(is_a_teacher).

seu_madruga :-  adult_man,
                verify(does_not_pay_rent).
                
jaiminho :- adult_man,
            verify(is_a_postman).

chiquinha :- girl,
             verify(wear_glasses).  

popis :- girl, 
         verify(holds_a_doll). 

dona_florinda :- adult_woman,
                 verify(wears_curlers).

dona_clotilde :- adult_woman,
                 verify(knows_dark_magic).

/* classification rules */
child :- verify(is_child).
man   :- verify(is_man).

adult_man :- not(child),
             man.

adult_woman :- not(child),
               not(man).

boy :- child,
       man.

girl :- child,
        not(man).

/* how to ask questions */
ask(Question) :-
    write('Does the character have the following attribute: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.