CREATE 
    (navi: Organization {name: 'Natus Vincere', date_of_creation: 2010, location: 'Украина'}),
    (g2: Organization {name: 'G2 esports', date_of_creation: 2014, location: 'Германия'}),
    (og: Organization {name: 'OG esports', date_of_creation: 2015, location: 'Европа'}),
    (cloud: Organization {name: 'Cloud9', date_of_creation: 2013, location: 'США'}),

    (navicsgo: Team {name: 'NAVICSGO'}),
    (navidota: Team {name: 'NAVIDOTA2'}),
    (g2csgo: Team {name: 'G2'}),
    (ogdota: Team {name: 'OG'}),
    (cloudcsgo: Team {name: 'CLOUD9'}),

    (navi)-[:TEAM]->(navicsgo),
    (navi)-[:TEAM]->(navidota),
    (g2)-[:TEAM]->(g2csgo),
    (og)-[:TEAM]->(ogdota),
    (cloud)-[:TEAM]->(cloudcsgo),

    (csgo: Game {name: 'CSGO', date_of_creation: 2012, average_online: 500000}),
    (dota: Game {name: 'DOTA2', date_of_creation: 2013, average_online: 470000}),
    
    (navicsgo)-[:GAME]->(csgo),
    (navidota)-[:GAME]->(dota),
    (g2csgo)-[:GAME]->(csgo),
    (ogdota)-[:GAME]->(dota),
    (cloudcsgo)-[:GAME]->(csgo),

    (simple: Player {name: 'Александр Костылев', nickname: 's1mple', country: 'Украина', age: 24}),
    (bit: Player {name: 'Валерий Ваковский', nickname: 'b1t', country: 'Украина', age: 18}),
    (electronic: Player {name: 'Денис Шарипов', nickname: 'electronic', country: 'Россия', age: 23}),
    (navicsgo)-[:PLAYER]->(simple),
    (navicsgo)-[:PLAYER]->(bit),
    (navicsgo)-[:PLAYER]->(electronic),

    (vtune: Player {name: 'Алик Воробей', nickname: 'V-Tune', country: 'Украина', age: 21}),
    (generaL: Player {name: 'Віктор Нігріні', nickname: 'GeneRaL', country: 'Украина', age: 25}),
    (solo: Player {name: 'Алексей Березин', nickname: 'Solo', country: 'Россия', age: 31}),
    (navidota)-[:PLAYER]->(solo),
    (navidota)-[:PLAYER]->(vtune),
    (navidota)-[:PLAYER]->(generaL),

    (niko: Player {name: 'Никола Ковач', nickname: 'NiKo', country: 'Босния и Герцеговина', age: 24}),
    (hunter: Player {name: 'Неманья Ковач', nickname: 'huNter-', country: 'Босния и Герцеговина', age: 25}),
    (amanek: Player {name: 'Франсуа Делоне', nickname: 'AmaNEk', country: 'Франция', age: 28}),
    (g2csgo)-[:PLAYER]->(niko),
    (g2csgo)-[:PLAYER]->(hunter),
    (g2csgo)-[:PLAYER]->(amanek),

    (topson: Player {name: 'Топиас Миикка', nickname: 'Topson', country: 'Финляндия', age: 23}),
    (ceb: Player {name: 'Себастьян Феликс Альбер', nickname: 'Ceb', country: 'Франция', age: 29}),
    (notail: Player {name: 'Йохан Сундштайн', nickname: 'N0tail', country: 'Дания', age: 28}),
    (ogdota)-[:PLAYER]->(topson),
    (ogdota)-[:PLAYER]->(ceb),
    (ogdota)-[:PLAYER]->(notail),

    (nothing: Player {name: 'Джордан Гилберт', nickname: 'n0thing', country: 'США', age: 31}),
    (shroud: Player {name: 'Майк Гржезик', nickname: 'shroud', country: 'Канада', age: 27}),
    (hiko: Player {name: 'Спенсер Мартин', nickname: 'Hiko', country: 'США', age: 31}),
    (cloudcsgo)-[:PLAYER]->(nothing),
    (cloudcsgo)-[:PLAYER]->(shroud),
    (cloudcsgo)-[:PLAYER]->(hiko);


MATCH (p: Player) RETURN p;

MATCH (t: Team)-[: PLAYER]->(p: Player) WHERE t.name='CLOUD9' RETURN p.name AS player_name, t.name AS team_name;

MATCH (p: Player) WHERE p.age < 25 RETURN p.name, p.age;

MATCH (o: Organization) WHERE o.location='Германия' RETURN o;

MATCH (o: Organization)-[: TEAM]->(t: Team)-[: GAME]->(g: Game) WHERE g.name = 'CSGO' RETURN o;

MATCH (o :Organization)-[: TEAM]->(t: Team)-[: PLAYER]->(p: Player) WHERE o.location = p.country  RETURN p.name AS player, p.country, o.name AS organization, o.location;

MATCH (t: Team)-[: PLAYER]->(p: Player) WHERE p.age <= 30 AND p.age >= 25 AND p.country='Украина'  RETURN t;

MATCH (p1: Player) WITH max(p1.age) as max_age MATCH (p2: Player) WITH p2, max_age WHERE p2.age=max_age RETURN COUNT(p2), max_age;

MATCH (t: Team)-[: GAME]->(g: Game) WHERE g.name = 'CSGO' RETURN COUNT(t) AS number_of_csgo_teams;

MATCH (o: Organization)-[: TEAM]->(t: Team)-[: GAME]->(g: Game) WHERE g.name = 'DOTA2' AND o.location = 'Европа' RETURN t.name AS team_name, o.name AS organization_name, o.location AS organization_location, g.name AS game;


MATCH ()-[r]-() DELETE r;

MATCH (n) DELETE n;