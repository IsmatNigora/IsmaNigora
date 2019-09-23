implement main
    open core

domains
    people = person(string, string Surname, sex).
    sex = male; female.

class predicates
    parent : (people, people) nondeterm (i,person(o,o,o)).
    parent : (people, people) nondeterm (i,person(o,o,i)).
    parent : (people, people) nondeterm (o,person(o,o,i)).
    parent : (people, people) nondeterm.
    parent : (people, people [out]) nondeterm.
    parent : (people, people) nondeterm (person(o,o,i),i).
    married : (people, people) determ (i,person(o,o,o)).
    married : (people, people) determ (person(o,o,o),i).
    married : (people, people) determ (person(o,o,i),i).
    brother : (people, people) nondeterm (person(o,o,i),person(o,o,o)).
    brother : (people, people) nondeterm (person(o,o,i),o).
    brother : (people, people) nondeterm (person(o,o,i),person(o,o,i)).
    brotherInLaw : (people, people) nondeterm (person(o,o,i),person(o,o,o)).
    brotherInLaw : (people, people) nondeterm (person(o,o,i),person(o,o,i)).

clauses
    parent(person("Отец", " Pit ", male), person("Сын", " Pit ", male)).
    parent(person("Отец", " Pit ", male), person("Сын2", " Pit ", male)).
    parent(person("Отец", " Pit ", male), person("Дочь", " Pit ", female)).

    parent(person("Bred", " Pit ", male), person("Poll", " Pit ", male)).
    parent(person("Lida", " Ann ", female), person("Poll", " Pit ", male)).
    parent(person("Bred", " Pit ", male), person("Elisa", " Pit ", female)).
    parent(person("Lida", " Ann ", female), person("Elisa", " Pit ", female)).
    parent(person("Poll", " Pit ", male), person("Masha", " Pit ", female)).
    parent(person("Poll", " Pit ", male), person("Horward", " Pit ", male)).
    parent(person("Kleio", "Rot", female), person("Masha", " Pit ", female)).
    parent(person("Kleio", "Rot", female), person("Horward", " Pit ", male)).
    parent(person("Elisa", " Pit", female), person("Nastya", " Rit", female)).
    parent(person("Elisa", "Pit", female), person("Harald", "Rit", male)).
    parent(person("Roma", "Rit", male), person("Nastya", "Rit", female)).
    parent(person("Roma", "Rit", male), person("Harald", "Rit", male)).
    married(person("Lida", " Ann ", female), person("Bred", " Pit ", male)).
    married(person("Kleio", " Rot ", female), person("Poll", " Pit ", male)).
    married(person("Elisa", " Pit ", female), person("Roma", " Rit ", male)).
    married(person("Жена_Сын", " Pit ", female), person("Сын", " Pit ", male)).

    brother(C1, C2) :-
        parent(P1, C1),
        parent(P1, C2),
        C1 <> C2.
    brotherInLaw(X, Y) :-
        brother(X, Z),
        married(Y, Z),
        X <> Z.

    run() :-
        console::init(),
        brother(person(A, W, male), person(X, Y, female)),
        stdio::write(A, W, " брат ", X, Y),
        stdio::nl(),
        fail.
    run() :-
        console::init(),
        brotherInLaw(person(A, W, male), person(X, Y, female)),
        stdio::write(A, W, " брат мужа ", X, Y),
        stdio::nl(),
        fail.
    run() :-
        _ = stdio::readChar().

end implement main

goal
    mainExe::run(main::run).
