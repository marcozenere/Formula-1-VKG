[QueryItem="F1 Constructor"]
PREFIX f1: <http://www.semanticweb.org/marcozenere/ontologies/2021/3/untitled-ontology-6#>

select ?name (COUNT(?position) as ?wins)
where{
            ?result a f1:Result;
	      f1:ResultPosition ?position;
                        f1:AchievedByConstructor ?constructorId.
            ?constructorId f1:ConstructorName ?name.
            FILTER(?position = 1.0 )
}GROUP BY ?name
ORDER BY DESC (?wins)
[QueryItem="Fastest Lap"]
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX f1: <http://www.semanticweb.org/marcozenere/ontologies/2021/3/untitled-ontology-6#>

select ?raceName ?time ?year ?name ?surname
where{
           ?x a f1:LapTime; 
                f1:TimeLap ?time;
                f1:LapTimeDriverId ?driver;
                f1:LapTimeDoneIn ?race;
                f1:LapTimeDoneBy ?driverId.
                ?race f1:RaceName ?raceName;
                          f1:RaceYear ?year.
                ?driverId foaf:firstName ?name;
                                foaf:lastName ?surname.
                FILTER(?fastestTime = ?time){
	select ?raceName (MIN(?time) as ?fastestTime)
	where {
	           ?x  a f1:LapTime;
                                      f1:TimeLap ?time;
	                    f1:LapTimeDoneIn ?race.
                             ?race f1:RaceName ?raceName.     
	}group by ?raceName
	}
}ORDER BY ?raceName
[QueryItem="F1 Driver"]
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX f1: <http://www.semanticweb.org/marcozenere/ontologies/2021/3/untitled-ontology-6#>

select ?name ?surname (COUNT(?position) as ?wins)
where{
            ?result a f1:Result;
	      f1:ResultPosition ?position;
                        f1:AchievedByDriver ?driverId.
            ?driverId foaf:firstName ?name;
                            foaf:lastName ?surname.
            FILTER(?position = 1.0 )
}GROUP BY ?name ?surname
HAVING (?wins >= 3)
ORDER BY DESC (?wins)
[QueryItem="Worst F1 Constructor"]
PREFIX f1: <http://www.semanticweb.org/marcozenere/ontologies/2021/3/untitled-ontology-6#>

select ?name (COUNT(?position) as ?count)
where{
           ?result a f1:Result;
	     f1:ResultPosition ?position;
                       f1:ResultStatus ?status;
                       f1:AchievedByConstructor ?constructorId.
           ?constructorId  f1:ConstructorName ?name.
           FILTER(?position = 0.0)
           FILTER(?status != 3)
           FILTER(?status != 4)
           FILTER(?status != 73)
           FILTER(?status != 82)
           FILTER(?status != 130)
}GROUP BY ?name
ORDER BY DESC (COUNT(?position))
[QueryItem="Ferrari Car Issues"]
PREFIX f1: <http://www.semanticweb.org/marcozenere/ontologies/2021/3/untitled-ontology-6#>

select ?description (COUNT(?description) as ?count )
where{
           ?result a f1:Result;
	     f1:ResultPosition ?position;
                       f1:ResultStatus ?status;
                       f1:ResultConstructId ?constructorId;
                       f1:hasStatus ?s.
           ?s  f1:StatusDescription ?description.
           FILTER(?position = 0.0)
           FILTER(?constructorId= 6)
           FILTER(?status != 3)
           FILTER(?status != 4)
           FILTER(?status != 73)
           FILTER(?status != 82)
           FILTER(?status != 130)
}GROUP BY ?description
ORDER BY DESC (COUNT(?description))