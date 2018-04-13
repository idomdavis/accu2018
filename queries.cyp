MATCH (s:Package)-[r:USES]->(o:Package) RETURN s, r, o LIMIT 300

MATCH (n:Package)
  WHERE n.name = 'react-app'
RETURN n

MATCH (n:Package)
RETURN DISTINCT size((n)-[:USES]->(:Package)) AS c
  ORDER BY c

MATCH (n:Package)
WITH n.name AS name, size((n)-[:USES]->(:Package)) AS c
  ORDER BY c
  WHERE c >= 10
RETURN name, c

MATCH (n:Package)
RETURN DISTINCT size((n)<-[:USES]-(:Package)) AS c
  ORDER BY c

MATCH (n:Package)
WITH n.name AS name, size((n)<-[:USES]-(:Package)) AS c
  WHERE c > 20
RETURN name, c
  ORDER BY c

MATCH (n:Package)
WITH n, size((n)<-[:USES]-(:Package)) AS c
  WHERE c = 57
RETURN (n)<-[:USES]-(:Package)

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
WITH s, o, size((o)-[:USES]->(:Package)) AS c
  WHERE c = 0
WITH shortestPath((s)-[*1..20]->(o)) AS p
WITH size(p) AS s
RETURN DISTINCT s
  ORDER BY s

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
WITH s, o, size((o)-[:USES]->(:Package)) AS c
  WHERE c = 0
WITH s, o, shortestPath((s)-[*1..20]->(o)) AS p
  WHERE p IS NULL
RETURN s.name, o.name

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
  WHERE o.name = 'delegates'
RETURN shortestPath((s)-[*1..20]-(o))

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
WITH s, o, size((o)-[:USES]->(:Package)) AS c
  WHERE c = 0
RETURN shortestPath((s)-[*1..20]-(o)) AS p
LIMIT 100

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
WITH s, o, size((o)-[:USES]->(:Package)) AS c
  WHERE c = 0
WITH shortestPath((s)-[:USES*1..10]->(o)) AS p
WITH p, size(p) AS s
  WHERE s = 10
RETURN p
// try 9 and 8

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
WITH s, o, size((o)-[:USES]->(:Package)) AS c
  WHERE c = 0
RETURN shortestPath((s)-[:USES*1..3]->(o))

MATCH (s:Package)
  WHERE s.name = 'react-app'
WITH s
MATCH (o:Package)
WITH s, o, size((o)-[:USES]->(:Package)) AS c
  WHERE c = 0
RETURN shortestPath((s)-[*1..3]->(o))

MATCH (n:Package)
WITH n, size((n)<-[:USES]-(:Package)) AS c
  WHERE c = 57
RETURN (n)<-[:USES]-(:Package)<-[:USES]-(:Package)

MATCH(n:Package)
  WHERE n.name = 'babel-runtime' OR n.name = 'babel-types'
SET n:Locus

MATCH (n:Package)
WITH n, size((n)<-[:USES]-(:Package)) AS c
  WHERE c = 57
MATCH p = (n)<-[:USES]-(m:Package)-[:USES]-(:Package)
  WHERE NOT m.name =~ 'babel.*'
RETURN p

MATCH (s:Package)-[r:USES]->(o:Package)
  WHERE NOT s.name =~ 'babel.*'
RETURN s, r, o
LIMIT 300

//Versions
MATCH (s:Package)-[r:VERSION]->(o:Version)
RETURN s, r, o
  LIMIT 1

MATCH (p:Package)
WITH size((p)-[:VERSION]->(:Version)) AS s
RETURN DISTINCT s
  ORDER BY s

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s = 0
RETURN p.name

MATCH (p:Package)
  WHERE p.name = 'negotiator'
RETURN p

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s = 4
RETURN (p)-[:VERSION]->(:Version)

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s = 4
MATCH (p)<-[u:USES]-(d:Package)
RETURN p, u, d

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s = 4
MATCH (p)-[w:WANTS]->(d:Package)
RETURN p, w, d

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s > 1
RETURN (p)-[:VERSION]->(:Version)

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s > 1
MATCH (p)<-[u:USES]-(d:Package)
RETURN p, u, d

MATCH (p:Package)
WITH p, size((p)-[:VERSION]->(:Version)) AS s
  WHERE s > 1
MATCH (p)-[:VERSION]->(v:Version)
WITH p.name AS package, collect(v.name) AS versions
WITH package, versions, size(versions) AS c
RETURN package, versions
  ORDER BY c DESC

MATCH (s:Package)-[r:USES]->(o:Package)
  WHERE s.name = 'yargs'
RETURN s, r, o

MATCH (s:Package)-[r:WANTS]->(o:Package)
  WHERE s.name = 'yargs'
RETURN s, r, o
