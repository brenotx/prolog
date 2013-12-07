/* exSystem.pro
  character identification game.  

    start with ?- main.     */

main :- write('###################################################################################'), nl,
        write('# Este é um sistema especialista dos principais personagens da série de TV Chaves #'), nl,
        write('# Uso:                                                                            #'), nl,
        write('#     [  go.  ] para iniciar as perguntas.                                        #'), nl, 
        write('#     [ undo. ] para resetar suas respostas.                                      #'), nl,
        write('#                                                                                 #'), nl,
        write('# Para responder, utilize as palavras yes/no OU y/n.                              #'), nl, 
        write('###################################################################################'), nl,   
        write(' '),
        read(Command),
        command(Command).

command(go) :- go.

go :- 
      hypothesize(Character, Translate),
      write('Eu acho que o personagem é: '),
      write(Translate),
      nl,
      undo.

/* hypotheses to be tested */
hypothesize(quico, 'Quico')                   :- quico, !.
hypothesize(chaves, 'Chaves')                 :- chaves, !.
hypothesize(nhonho, 'Nhonho')                 :- nhonho, !.
hypothesize(senhor_barriga, 'Senhor Barriga') :- senhor_barriga, !.
hypothesize(girafales, 'Professor Girafales') :- girafales, !.
hypothesize(seu_madruga, 'Seu madruga')       :- seu_madruga, !.
hypothesize(jaiminho, 'Jaiminho')             :- jaiminho, !.
hypothesize(chiquinha, 'Chiquinha')           :- chiquinha, !.
hypothesize(popis, 'Popis')                   :- popis, !.
hypothesize(dona_florinda, 'Dona Florinda')   :- dona_florinda, !.
hypothesize(dona_clotilde, 'Dona Clotilde')   :- dona_clotilde, !.
hypothesize(unknown).             /* no diagnosis */

/* character identification rules */
quico :- boy, 
         verify(has_multicolored_hat, 'possui chapéu colorido').

chaves :- boy,
          verify(lives_in_a_barrel, 'mora em um barril'). 

nhonho :- boy,
          verify(is_fat, 'é gordo').

senhor_barriga :- adult_man,
                  verify(wears_suit, 'usa terno'),
                  verify(is_fat, 'é gordo').

girafales :- adult_man,
             verify(wears_suit, 'usa terno'),
             verify(is_a_teacher, 'é professor').

seu_madruga :-  adult_man,
                verify(does_not_pay_rent, 'nunca paga o aluguel').
                
jaiminho :- adult_man,
            verify(is_a_postman, 'é um carteiro').

chiquinha :- girl,
             verify(wear_glasses, 'usa óculos').  

popis :- girl, 
         verify(holds_a_doll, 'sempre está segurando uma boneca'). 

dona_florinda :- adult_woman,
                 verify(wears_curlers, 'usa bobes no cabelo').

dona_clotilde :- adult_woman,
                 verify(knows_dark_magic, 'conhece magia negra').

/* classification rules */
child :- verify(is_child, 'é crianca').
man   :- verify(is_man, 'é homem').

adult_man :- not(child),
             man.

adult_woman :- not(child),
               not(man).

boy :- child,
       man.

girl :- child,
        not(man).

/* how to ask questions */
ask(Question, Translate) :-
    write('O personagem possui o seguinte atributo: '),
    write(Translate),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* How to verify something */
verify(S, Ptbr) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S, Ptbr))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.
