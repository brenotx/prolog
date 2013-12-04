:- op(1200, xfy, if).
:- op(1000, xfy, and).
:- op(900, xfx, &). 


:- dynamic(reconhece/2).

main :- retractall(reconhecer(_,_)), 
  write('============================================================================'), nl,
  write('Bem vindo ao sistema especialista de consultorios medicos')                      , nl,
  write('Uso: ')                                                                          , nl,
  write(' [iniciar.] para iniciar o diagnostico. ')                                       , nl, 
  write(' [encerrar.] para sair da aplicacao')                                            , nl, nl,
  write('============================================================================'), nl, 
  write('Obs.: Baseado no TG de Luciana Santos / Centro Universitario de Vila Velha')     , nl,   
  write('============================================================================'), nl,
  write(' '),
  read(Comando), 
  processa(Comando).

processa(iniciar) :- solve(diagnostico(X), P),  
                     nl, 
                     write('Diagnostico: '), 
                     write(X), nl, 
                     print_proof(P), !, retractall(reconhece(_,_)). 

processa(encerrar) :- nl, write('Adeus!'), nl. 

clause(diagnostico(X) if doenca(X)).

clause(doenca(amigdalite) if sintoma(dor_garganta) and sintoma(dor_pelo_corpo) 
                                             and sintoma(cansaco) 
                                             and sintoma(febre) 
                                             and sintoma(falta_de_apetite) 
                                             and sintoma(dificuldade_respiratoria)
                                             and sintoma(dor_de_cabeca)).

clause(doenca(asma) if sintoma(tosse) and sintoma(catarro) 
                                      and sintoma(dificuldade_respiratoria) 
				      and sintoma(dor_peitoral) 
 				      and sintoma(chiado_peitoral)).

clause(doenca(catapora) if sintoma(febre) and sintoma(erupcoes_cutaneas)).

clause(doenca(rubeola) if sintoma(febre) and sintoma(erupcoes_cutaneas) and sintoma(aumento_ganglios_linfaticos)).

clause(doenca(sarampo) if sintoma(febre) and
                          sintoma(tosse) and
                          sintoma(coriza) and 
                          sintoma(conjuntivite) and 
                          sintoma(fotofobia)).

descricao(dor_garganta, 'Dor de garganta').
descricao(dor_pelo_corpo, 'Dor pelo corpo').
descricao(febre, 'Febre').
descricao(cansaco, 'Cansaco'). 
descricao(falta_de_apetite, 'Falta de apetite').
descricao(dificuldade_respiratoria, 'Dificuldade respiratoria').
descricao(dor_de_cabeca, 'Dor de cabeca').
descricao(tosse, 'Tosse').
descricao(catarro, 'Catarro').
descricao(dor_peitoral, 'Dor no peito').
descricao(chiado_peitoral, 'Chiado peito').
descricao(erupcoes_cutaneas, 'Erupcoes cutaneas').
descricao(aumento_ganglios_linfaticos, 'Aumento dos ganglios linfaticos').
descricao(coriza, 'Coriza').
descricao(conjuntivite, 'Conjuntivite').
descricao(fotofobia, 'Fotofobia').

solve(true, void).
solve((X and Y), (Px & Py)) :- solve(X, Px), solve(Y, Py).
solve(sintoma(X), proof(sintoma(X), void)) :- confirma(X).
solve(X, proof(X, Py)) :- clause(X if Y), solve(Y, Py).

confirma(X) :- reconhece(X, true).
confirma(X) :- not(reconhece(X, true)), nl, pergunta(X), read(R), preservaRespostas(X, R), R = sim.

pergunta(X) :- write('Voce apresenta o sintoma '), descricao(X,R), write(R), write('? '). 

preservaRespostas(X, sim) :- asserta(reconhece(X, true)).
preservaRespostas(X, nao)  :- asserta(reconhece(X, false)).

print_proof(void).
print_proof(X & Y) :- print_proof(X), nl, print_proof(Y).
print_proof(proof(X, void)) :- write(X), write(' esta presente '), nl. 
print_proof(proof(X, Y)) :- Y \= void, write(' conclui-se '), write(X), write(' dado que '), nl, print_children(Y), nl, print_proof(Y).

print_children(proof(X, _) & Z) :- tab(8), write(X), write( ' e ' ), nl, print_children(Z).
print_children(proof(X, _)) :- tab(8), write(X), nl.
 