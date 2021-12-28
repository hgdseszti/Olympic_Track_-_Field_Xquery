# Olympic_Track_and_Field_Xquery
### Olympic Track & Field Results (Kaggle) - https://www.kaggle.com/jayrav13/olympic-track-field-results


#### XQuery lekérdezések


**1. lekérdezés:**

A lekérdezés visszaadja az olimpiai játékok számát 1896 és 2016 között:

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

let $json := fn:json-doc("./olympic_results.json")?*

return fn:count($json?games)
```
**Eredmény:**
```json
47
```

**2. lekérdezés:**

A lekérdezés visszaadja a részt vevő helyszínek nevét.

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:indent "yes";

let $json := fn:json-doc("./olympic_results.json")?*

return array {
    distinct-values(
        for $game in $json?games?*
            return $game?location
    )
}
```
**Eredmény:**
```json
[
        "Rio",
        "Beijing",
        "Sydney",
        "Barcelona",
        "Los Angeles",
        "Montreal",
        "Mexico",
        "Rome",
        "Helsinki",
        "Berlin",
        "Amsterdam",
        "Antwerp",
        "London",
        "Athens",
        "Atlanta",
        "Moscow",
        "Munich",
        "Tokyo",
        "Melbourne \/ Stockholm",
        "Paris",
        "Stockholm",
        "St Louis",
        "Seoul"
    ]
```

**3. lekérdezés:**

A lekérdezés visszaadja, hogy a 2016-os olimpiai játékokon milyen nemzetiségek vettek részt.

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:indent "yes";

let $json := fn:json-doc("../olympic_results.json")?*

return array {
    distinct-values(
        for $game in $json?games?*
        where $game?year eq xs:double("2016")
            for $result in $game?results?*
                return $result?nationality
    )
}
```
**Eredmény:**
```json
[
        "USA",
        "KEN",
        "ETH",
        "JAM",
        "CAN",
        "ESP",
        "FRA",
        "ALG",
        "NZL",
        "CHN",
        "AUS",
        "TUR",
        "RSA",
        "GRN",
        "JPN",
        "BAH",
        "GBR",
        "SVK",
        "GER",
        "POL",
        "TJK",
        "BLR",
        "QAT",
        "UKR",
        "TTO",
        "BRA",
        "NED",
        "MEX",
        "BRN",
        "DEN",
        "BDI",
        "CRO",
        "CUB",
        "BEL",
        "BUL",
        "CZE",
        "SRB",
        "GRE",
        "HUN",
        "COL",
        "VEN",
        "KAZ"
    ]
```

**4. lekérdezés:**

A lekérdezés visszaadja, hogy egy adott évben (2016) hány arany érmet szerzett az USA.

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:indent "yes";

let $json := fn:json-doc("./olympic_results.json")?*

let $games := $json?games?*

let $temp-array := array:join($games[?year = 2016]?results)
let $filtered-array := array:for-each($temp-array, function($value) {
    xs:integer(fn:exists(($value[?medal = 'G' and ?nationality = 'USA'])))
})

return map{'2016': fn:sum($filtered-array)}
```
**Eredmény:**
```json
{ 
        "2016": 14 }
```

**5. lekérdezés:**

A lekérdezés visszaadja, hogy az egyes helyszíneken hány arany érmet szereztek összesen.

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:indent "yes";

declare function local:get-games() {
    let $json := fn:json-doc("./olympic_results.json")?*
    let $games :=  $json?games?*
    return $games
};

declare function local:get-gold-medal-count($location) {
    let $result := count(local:get-games()[?location = $location and ?results(1)?medal = "G"])
    return $result
};

let $locations := array { fn:distinct-values(local:get-games()?location) }

return array:for-each($locations, function($location) {
    map {
        "Location": $location,
        "Gold_medals": local:get-gold-medal-count($location)
    }
})
```
**Eredmény:**
```json
[
        { 
            "Location": "Rio",
            "Gold_medals": 47 },
        { 
            "Location": "Beijing",
            "Gold_medals": 46 },
        { 
            "Location": "Sydney",
            "Gold_medals": 45 },
        { 
            "Location": "Barcelona",
            "Gold_medals": 41 },
        { 
            "Location": "Los Angeles",
            "Gold_medals": 60 },
        { 
            "Location": "Montreal",
            "Gold_medals": 32 },
        { 
            "Location": "Mexico",
            "Gold_medals": 25 },
        { 
            "Location": "Rome",
            "Gold_medals": 33 },
        { 
            "Location": "Helsinki",
            "Gold_medals": 31 },
        { 
            "Location": "Berlin",
            "Gold_medals": 22 },
        { 
            "Location": "Amsterdam",
            "Gold_medals": 19 },
        { 
            "Location": "Antwerp",
            "Gold_medals": 14 },
        { 
            "Location": "London",
            "Gold_medals": 83 },
        { 
            "Location": "Athens",
            "Gold_medals": 58 },
        { 
            "Location": "Atlanta",
            "Gold_medals": 43 },
        { 
            "Location": "Moscow",
            "Gold_medals": 37 },
        { 
            "Location": "Munich",
            "Gold_medals": 27 },
        { 
            "Location": "Tokyo",
            "Gold_medals": 34 },
        { 
            "Location": "Melbourne \/ Stockholm",
            "Gold_medals": 19 },
        { 
            "Location": "Paris",
            "Gold_medals": 37 },
        { 
            "Location": "Stockholm",
            "Gold_medals": 20 },
        { 
            "Location": "St Louis",
            "Gold_medals": 17 },
        { 
            "Location": "Seoul",
            "Gold_medals": 6 }
    ]
```
**6. lekérdezés:**

A lekérdezés egy XML dokumentumot állít elő, amely abc sorrendben tartalmazza az összes versenyző nevét, aki érmet szerzett valaha az olimpián.

```xquery
xquery version "3.1";

import schema default element namespace "" at "6_feladat.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:indent "yes";
let $json := fn:json-doc("../olympic_results.json")?*

let $versenyzok := distinct-values(
        for $game in $json?games?*
            for $result in $game?results?*
                return $result?name
)

return validate {document {
            <VERSENYZOK ALL="{fn:count($versenyzok)}">
                {
                    for $versenyzo in $versenyzok
                    order by $versenyzo ascending
                    return <VERSENYZO NAME="{$versenyzo}"/>
                }
            </VERSENYZOK>
        }}
```
**Eredmény:**
```xml
<VERSENYZOK ALL="1681">
    <VERSENYZO NAME="Abdalaati IGUIDER"/>
    <VERSENYZO NAME="Abderrahmane HAMMAD"/>
    <VERSENYZO NAME="Abdesiem RHADI BEN ABDESSELEM"/>
    <VERSENYZO NAME="Abdon PAMICH"/>
    <VERSENYZO NAME="Abdoulaye SEYE"/>
    <VERSENYZO NAME="Abebe BIKILA"/>
    <VERSENYZO NAME="Abel KIRUI"/>
    <VERSENYZO NAME="Abel KIVIAT"/>
    <VERSENYZO NAME="Abel Kiprop MUTAI"/>
    <VERSENYZO NAME="Adalberts BUBENKO"/>
    <VERSENYZO NAME="Adam GUNN"/>
    <VERSENYZO NAME="Adam NELSON"/>
    <VERSENYZO NAME="Addis ABEBE"/>
    <VERSENYZO NAME="Adhemar DA SILVA"/>
    <VERSENYZO NAME="Adolfo CONSOLINI"/>
    <VERSENYZO NAME="Aigars FADEJEVS"/>
    <VERSENYZO NAME="Ainars KOVALS"/>
    <VERSENYZO NAME="Aki JÃ&#x84;RVINEN"/>
    <VERSENYZO NAME="Al BATES"/>
    <VERSENYZO NAME="Al OERTER"/>
    <VERSENYZO NAME="Alain MIMOUN"/>
    <VERSENYZO NAME="Alajos SZOKOLYI"/>
    <VERSENYZO NAME="Albert CORAY"/>
    <VERSENYZO NAME="Albert GUTTERSON"/>
    <VERSENYZO NAME="Albert HILL"/>
    <VERSENYZO NAME="Albert TYLER"/>
    <VERSENYZO NAME="Alberto COVA"/>
    <VERSENYZO NAME="Alberto JUANTORENA"/>
    <VERSENYZO NAME="Albin LERMUSIAUX"/>
    <VERSENYZO NAME="Albin STENROOS"/>
    <VERSENYZO NAME="Alejandro CASAÃ&#x91;AS"/>
    <VERSENYZO NAME="Aleksander TAMMERT"/>
    <VERSENYZO NAME="Aleksandr ANUFRIYEV"/>
    <VERSENYZO NAME="Aleksandr BARYSHNIKOV"/>
    <VERSENYZO NAME="Aleksandr MAKAROV"/>
    <VERSENYZO NAME="Aleksandr PUCHKOV"/>
    <VERSENYZO NAME="Aleksandra CHUDINA"/>
    <VERSENYZO NAME="Aleksei SPIRIDONOV"/>
    <VERSENYZO NAME="Aleksey VOYEVODIN"/>
    <VERSENYZO NAME="Alessandro ANDREI"/>
    <VERSENYZO NAME="Alessandro LAMBRUSCHINI"/>
    <VERSENYZO NAME="Alex SCHWAZER"/>
    <VERSENYZO NAME="Alex WILSON"/>
    <VERSENYZO NAME="Alexander KLUMBERG-KOLMPERE"/>
    <VERSENYZO NAME="Alexandre TUFFERI"/>
    <VERSENYZO NAME="Alfred Carleten GILBERT"/>
    <VERSENYZO NAME="Alfred DOMPERT"/>
    <VERSENYZO NAME="Alfred Kirwa YEGO"/>
    <VERSENYZO NAME="Alfred TYSOE"/>
    <VERSENYZO NAME="Ali EZZINE"/>
    <VERSENYZO NAME="Ali SAIDI-SIEF"/>
    <VERSENYZO NAME="Alice BROWN"/>
    <VERSENYZO NAME="Alice COACHMAN"/>
    <VERSENYZO NAME="Allan LAWRENCE"/>
    <VERSENYZO NAME="Allan WELLS"/>
    <VERSENYZO NAME="Allen JOHNSON"/>
    <VERSENYZO NAME="Allen WOODRING"/>
    <VERSENYZO NAME="Allyson FELIX"/>
    <VERSENYZO NAME="Alma RICHARDS"/>
    <VERSENYZO NAME="Almaz AYANA"/>
    <VERSENYZO NAME="Alonzo BABERS"/>
    <VERSENYZO NAME="Alvah MEYER"/>
    <VERSENYZO NAME="Alvin HARRISON"/>
    <VERSENYZO NAME="Alvin KRAENZLEIN"/>
    <VERSENYZO NAME="Amos BIWOTT"/>
    <VERSENYZO NAME="Ana Fidelia QUIROT"/>
    <VERSENYZO NAME="Ana GUEVARA"/>
    <VERSENYZO NAME="Anastasia KELESIDOU"/>
    <VERSENYZO NAME="Anatoli BONDARCHUK"/>
    <VERSENYZO NAME="Anatoly MIKHAYLOV"/>
    <VERSENYZO NAME="Anders GARDERUD"/>
    <VERSENYZO NAME="Andre DE GRASSE"/>
    <VERSENYZO NAME="Andreas THORKILDSEN"/>
    <VERSENYZO NAME="Andrei KRAUCHANKA"/>
    <VERSENYZO NAME="Andrei TIVONTCHIK"/>
    <VERSENYZO NAME="Andrey ABDUVALIEV"/>
    <VERSENYZO NAME="Andrey PERLOV"/>
    <VERSENYZO NAME="Andrey SILNOV"/>
    <VERSENYZO NAME="Andrzej BADENSKI"/>
    <VERSENYZO NAME="Andy STANFIELD"/>
    <VERSENYZO NAME="Angela NEMETH"/>
    <VERSENYZO NAME="Angela VOIGT"/>
    <VERSENYZO NAME="Angelo TAYLOR"/>
    <VERSENYZO NAME="Anier GARCIA"/>
    <VERSENYZO NAME="Anita MARTON"/>
    <VERSENYZO NAME="Anita WLODARCZYK"/>
    <VERSENYZO NAME="Anke BEHMER"/>
    <VERSENYZO NAME="Ann Marise CHAMBERLAIN"/>
    <VERSENYZO NAME="Ann PACKER"/>
    <VERSENYZO NAME="Anna CHICHEROVA"/>
    <VERSENYZO NAME="Anna ROGOWSKA"/>
    <VERSENYZO NAME="Annegret RICHTER-IRRGANG"/>
    <VERSENYZO NAME="Annelie EHRHARDT"/>
    <VERSENYZO NAME="Antal KISS"/>
    <VERSENYZO NAME="Antal RÃ&#x93;KA"/>
    <VERSENYZO NAME="Antanas MIKENAS"/>
    <VERSENYZO NAME="Antonio MCKAY"/>
    <VERSENYZO NAME="Antonio PENALVER ASENSIO"/>
    <VERSENYZO NAME="Antti RUUSKANEN"/>
    <VERSENYZO NAME="AntÃ³nio LEITÃ&#x83;O"/>
    <VERSENYZO NAME="Archibald Franklin WILLIAMS"/>
    <VERSENYZO NAME="Archie HAHN"/>
    <VERSENYZO NAME="Ardalion IGNATYEV"/>
    <VERSENYZO NAME="Argentina MENIS"/>
    <VERSENYZO NAME="Aries MERRITT"/>
    <VERSENYZO NAME="Armas TAIPALE"/>
    <VERSENYZO NAME="Armas TOIVONEN"/>
    <VERSENYZO NAME="Armin HARY"/>
    <VERSENYZO NAME="Arne HALSE"/>
    <VERSENYZO NAME="Arnie ROBINSON"/>
    <VERSENYZO NAME="Arnold JACKSON"/>
    <VERSENYZO NAME="Arnoldo DEVONISH"/>
    <VERSENYZO NAME="Arsi HARJU"/>
    <VERSENYZO NAME="Arthur BARNARD"/>
    <VERSENYZO NAME="Arthur BLAKE"/>
    <VERSENYZO NAME="Arthur JONATH"/>
    <VERSENYZO NAME="Arthur NEWTON"/>
    <VERSENYZO NAME="Arthur PORRITT"/>
    <VERSENYZO NAME="Arthur SCHWAB"/>
    <VERSENYZO NAME="Arthur SHAW"/>
    <VERSENYZO NAME="Arthur WINT"/>
    <VERSENYZO NAME="Arto BRYGGARE"/>
    <VERSENYZO NAME="Arto HÃ&#x84;RKÃ&#x96;NEN"/>
    <VERSENYZO NAME="Artur PARTYKA"/>
    <VERSENYZO NAME="Arvo ASKOLA"/>
    <VERSENYZO NAME="Asbel Kipruto KIPROP"/>
    <VERSENYZO NAME="Ashley SPENCER"/>
    <VERSENYZO NAME="Ashton EATON"/>
    <VERSENYZO NAME="Assefa MEZGEBU"/>
    <VERSENYZO NAME="Astrid KUMBERNUSS"/>
    <VERSENYZO NAME="Athanasia TSOUMELEKA"/>
    <VERSENYZO NAME="Ato BOLDON"/>
    <VERSENYZO NAME="Audrey PATTERSON"/>
    <VERSENYZO NAME="Audrey WILLIAMSON"/>
    <VERSENYZO NAME="Audun BOYSEN"/>
    <VERSENYZO NAME="August DESCH"/>
    <VERSENYZO NAME="Austra SKUJYTE"/>
    <VERSENYZO NAME="BalÃ¡zs KISS"/>
    <VERSENYZO NAME="Barbara FERRELL"/>
    <VERSENYZO NAME="Barbora SPOTAKOVA"/>
    <VERSENYZO NAME="Barney EWELL"/>
    <VERSENYZO NAME="Barry MAGEE"/>
    <VERSENYZO NAME="Basil HEATLEY"/>
    <VERSENYZO NAME="Ben JIPCHO"/>
    <VERSENYZO NAME="Ben JOHNSON"/>
    <VERSENYZO NAME="Benita FITZGERALD-BROWN"/>
    <VERSENYZO NAME="Benjamin Bangs EASTMAN"/>
    <VERSENYZO NAME="Benjamin KOGO"/>
    <VERSENYZO NAME="Bernard LAGAT"/>
    <VERSENYZO NAME="Bernard WILLIAMS III"/>
    <VERSENYZO NAME="Bernardo SEGURA"/>
    <VERSENYZO NAME="Bernd KANNENBERG"/>
    <VERSENYZO NAME="Bershawn JACKSON"/>
    <VERSENYZO NAME="Bertha BROUWER"/>
    <VERSENYZO NAME="Bertil ALBERTSSON"/>
    <VERSENYZO NAME="Bertil OHLSON"/>
    <VERSENYZO NAME="Bertil UGGLA"/>
    <VERSENYZO NAME="Betty CUTHBERT"/>
    <VERSENYZO NAME="Betty HEIDLER"/>
    <VERSENYZO NAME="Beverly MCDONALD"/>
    <VERSENYZO NAME="Bevil RUDD"/>
    <VERSENYZO NAME="Bill DELLINGER"/>
    <VERSENYZO NAME="Bill PORTER"/>
    <VERSENYZO NAME="Bill TOOMEY"/>
    <VERSENYZO NAME="Billy MILLS"/>
    <VERSENYZO NAME="Bin DONG"/>
    <VERSENYZO NAME="Birute KALEDIENE"/>
    <VERSENYZO NAME="Bjorn OTTO"/>
    <VERSENYZO NAME="Blaine LINDGREN"/>
    <VERSENYZO NAME="Blanka VLASIC"/>
    <VERSENYZO NAME="Blessing OKAGBARE"/>
    <VERSENYZO NAME="Bo GUSTAFSSON"/>
    <VERSENYZO NAME="Bob HAYES"/>
    <VERSENYZO NAME="Bob MATHIAS"/>
    <VERSENYZO NAME="Bob RICHARDS"/>
    <VERSENYZO NAME="Bobby MORROW"/>
    <VERSENYZO NAME="Bodo TÃ&#x9c;MMLER"/>
    <VERSENYZO NAME="Bohdan BONDARENKO"/>
    <VERSENYZO NAME="Bong Ju LEE"/>
    <VERSENYZO NAME="Boniface MUCHERU"/>
    <VERSENYZO NAME="BoughÃ¨ra EL OUAFI"/>
    <VERSENYZO NAME="Brahim LAHLAFI"/>
    <VERSENYZO NAME="Brenda JONES"/>
    <VERSENYZO NAME="Brendan FOSTER"/>
    <VERSENYZO NAME="Brian Lee DIEMER"/>
    <VERSENYZO NAME="Brianna ROLLINS"/>
    <VERSENYZO NAME="Brianne THEISEN EATON"/>
    <VERSENYZO NAME="Brigetta BARRETT"/>
    <VERSENYZO NAME="Brigita BUKOVEC"/>
    <VERSENYZO NAME="Brigitte WUJAK"/>
    <VERSENYZO NAME="Brimin Kiprop KIPRUTO"/>
    <VERSENYZO NAME="Brittney REESE"/>
    <VERSENYZO NAME="Bronislaw MALINOWSKI"/>
    <VERSENYZO NAME="Bruce JENNER"/>
    <VERSENYZO NAME="Bruno JUNK"/>
    <VERSENYZO NAME="Bruno SÃ&#x96;DERSTRÃ&#x96;M"/>
    <VERSENYZO NAME="Brutus HAMILTON"/>
    <VERSENYZO NAME="Bryan CLAY"/>
    <VERSENYZO NAME="Bud HOUSER"/>
    <VERSENYZO NAME="BÃ¤rbel ECKERT-WÃ&#x96;CKEL"/>
    <VERSENYZO NAME="Calvin BRICKER"/>
    <VERSENYZO NAME="Calvin DAVIS"/>
    <VERSENYZO NAME="Carl Albert ANDERSEN"/>
    <VERSENYZO NAME="Carl KAUFMANN"/>
    <VERSENYZO NAME="Carl LEWIS"/>
    <VERSENYZO NAME="Carlos LOPES"/>
    <VERSENYZO NAME="Carlos MERCENARIO"/>
    <VERSENYZO NAME="Carmelita JETER"/>
    <VERSENYZO NAME="Carolina KLUFT"/>
    <VERSENYZO NAME="Caster SEMENYA"/>
    <VERSENYZO NAME="Caterine IBARGUEN"/>
    <VERSENYZO NAME="Catherine Laverne MCMILLAN"/>
    <VERSENYZO NAME="Catherine NDEREBA"/>
    <VERSENYZO NAME="Cathy FREEMAN"/>
    <VERSENYZO NAME="Chandra CHEESEBOROUGH"/>
    <VERSENYZO NAME="Charles AUSTIN"/>
    <VERSENYZO NAME="Charles BACON"/>
    <VERSENYZO NAME="Charles BENNETT"/>
    <VERSENYZO NAME="Charles DVORAK"/>
    <VERSENYZO NAME="Charles GMELIN"/>
    <VERSENYZO NAME="Charles HEFFERON"/>
    <VERSENYZO NAME="Charles Hewes Jr. MOORE"/>
    <VERSENYZO NAME="Charles JACOBS"/>
    <VERSENYZO NAME="Charles JENKINS"/>
    <VERSENYZO NAME="Charles LOMBERG"/>
    <VERSENYZO NAME="Charles PADDOCK"/>
    <VERSENYZO NAME="Charles REIDPATH"/>
    <VERSENYZO NAME="Charles SIMPKINS"/>
    <VERSENYZO NAME="Charles SPEDDING"/>
    <VERSENYZO NAME="Charlie GREENE"/>
    <VERSENYZO NAME="Chioma AJUNWA"/>
    <VERSENYZO NAME="Chris HUFFINS"/>
    <VERSENYZO NAME="Christa STUBNICK"/>
    <VERSENYZO NAME="Christian CANTWELL"/>
    <VERSENYZO NAME="Christian OLSSON"/>
    <VERSENYZO NAME="Christian SCHENK"/>
    <VERSENYZO NAME="Christian TAYLOR"/>
    <VERSENYZO NAME="Christian W. GITSHAM"/>
    <VERSENYZO NAME="Christiane STOLL-WARTENBERG"/>
    <VERSENYZO NAME="Christina BREHMER-LATHAN"/>
    <VERSENYZO NAME="Christina OBERGFOLL"/>
    <VERSENYZO NAME="Christine OHURUOGU"/>
    <VERSENYZO NAME="Christoph HARTING"/>
    <VERSENYZO NAME="Christoph HÃ&#x96;HNE"/>
    <VERSENYZO NAME="Christophe LEMAITRE"/>
    <VERSENYZO NAME="Christopher William BRASHER"/>
    <VERSENYZO NAME="Chuan-Kwang YANG"/>
    <VERSENYZO NAME="Chuhei NAMBU"/>
    <VERSENYZO NAME="Chunxiu ZHOU"/>
    <VERSENYZO NAME="Clarence CHILDS"/>
    <VERSENYZO NAME="Clarence DEMAR"/>
    <VERSENYZO NAME="Claudia LOSCH"/>
    <VERSENYZO NAME="Clayton MURPHY"/>
    <VERSENYZO NAME="Clifton Emmett CUSHMAN"/>
    <VERSENYZO NAME="Clyde SCOTT"/>
    <VERSENYZO NAME="Colette BESSON"/>
    <VERSENYZO NAME="Conseslus KIPRUTO"/>
    <VERSENYZO NAME="Constantina TOMESCU"/>
    <VERSENYZO NAME="Cornelius LEAHY"/>
    <VERSENYZO NAME="Cornelius WALSH"/>
    <VERSENYZO NAME="Craig DIXON"/>
    <VERSENYZO NAME="Cristina COJOCARU"/>
    <VERSENYZO NAME="Cy YOUNG"/>
    <VERSENYZO NAME="Dafne SCHIPPERS"/>
    <VERSENYZO NAME="Dainis KULA"/>
    <VERSENYZO NAME="Daley THOMPSON"/>
    <VERSENYZO NAME="Dalilah MUHAMMAD"/>
    <VERSENYZO NAME="Dallas LONG"/>
    <VERSENYZO NAME="Damian WARNER"/>
    <VERSENYZO NAME="Dan O'BRIEN"/>
    <VERSENYZO NAME="Dana INGROVA-ZATOPKOVA"/>
    <VERSENYZO NAME="Dane BIRD-SMITH"/>
    <VERSENYZO NAME="Daniel BAUTISTA ROCHA"/>
    <VERSENYZO NAME="Daniel FRANK"/>
    <VERSENYZO NAME="Daniel JASINSKI"/>
    <VERSENYZO NAME="Daniel KELLY"/>
    <VERSENYZO NAME="Daniel KINSEY"/>
    <VERSENYZO NAME="Daniel PLAZA"/>
    <VERSENYZO NAME="Daniela COSTIAN"/>
    <VERSENYZO NAME="Daniil Sergeyevich BURKENYA"/>
    <VERSENYZO NAME="Danny HARRIS"/>
    <VERSENYZO NAME="Danny MCFARLANE"/>
    <VERSENYZO NAME="Daphne HASENJAGER"/>
    <VERSENYZO NAME="Darren CAMPBELL"/>
    <VERSENYZO NAME="Darrow Clarence HOOPER"/>
    <VERSENYZO NAME="Dave JOHNSON"/>
    <VERSENYZO NAME="Dave LAUT"/>
    <VERSENYZO NAME="Dave SIME"/>
    <VERSENYZO NAME="Dave STEEN"/>
    <VERSENYZO NAME="David George BURGHLEY"/>
    <VERSENYZO NAME="David HALL"/>
    <VERSENYZO NAME="David HEMERY"/>
    <VERSENYZO NAME="David James WOTTLE"/>
    <VERSENYZO NAME="David Lawson WEILL"/>
    <VERSENYZO NAME="David Lekuta RUDISHA"/>
    <VERSENYZO NAME="David NEVILLE"/>
    <VERSENYZO NAME="David OLIVER"/>
    <VERSENYZO NAME="David OTTLEY"/>
    <VERSENYZO NAME="David PAYNE"/>
    <VERSENYZO NAME="David POWER"/>
    <VERSENYZO NAME="David STORL"/>
    <VERSENYZO NAME="Davis KAMOGA"/>
    <VERSENYZO NAME="Dawn HARPER"/>
    <VERSENYZO NAME="Dayron ROBLES"/>
    <VERSENYZO NAME="Debbie FERGUSON-MCKENZIE"/>
    <VERSENYZO NAME="DeeDee TROTTER"/>
    <VERSENYZO NAME="Deena KASTOR"/>
    <VERSENYZO NAME="Dejen GEBREMESKEL"/>
    <VERSENYZO NAME="Delfo CABRERA"/>
    <VERSENYZO NAME="Denia CABALLERO"/>
    <VERSENYZO NAME="Denis HORGAN"/>
    <VERSENYZO NAME="Denis KAPUSTIN"/>
    <VERSENYZO NAME="Denis NIZHEGORODOV"/>
    <VERSENYZO NAME="Denise LEWIS"/>
    <VERSENYZO NAME="Dennis MITCHELL"/>
    <VERSENYZO NAME="Deon Marie HEMMINGS"/>
    <VERSENYZO NAME="Derartu TULU"/>
    <VERSENYZO NAME="Derek DROUIN"/>
    <VERSENYZO NAME="Derek IBBOTSON"/>
    <VERSENYZO NAME="Derek JOHNSON"/>
    <VERSENYZO NAME="Derrick ADKINS"/>
    <VERSENYZO NAME="Derrick BREW"/>
    <VERSENYZO NAME="Dick Theodorus QUAX"/>
    <VERSENYZO NAME="Dieter BAUMANN"/>
    <VERSENYZO NAME="Dieter LINDNER"/>
    <VERSENYZO NAME="Dilshod NAZAROV"/>
    <VERSENYZO NAME="Dimitri BASCOU"/>
    <VERSENYZO NAME="Dimitrios GOLEMIS"/>
    <VERSENYZO NAME="Ding CHEN"/>
    <VERSENYZO NAME="Djabir SAID GUERNI"/>
    <VERSENYZO NAME="Dmitriy KARPOV"/>
    <VERSENYZO NAME="Doina MELINTE"/>
    <VERSENYZO NAME="Don BRAGG"/>
    <VERSENYZO NAME="Don LAZ"/>
    <VERSENYZO NAME="Donald FINLAY"/>
    <VERSENYZO NAME="Donald James THOMPSON"/>
    <VERSENYZO NAME="Donald LIPPINCOTT"/>
    <VERSENYZO NAME="Donald QUARRIE"/>
    <VERSENYZO NAME="Donovan BAILEY"/>
    <VERSENYZO NAME="Dorothy HALL"/>
    <VERSENYZO NAME="Dorothy HYMAN"/>
    <VERSENYZO NAME="Dorothy ODAM"/>
    <VERSENYZO NAME="Dorothy SHIRLEY"/>
    <VERSENYZO NAME="Douglas LOWE"/>
    <VERSENYZO NAME="Douglas WAKIIHURI"/>
    <VERSENYZO NAME="Duncan GILLIS"/>
    <VERSENYZO NAME="Duncan MCNAUGHTON"/>
    <VERSENYZO NAME="Duncan WHITE"/>
    <VERSENYZO NAME="Dwayne Eugene EVANS"/>
    <VERSENYZO NAME="Dwight PHILLIPS"/>
    <VERSENYZO NAME="Dwight STONES"/>
    <VERSENYZO NAME="Dylan ARMSTRONG"/>
    <VERSENYZO NAME="Earl EBY"/>
    <VERSENYZO NAME="Earl JONES"/>
    <VERSENYZO NAME="Earl THOMSON"/>
    <VERSENYZO NAME="Earlene BROWN"/>
    <VERSENYZO NAME="Eddie SOUTHERN"/>
    <VERSENYZO NAME="Eddie TOLAN"/>
    <VERSENYZO NAME="Eddy OTTOZ"/>
    <VERSENYZO NAME="Edera CORDIALE-GENTILE"/>
    <VERSENYZO NAME="Edith MCGUIRE"/>
    <VERSENYZO NAME="Edvard LARSEN"/>
    <VERSENYZO NAME="Edvin WIDE"/>
    <VERSENYZO NAME="Edward ARCHIBALD"/>
    <VERSENYZO NAME="Edward Barton HAMM"/>
    <VERSENYZO NAME="Edward COOK"/>
    <VERSENYZO NAME="Edward LINDBERG"/>
    <VERSENYZO NAME="Edward Lansing GORDON"/>
    <VERSENYZO NAME="Edward Orval GOURDIN"/>
    <VERSENYZO NAME="Edwin Cheruiyot SOI"/>
    <VERSENYZO NAME="Edwin FLACK"/>
    <VERSENYZO NAME="Edwin MOSES"/>
    <VERSENYZO NAME="Edwin ROBERTS"/>
    <VERSENYZO NAME="Eeles LANDSTRÃ&#x96;M"/>
    <VERSENYZO NAME="Eero BERG"/>
    <VERSENYZO NAME="Ehsan HADADI"/>
    <VERSENYZO NAME="Eino PENTTILÃ&#x84;"/>
    <VERSENYZO NAME="Eino PURJE"/>
    <VERSENYZO NAME="Ejegayehu DIBABA"/>
    <VERSENYZO NAME="Ekaterina POISTOGOVA"/>
    <VERSENYZO NAME="Ekaterini STEFANIDI"/>
    <VERSENYZO NAME="Ekaterini THANOU"/>
    <VERSENYZO NAME="Elaine THOMPSON"/>
    <VERSENYZO NAME="Elana MEYER"/>
    <VERSENYZO NAME="Elena LASHMANOVA"/>
    <VERSENYZO NAME="Elena SLESARENKO"/>
    <VERSENYZO NAME="Elena SOKOLOVA"/>
    <VERSENYZO NAME="Elfi ZINN"/>
    <VERSENYZO NAME="Elfriede KAUN"/>
    <VERSENYZO NAME="Elias KATZ"/>
    <VERSENYZO NAME="Elisa RIGAUDO"/>
    <VERSENYZO NAME="Eliud Kipchoge ROTICH"/>
    <VERSENYZO NAME="Eliza MCCARTNEY"/>
    <VERSENYZO NAME="Elizabeth ROBINSON"/>
    <VERSENYZO NAME="Ellen BRAUMÃ&#x9c;LLER"/>
    <VERSENYZO NAME="Ellen STROPAHL-STREIDT"/>
    <VERSENYZO NAME="Ellen VAN LANGEN"/>
    <VERSENYZO NAME="Ellery CLARK"/>
    <VERSENYZO NAME="Ellina ZVEREVA"/>
    <VERSENYZO NAME="Elvan ABEYLEGESSE"/>
    <VERSENYZO NAME="Elvira OZOLINA"/>
    <VERSENYZO NAME="Elzbieta KRZESINSKA"/>
    <VERSENYZO NAME="Emerson NORTON"/>
    <VERSENYZO NAME="Emiel PUTTEMANS"/>
    <VERSENYZO NAME="Emil BREITKREUTZ"/>
    <VERSENYZO NAME="Emil ZÃ&#x81;TOPEK"/>
    <VERSENYZO NAME="Emilio LUNGHI"/>
    <VERSENYZO NAME="Emma COBURN"/>
    <VERSENYZO NAME="Emmanuel McDONALD BAILEY"/>
    <VERSENYZO NAME="Enrique FIGUEROLA"/>
    <VERSENYZO NAME="Eric BACKMAN"/>
    <VERSENYZO NAME="Eric LEMMING"/>
    <VERSENYZO NAME="Eric LIDDELL"/>
    <VERSENYZO NAME="Eric SVENSSON"/>
    <VERSENYZO NAME="Erick BARRONDO"/>
    <VERSENYZO NAME="Erick WAINAINA"/>
    <VERSENYZO NAME="Erik ALMLÃ&#x96;F"/>
    <VERSENYZO NAME="Erik BYLÃ&#x89;HN"/>
    <VERSENYZO NAME="Erik KYNARD"/>
    <VERSENYZO NAME="Erki NOOL"/>
    <VERSENYZO NAME="Erkka WILEN"/>
    <VERSENYZO NAME="Ernest HARPER"/>
    <VERSENYZO NAME="Ernesto AMBROSINI"/>
    <VERSENYZO NAME="Ernesto CANTO"/>
    <VERSENYZO NAME="Ernst FAST"/>
    <VERSENYZO NAME="Ernst LARSEN"/>
    <VERSENYZO NAME="Ernst SCHULTZ"/>
    <VERSENYZO NAME="Ervin HALL"/>
    <VERSENYZO NAME="Esfira DOLCHENKO-KRACHEVSKAYA"/>
    <VERSENYZO NAME="Eshetu TURA"/>
    <VERSENYZO NAME="Esref APAK"/>
    <VERSENYZO NAME="Esther BRAND"/>
    <VERSENYZO NAME="Ethel SMITH"/>
    <VERSENYZO NAME="Etienne GAILLY"/>
    <VERSENYZO NAME="Eugene OBERST"/>
    <VERSENYZO NAME="Eunice JEPKORIR"/>
    <VERSENYZO NAME="Eunice Jepkirui KIRWA"/>
    <VERSENYZO NAME="Eva DAWES"/>
    <VERSENYZO NAME="Eva JANKO-EGGER"/>
    <VERSENYZO NAME="Evan JAGER"/>
    <VERSENYZO NAME="Evangelos DAMASKOS"/>
    <VERSENYZO NAME="Evelin SCHLAAK-JAHL"/>
    <VERSENYZO NAME="Evelyn ASHFORD"/>
    <VERSENYZO NAME="Evgeniy LUKYANENKO"/>
    <VERSENYZO NAME="Ewa KLOBUKOWSKA"/>
    <VERSENYZO NAME="Ezekiel KEMBOI"/>
    <VERSENYZO NAME="Fabrizio DONATO"/>
    <VERSENYZO NAME="Faina MELNIK"/>
    <VERSENYZO NAME="Faith Chepngetich KIPYEGON"/>
    <VERSENYZO NAME="Falilat OGUNKOYA"/>
    <VERSENYZO NAME="Fani KHALKIA"/>
    <VERSENYZO NAME="Fanny BLANKERS-KOEN"/>
    <VERSENYZO NAME="Fanny ROSENFELD"/>
    <VERSENYZO NAME="Fatuma ROBA"/>
    <VERSENYZO NAME="Felix SANCHEZ"/>
    <VERSENYZO NAME="Fermin CACHO RUIZ"/>
    <VERSENYZO NAME="Fernanda RIBEIRO"/>
    <VERSENYZO NAME="Feyisa LILESA"/>
    <VERSENYZO NAME="Filbert BAYI"/>
    <VERSENYZO NAME="Fiona MAY"/>
    <VERSENYZO NAME="Fita BAYISSA"/>
    <VERSENYZO NAME="Fita LOVIN"/>
    <VERSENYZO NAME="Florence GRIFFITH JOYNER"/>
    <VERSENYZO NAME="Florenta CRACIUNESCU"/>
    <VERSENYZO NAME="Florian SCHWARTHOFF"/>
    <VERSENYZO NAME="Floyd SIMMONS"/>
    <VERSENYZO NAME="Forrest SMITHSON"/>
    <VERSENYZO NAME="Forrest TOWNS"/>
    <VERSENYZO NAME="Francine NIYONSABA"/>
    <VERSENYZO NAME="Francis LANE"/>
    <VERSENYZO NAME="Francis OBIKWELU"/>
    <VERSENYZO NAME="Francisco Javier FERNANDEZ"/>
    <VERSENYZO NAME="Francoise MBANGO ETONE"/>
    <VERSENYZO NAME="Franjo MIHALIC"/>
    <VERSENYZO NAME="Frank BAUMGARTL"/>
    <VERSENYZO NAME="Frank BUSEMANN"/>
    <VERSENYZO NAME="Frank CUHEL"/>
    <VERSENYZO NAME="Frank Charles SHORTER"/>
    <VERSENYZO NAME="Frank FREDERICKS"/>
    <VERSENYZO NAME="Frank IRONS"/>
    <VERSENYZO NAME="Frank JARVIS"/>
    <VERSENYZO NAME="Frank LOOMIS"/>
    <VERSENYZO NAME="Frank MURPHY"/>
    <VERSENYZO NAME="Frank NELSON"/>
    <VERSENYZO NAME="Frank PASCHEK"/>
    <VERSENYZO NAME="Frank RUTHERFORD"/>
    <VERSENYZO NAME="Frank SCHAFFER"/>
    <VERSENYZO NAME="Frank WALLER"/>
    <VERSENYZO NAME="Frank WARTENBERG"/>
    <VERSENYZO NAME="Franti?ek DOUDA"/>
    <VERSENYZO NAME="Frantz KRUGER"/>
    <VERSENYZO NAME="Fred ENGELHARDT"/>
    <VERSENYZO NAME="Fred HANSEN"/>
    <VERSENYZO NAME="Fred ONYANCHA"/>
    <VERSENYZO NAME="Fred TOOTELL"/>
    <VERSENYZO NAME="Frederick KELLY"/>
    <VERSENYZO NAME="Frederick MOLONEY"/>
    <VERSENYZO NAME="Frederick MURRAY"/>
    <VERSENYZO NAME="Frederick SCHULE"/>
    <VERSENYZO NAME="Frederick Vaughn NEWHOUSE"/>
    <VERSENYZO NAME="Fritz Erik ELMSÃ&#x83;?TER"/>
    <VERSENYZO NAME="Fritz HOFMANN"/>
    <VERSENYZO NAME="Fritz POLLARD"/>
    <VERSENYZO NAME="Gabriel TIACOH"/>
    <VERSENYZO NAME="Gabriela SZABO"/>
    <VERSENYZO NAME="Gabriella DORIO"/>
    <VERSENYZO NAME="Gael MARTIN"/>
    <VERSENYZO NAME="Gail DEVERS"/>
    <VERSENYZO NAME="Galen RUPP"/>
    <VERSENYZO NAME="Galina ASTAFEI"/>
    <VERSENYZO NAME="Galina ZYBINA"/>
    <VERSENYZO NAME="Gamze BULUT"/>
    <VERSENYZO NAME="Garfield MACDONALD"/>
    <VERSENYZO NAME="Garrett SERVISS"/>
    <VERSENYZO NAME="Gary OAKES"/>
    <VERSENYZO NAME="Gaston GODEL"/>
    <VERSENYZO NAME="Gaston REIFF"/>
    <VERSENYZO NAME="Gaston ROELANTS"/>
    <VERSENYZO NAME="Gaston STROBINO"/>
    <VERSENYZO NAME="Gelindo BORDIN"/>
    <VERSENYZO NAME="Genzebe DIBABA"/>
    <VERSENYZO NAME="Georg ABERG"/>
    <VERSENYZO NAME="Georg LAMMERS"/>
    <VERSENYZO NAME="George HORINE"/>
    <VERSENYZO NAME="George HUTSON"/>
    <VERSENYZO NAME="George JEFFERSON"/>
    <VERSENYZO NAME="George KERR"/>
    <VERSENYZO NAME="George ORTON"/>
    <VERSENYZO NAME="George POAGE"/>
    <VERSENYZO NAME="George RHODEN"/>
    <VERSENYZO NAME="George SALING"/>
    <VERSENYZO NAME="George SIMPSON"/>
    <VERSENYZO NAME="George YOUNG"/>
    <VERSENYZO NAME="Georges ANDRE"/>
    <VERSENYZO NAME="Georgios PAPASIDERIS"/>
    <VERSENYZO NAME="Gerard NIJBOER"/>
    <VERSENYZO NAME="Gerd KANTER"/>
    <VERSENYZO NAME="Gerd WESSIG"/>
    <VERSENYZO NAME="Gergely KULCSÃ&#x81;R"/>
    <VERSENYZO NAME="Gerhard HENNIGE"/>
    <VERSENYZO NAME="Gerhard STÃ&#x96;CK"/>
    <VERSENYZO NAME="Germaine MASON"/>
    <VERSENYZO NAME="Gete WAMI"/>
    <VERSENYZO NAME="Gezahegne ABERA"/>
    <VERSENYZO NAME="Ghada SHOUAA"/>
    <VERSENYZO NAME="Gheorghe MEGELEA"/>
    <VERSENYZO NAME="Giovanni DE BENEDICTIS"/>
    <VERSENYZO NAME="Gisela MAUERMAYER"/>
    <VERSENYZO NAME="Giuseppe DORDONI"/>
    <VERSENYZO NAME="Giuseppe GIBILISCO"/>
    <VERSENYZO NAME="Giuseppina LEONE"/>
    <VERSENYZO NAME="Glenn CUNNINGHAM"/>
    <VERSENYZO NAME="Glenn DAVIS"/>
    <VERSENYZO NAME="Glenn GRAHAM"/>
    <VERSENYZO NAME="Glenn HARDIN"/>
    <VERSENYZO NAME="Glenn HARTRANFT"/>
    <VERSENYZO NAME="Glenn MORRIS"/>
    <VERSENYZO NAME="Gloria ALOZIE"/>
    <VERSENYZO NAME="Glynis NUNN"/>
    <VERSENYZO NAME="Godfrey BROWN"/>
    <VERSENYZO NAME="Godfrey Khotso MOKOENA"/>
    <VERSENYZO NAME="Gordon PIRIE"/>
    <VERSENYZO NAME="Gote Ernst HAGSTROM"/>
    <VERSENYZO NAME="Grantley GOULDING"/>
    <VERSENYZO NAME="Greg FOSTER"/>
    <VERSENYZO NAME="Greg HAUGHTON"/>
    <VERSENYZO NAME="Greg JOY"/>
    <VERSENYZO NAME="Greg RUTHERFORD"/>
    <VERSENYZO NAME="Grete ANDERSEN"/>
    <VERSENYZO NAME="Guido KRATSCHMER"/>
    <VERSENYZO NAME="Guillaume LEBLANC"/>
    <VERSENYZO NAME="Gulnara SAMITOVA"/>
    <VERSENYZO NAME="Gunhild HOFFMEISTER"/>
    <VERSENYZO NAME="Gunnar HÃ&#x96;CKERT"/>
    <VERSENYZO NAME="Gunnar LINDSTRÃ&#x96;M"/>
    <VERSENYZO NAME="Gustaf JANSSON"/>
    <VERSENYZO NAME="Gustav LINDBLOM"/>
    <VERSENYZO NAME="Guy BUTLER"/>
    <VERSENYZO NAME="Guy DRUT"/>
    <VERSENYZO NAME="Gwen TORRENCE"/>
    <VERSENYZO NAME="Gyula KELLNER"/>
    <VERSENYZO NAME="Gyula ZSIVÃ&#x93;TZKY"/>
    <VERSENYZO NAME="GÃ¶sta HOLMER"/>
    <VERSENYZO NAME="Habiba GHRIBI"/>
    <VERSENYZO NAME="Hadi Soua An AL SOMAILY"/>
    <VERSENYZO NAME="Hagos GEBRHIWET"/>
    <VERSENYZO NAME="Haile GEBRSELASSIE"/>
    <VERSENYZO NAME="Halina KONOPACKA"/>
    <VERSENYZO NAME="Hannes KOLEHMAINEN"/>
    <VERSENYZO NAME="Hanns BRAUN"/>
    <VERSENYZO NAME="Hannu Juhani SIITONEN"/>
    <VERSENYZO NAME="Hans GRODOTZKI"/>
    <VERSENYZO NAME="Hans LIESCHE"/>
    <VERSENYZO NAME="Hans REIMANN"/>
    <VERSENYZO NAME="Hans WOELLKE"/>
    <VERSENYZO NAME="Hans-Joachim WALDE"/>
    <VERSENYZO NAME="Hansle PARCHMENT"/>
    <VERSENYZO NAME="Harald NORPOTH"/>
    <VERSENYZO NAME="Harald SCHMID"/>
    <VERSENYZO NAME="Harlow ROTHERT"/>
    <VERSENYZO NAME="Harold ABRAHAMS"/>
    <VERSENYZO NAME="Harold BARRON"/>
    <VERSENYZO NAME="Harold OSBORN"/>
    <VERSENYZO NAME="Harold WHITLOCK"/>
    <VERSENYZO NAME="Harold WILSON"/>
    <VERSENYZO NAME="Harri LARVA"/>
    <VERSENYZO NAME="Harrison DILLARD"/>
    <VERSENYZO NAME="Harry EDWARD"/>
    <VERSENYZO NAME="Harry HILLMAN"/>
    <VERSENYZO NAME="Harry JEROME"/>
    <VERSENYZO NAME="Harry PORTER"/>
    <VERSENYZO NAME="Harry Stoddard BABCOCK"/>
    <VERSENYZO NAME="Hartwig GAUDER"/>
    <VERSENYZO NAME="Hasely CRAWFORD"/>
    <VERSENYZO NAME="Hasna BENHASSI"/>
    <VERSENYZO NAME="Hassiba BOULMERKA"/>
    <VERSENYZO NAME="Hayes JONES"/>
    <VERSENYZO NAME="Hector HOGAN"/>
    <VERSENYZO NAME="Heike DRECHSLER"/>
    <VERSENYZO NAME="Heike HENKEL"/>
    <VERSENYZO NAME="Heinz ULZHEIMER"/>
    <VERSENYZO NAME="Helen STEPHENS"/>
    <VERSENYZO NAME="Helena FIBINGEROVÃ&#x81;"/>
    <VERSENYZO NAME="Helge LÃ&#x96;VLAND"/>
    <VERSENYZO NAME="Heli RANTANEN"/>
    <VERSENYZO NAME="Hellen Onsando OBIRI"/>
    <VERSENYZO NAME="Helmut KÃ&#x96;RNIG"/>
    <VERSENYZO NAME="Henri DELOGE"/>
    <VERSENYZO NAME="Henri LABORDE"/>
    <VERSENYZO NAME="Henri TAUZIN"/>
    <VERSENYZO NAME="Henry CARR"/>
    <VERSENYZO NAME="Henry ERIKSSON"/>
    <VERSENYZO NAME="Henry JONSSON-KÃ&#x84;LARNE"/>
    <VERSENYZO NAME="Henry STALLARD"/>
    <VERSENYZO NAME="Herb ELLIOTT"/>
    <VERSENYZO NAME="Herbert JAMISON"/>
    <VERSENYZO NAME="Herbert MCKENLEY"/>
    <VERSENYZO NAME="Herbert SCHADE"/>
    <VERSENYZO NAME="Herma BAUMA"/>
    <VERSENYZO NAME="Herman GROMAN"/>
    <VERSENYZO NAME="Herman Ronald FRAZIER"/>
    <VERSENYZO NAME="Hermann ENGELHARD"/>
    <VERSENYZO NAME="Hestrie CLOETE"/>
    <VERSENYZO NAME="Hezekiel SEPENG"/>
    <VERSENYZO NAME="Hicham EL GUERROUJ"/>
    <VERSENYZO NAME="Hilda STRIKE"/>
    <VERSENYZO NAME="Hildegard FALCK"/>
    <VERSENYZO NAME="Hildrun CLAUS"/>
    <VERSENYZO NAME="Hirooki ARAI"/>
    <VERSENYZO NAME="Hollis CONWAY"/>
    <VERSENYZO NAME="Hong LIU"/>
    <VERSENYZO NAME="Horace ASHENFELTER"/>
    <VERSENYZO NAME="Horatio FITCH"/>
    <VERSENYZO NAME="Howard VALENTINE"/>
    <VERSENYZO NAME="Hrysopiyi DEVETZI"/>
    <VERSENYZO NAME="Hugo WIESLANDER"/>
    <VERSENYZO NAME="Huina XING"/>
    <VERSENYZO NAME="Hussein AHMED SALAH"/>
    <VERSENYZO NAME="Hyleas FOUNTAIN"/>
    <VERSENYZO NAME="Hyvin Kiyeng JEPKEMOI"/>
    <VERSENYZO NAME="Ian STEWART"/>
    <VERSENYZO NAME="Ibolya CSÃ&#x81;K"/>
    <VERSENYZO NAME="Ibrahim CAMEJO"/>
    <VERSENYZO NAME="Ignace HEINRICH"/>
    <VERSENYZO NAME="Igor ASTAPKOVICH"/>
    <VERSENYZO NAME="Igor NIKULIN"/>
    <VERSENYZO NAME="Igor TER-OVANESYAN"/>
    <VERSENYZO NAME="Igor TRANDENKOV"/>
    <VERSENYZO NAME="Ileana SILAI"/>
    <VERSENYZO NAME="Ilke WYLUDDA"/>
    <VERSENYZO NAME="Ilmari SALMINEN"/>
    <VERSENYZO NAME="Ilona SCHOKNECHT-SLUPIANEK"/>
    <VERSENYZO NAME="Ilya MARKOV"/>
    <VERSENYZO NAME="Imre NÃ&#x89;METH"/>
    <VERSENYZO NAME="Imrich BUGÃ&#x81;R"/>
    <VERSENYZO NAME="Inessa KRAVETS"/>
    <VERSENYZO NAME="Inga GENTZEL"/>
    <VERSENYZO NAME="Inge HELTEN"/>
    <VERSENYZO NAME="Ingrid AUERSWALD-LANGE"/>
    <VERSENYZO NAME="Ingrid LOTZ"/>
    <VERSENYZO NAME="Ingvar PETTERSSON"/>
    <VERSENYZO NAME="Inha BABAKOVA"/>
    <VERSENYZO NAME="Inna LASOVSKAYA"/>
    <VERSENYZO NAME="Ioannis PERSAKIS"/>
    <VERSENYZO NAME="Ioannis THEODOROPOULOS"/>
    <VERSENYZO NAME="Iolanda BALAS"/>
    <VERSENYZO NAME="Ionela TIRLEA"/>
    <VERSENYZO NAME="Ira DAVENPORT"/>
    <VERSENYZO NAME="Irena KIRSZENSTEIN"/>
    <VERSENYZO NAME="Irina BELOVA"/>
    <VERSENYZO NAME="Irina KHUDOROZHKINA"/>
    <VERSENYZO NAME="Irina PRIVALOVA"/>
    <VERSENYZO NAME="Irina SIMAGINA"/>
    <VERSENYZO NAME="Irvin ROBERSON"/>
    <VERSENYZO NAME="Irving BAXTER"/>
    <VERSENYZO NAME="Irving SALADINO"/>
    <VERSENYZO NAME="Iryna LISHCHYNSKA"/>
    <VERSENYZO NAME="Iryna YATCHENKO"/>
    <VERSENYZO NAME="Isabella OCHICHI"/>
    <VERSENYZO NAME="Ismail Ahmed ISMAIL"/>
    <VERSENYZO NAME="IstvÃ¡n RÃ&#x93;ZSAVÃ&#x96;LGYI"/>
    <VERSENYZO NAME="IstvÃ¡n SOMODI"/>
    <VERSENYZO NAME="Ivan BELYAEV"/>
    <VERSENYZO NAME="Ivan PEDROSO"/>
    <VERSENYZO NAME="Ivan RILEY"/>
    <VERSENYZO NAME="Ivan TSIKHAN"/>
    <VERSENYZO NAME="Ivan UKHOV"/>
    <VERSENYZO NAME="Ivana SPANOVIC"/>
    <VERSENYZO NAME="Ivanka KHRISTOVA"/>
    <VERSENYZO NAME="Ivano BRUGNETTI"/>
    <VERSENYZO NAME="Ivo VAN DAMME"/>
    <VERSENYZO NAME="Jaak UUDMÃ&#x84;E"/>
    <VERSENYZO NAME="Jacek WSZOLA"/>
    <VERSENYZO NAME="Jack DAVIS"/>
    <VERSENYZO NAME="Jack LONDON"/>
    <VERSENYZO NAME="Jack PARKER"/>
    <VERSENYZO NAME="Jack PIERCE"/>
    <VERSENYZO NAME="Jackie JOYNER"/>
    <VERSENYZO NAME="Jackson SCHOLZ"/>
    <VERSENYZO NAME="Jacqueline MAZEAS"/>
    <VERSENYZO NAME="Jacqueline TODTEN"/>
    <VERSENYZO NAME="Jadwiga WAJS"/>
    <VERSENYZO NAME="Jai TAURIMA"/>
    <VERSENYZO NAME="James BALL"/>
    <VERSENYZO NAME="James BECKFORD"/>
    <VERSENYZO NAME="James BROOKER"/>
    <VERSENYZO NAME="James CONNOLLY"/>
    <VERSENYZO NAME="James DILLION"/>
    <VERSENYZO NAME="James DUNCAN"/>
    <VERSENYZO NAME="James Edwin MEREDITH"/>
    <VERSENYZO NAME="James Ellis LU VALLE"/>
    <VERSENYZO NAME="James FUCHS"/>
    <VERSENYZO NAME="James GATHERS"/>
    <VERSENYZO NAME="James LIGHTBODY"/>
    <VERSENYZO NAME="James WENDELL"/>
    <VERSENYZO NAME="James WILSON"/>
    <VERSENYZO NAME="Jan Å½ELEZNÃ&#x9d;"/>
    <VERSENYZO NAME="Janay DELOACH"/>
    <VERSENYZO NAME="Jane SAVILLE"/>
    <VERSENYZO NAME="Janeene VICKERS"/>
    <VERSENYZO NAME="Janeth Jepkosgei BUSIENEI"/>
    <VERSENYZO NAME="Janis DALINS"/>
    <VERSENYZO NAME="Janusz KUSOCINSKI"/>
    <VERSENYZO NAME="Jaouad GHARIB"/>
    <VERSENYZO NAME="Jared TALLENT"/>
    <VERSENYZO NAME="Jarmila KRATOHVILOVA"/>
    <VERSENYZO NAME="Jaroslav BABA"/>
    <VERSENYZO NAME="Jaroslawa JÃ&#x93;ZWIAKOWSKA"/>
    <VERSENYZO NAME="Jason RICHARDSON"/>
    <VERSENYZO NAME="Javier CULSON"/>
    <VERSENYZO NAME="Javier GARCÃ&#x8d;A"/>
    <VERSENYZO NAME="Javier SOTOMAYOR"/>
    <VERSENYZO NAME="Jean BOUIN"/>
    <VERSENYZO NAME="Jean CHASTANIE"/>
    <VERSENYZO NAME="Jean GALFIONE"/>
    <VERSENYZO NAME="Jean SHILEY"/>
    <VERSENYZO NAME="Jeff HENDERSON"/>
    <VERSENYZO NAME="Jefferson PEREZ"/>
    <VERSENYZO NAME="Jemima Jelagat SUMGONG"/>
    <VERSENYZO NAME="Jennifer LAMY"/>
    <VERSENYZO NAME="Jennifer SIMPSON"/>
    <VERSENYZO NAME="Jennifer SUHR"/>
    <VERSENYZO NAME="Jeremy WARINER"/>
    <VERSENYZO NAME="Jerome BIFFLE"/>
    <VERSENYZO NAME="Jesse OWENS"/>
    <VERSENYZO NAME="Jessica ENNIS HILL"/>
    <VERSENYZO NAME="Jim BAUSCH"/>
    <VERSENYZO NAME="Jim DOEHRING"/>
    <VERSENYZO NAME="Jim HINES"/>
    <VERSENYZO NAME="Jim RYUN"/>
    <VERSENYZO NAME="Jim THORPE"/>
    <VERSENYZO NAME="Joachim Broechner OLSEN"/>
    <VERSENYZO NAME="Joachim BÃ&#x9c;CHNER"/>
    <VERSENYZO NAME="Joan BENOIT"/>
    <VERSENYZO NAME="Joan Lino MARTINEZ"/>
    <VERSENYZO NAME="Joanet QUINTERO"/>
    <VERSENYZO NAME="Joanna HAYES"/>
    <VERSENYZO NAME="Joaquim CRUZ"/>
    <VERSENYZO NAME="Joe GREENE"/>
    <VERSENYZO NAME="Joe KOVACS"/>
    <VERSENYZO NAME="Joel SANCHEZ GUERRERO"/>
    <VERSENYZO NAME="Joel SHANKLE"/>
    <VERSENYZO NAME="Johanna LÃ&#x9c;TTGE"/>
    <VERSENYZO NAME="Johanna SCHALLER-KLIER"/>
    <VERSENYZO NAME="John AKII-BUA"/>
    <VERSENYZO NAME="John ANDERSON"/>
    <VERSENYZO NAME="John BRAY"/>
    <VERSENYZO NAME="John CARLOS"/>
    <VERSENYZO NAME="John COLLIER"/>
    <VERSENYZO NAME="John COOPER"/>
    <VERSENYZO NAME="John CORNES"/>
    <VERSENYZO NAME="John CREGAN"/>
    <VERSENYZO NAME="John DALY"/>
    <VERSENYZO NAME="John DAVIES"/>
    <VERSENYZO NAME="John DEWITT"/>
    <VERSENYZO NAME="John DISLEY"/>
    <VERSENYZO NAME="John FLANAGAN"/>
    <VERSENYZO NAME="John GARRELLS"/>
    <VERSENYZO NAME="John GODINA"/>
    <VERSENYZO NAME="John George WALKER"/>
    <VERSENYZO NAME="John HAYES"/>
    <VERSENYZO NAME="John Kenneth DOHERTY"/>
    <VERSENYZO NAME="John LANDY"/>
    <VERSENYZO NAME="John LJUNGGREN"/>
    <VERSENYZO NAME="John LOARING"/>
    <VERSENYZO NAME="John LOVELOCK"/>
    <VERSENYZO NAME="John MCLEAN"/>
    <VERSENYZO NAME="John MOFFITT"/>
    <VERSENYZO NAME="John Macfarlane HOLLAND"/>
    <VERSENYZO NAME="John NORTON"/>
    <VERSENYZO NAME="John POWELL"/>
    <VERSENYZO NAME="John RAMBO"/>
    <VERSENYZO NAME="John RECTOR"/>
    <VERSENYZO NAME="John SHERWOOD"/>
    <VERSENYZO NAME="John THOMAS"/>
    <VERSENYZO NAME="John TREACY"/>
    <VERSENYZO NAME="John WOODRUFF"/>
    <VERSENYZO NAME="Johnny GRAY"/>
    <VERSENYZO NAME="Jolan KLEIBER-KONTSEK"/>
    <VERSENYZO NAME="Jolanda CEPLAK"/>
    <VERSENYZO NAME="Jonathan EDWARDS"/>
    <VERSENYZO NAME="Jonni MYYRÃ&#x84;"/>
    <VERSENYZO NAME="Jorge LLOPART"/>
    <VERSENYZO NAME="Jose TELLES DA CONCEICAO"/>
    <VERSENYZO NAME="Josef DOLEZAL"/>
    <VERSENYZO NAME="Josef ODLOZIL"/>
    <VERSENYZO NAME="Joseph BARTHEL"/>
    <VERSENYZO NAME="Joseph FORSHAW"/>
    <VERSENYZO NAME="Joseph GUILLEMOT"/>
    <VERSENYZO NAME="Joseph KETER"/>
    <VERSENYZO NAME="Joseph MAHMOUD"/>
    <VERSENYZO NAME="Joseph MCCLUSKEY"/>
    <VERSENYZO NAME="Josh CULBREATH"/>
    <VERSENYZO NAME="Josia THUGWANE"/>
    <VERSENYZO NAME="Josiah MCCRACKEN"/>
    <VERSENYZO NAME="JosÃ© Manuel ABASCAL"/>
    <VERSENYZO NAME="JosÃ© PEDRAZA"/>
    <VERSENYZO NAME="Joyce CHEPCHUMBA"/>
    <VERSENYZO NAME="Jozef PRIBILINEC"/>
    <VERSENYZO NAME="Jozef SCHMIDT"/>
    <VERSENYZO NAME="JoÃ£o Carlos DE OLIVEIRA"/>
    <VERSENYZO NAME="Juan Carlos ZABALA"/>
    <VERSENYZO NAME="Judi BROWN"/>
    <VERSENYZO NAME="Judith Florence AMOORE-POLLOCK"/>
    <VERSENYZO NAME="Juho Julius SAARISTO"/>
    <VERSENYZO NAME="Jules LADOUMEGUE"/>
    <VERSENYZO NAME="Juliet CUTHBERT"/>
    <VERSENYZO NAME="Julius KORIR"/>
    <VERSENYZO NAME="Julius SANG"/>
    <VERSENYZO NAME="Julius YEGO"/>
    <VERSENYZO NAME="Junxia WANG"/>
    <VERSENYZO NAME="Justin GATLIN"/>
    <VERSENYZO NAME="Jutta HEINE"/>
    <VERSENYZO NAME="Jutta KIRST"/>
    <VERSENYZO NAME="JÃ³zsef CSERMÃ&#x81;K"/>
    <VERSENYZO NAME="JÃ³zsef KOVÃ&#x81;CS"/>
    <VERSENYZO NAME="JÃ¶rg FREIMUTH"/>
    <VERSENYZO NAME="JÃ¼rgen HINGSEN"/>
    <VERSENYZO NAME="JÃ¼rgen SCHULT"/>
    <VERSENYZO NAME="JÃ¼rgen STRAUB"/>
    <VERSENYZO NAME="JÃ¼ri LOSSMANN"/>
    <VERSENYZO NAME="Kaarlo Jalmari TUOMINEN"/>
    <VERSENYZO NAME="Kaarlo MAANINKA"/>
    <VERSENYZO NAME="Kaisa PARVIAINEN"/>
    <VERSENYZO NAME="Kajsa BERGQVIST"/>
    <VERSENYZO NAME="Kamila SKOLIMOWSKA"/>
    <VERSENYZO NAME="Karel LISMONT"/>
    <VERSENYZO NAME="Karen FORKEL"/>
    <VERSENYZO NAME="Karin RICHERT-BALZER"/>
    <VERSENYZO NAME="Karl STORCH"/>
    <VERSENYZO NAME="Karl-Friedrich HAAS"/>
    <VERSENYZO NAME="Karoline &#34;Lina&#34; RADKE"/>
    <VERSENYZO NAME="Katharine MERRY"/>
    <VERSENYZO NAME="Kathleen HAMMOND"/>
    <VERSENYZO NAME="Kathrin NEIMKE"/>
    <VERSENYZO NAME="Kathryn Joan SCHMIDT"/>
    <VERSENYZO NAME="Kathryn SMALLWOOD-COOK"/>
    <VERSENYZO NAME="Katrin DÃ&#x96;RRE"/>
    <VERSENYZO NAME="Kazimierz ZIMNY"/>
    <VERSENYZO NAME="Kellie WELLS"/>
    <VERSENYZO NAME="Kelly HOLMES"/>
    <VERSENYZO NAME="Kelly SOTHERTON"/>
    <VERSENYZO NAME="Kenenisa BEKELE"/>
    <VERSENYZO NAME="Kenji KIMIHARA"/>
    <VERSENYZO NAME="Kenkichi OSHIMA"/>
    <VERSENYZO NAME="Kennedy Kane MCARTHUR"/>
    <VERSENYZO NAME="Kenneth Joseph MATTHEWS"/>
    <VERSENYZO NAME="Kenneth WIESNER"/>
    <VERSENYZO NAME="Kenny HARRISON"/>
    <VERSENYZO NAME="Kenth ELDEBRINK"/>
    <VERSENYZO NAME="Kerron CLEMENT"/>
    <VERSENYZO NAME="Kerron STEWART"/>
    <VERSENYZO NAME="Keshorn WALCOTT"/>
    <VERSENYZO NAME="Kevin MAYER"/>
    <VERSENYZO NAME="Kevin YOUNG"/>
    <VERSENYZO NAME="Khalid BOULAMI"/>
    <VERSENYZO NAME="Khalid SKAH"/>
    <VERSENYZO NAME="Kharilaos VASILAKOS"/>
    <VERSENYZO NAME="Kim BATTEN"/>
    <VERSENYZO NAME="Kim GALLAGHER"/>
    <VERSENYZO NAME="Kim TURNER"/>
    <VERSENYZO NAME="Kinue HITOMI"/>
    <VERSENYZO NAME="Kip KEINO"/>
    <VERSENYZO NAME="Kirani JAMES"/>
    <VERSENYZO NAME="Kirk BAPTISTE"/>
    <VERSENYZO NAME="Kirsten MÃ&#x9c;NCHOW"/>
    <VERSENYZO NAME="Kitei SON"/>
    <VERSENYZO NAME="Kjersti PLAETZER"/>
    <VERSENYZO NAME="Klaus LEHNERTZ"/>
    <VERSENYZO NAME="Klaus RICHTZENHAIN"/>
    <VERSENYZO NAME="Klaus-Peter HILDENBRAND"/>
    <VERSENYZO NAME="Klavdiya TOCHENOVA"/>
    <VERSENYZO NAME="Koichi MORISHITA"/>
    <VERSENYZO NAME="Koji MUROFUSHI"/>
    <VERSENYZO NAME="Kokichi TSUBURAYA"/>
    <VERSENYZO NAME="Konstantin VOLKOV"/>
    <VERSENYZO NAME="Kostas KENTERIS"/>
    <VERSENYZO NAME="Kriss AKABUSI"/>
    <VERSENYZO NAME="Kristi CASTLIN"/>
    <VERSENYZO NAME="Krisztian PARS"/>
    <VERSENYZO NAME="Kurt BENDLIN"/>
    <VERSENYZO NAME="KÃ¤the KRAUSS"/>
    <VERSENYZO NAME="LaVonna MARTIN"/>
    <VERSENYZO NAME="Lacey HEARN"/>
    <VERSENYZO NAME="Lajos GÃ&#x96;NCZY"/>
    <VERSENYZO NAME="Lalonde GORDON"/>
    <VERSENYZO NAME="Lambert REDD"/>
    <VERSENYZO NAME="Lance Earl DEAL"/>
    <VERSENYZO NAME="Larisa PELESHENKO"/>
    <VERSENYZO NAME="Larry BLACK"/>
    <VERSENYZO NAME="Larry JAMES"/>
    <VERSENYZO NAME="Larry YOUNG"/>
    <VERSENYZO NAME="Lars RIEDEL"/>
    <VERSENYZO NAME="Lashawn MERRITT"/>
    <VERSENYZO NAME="Lashinda DEMUS"/>
    <VERSENYZO NAME="Lasse VIREN"/>
    <VERSENYZO NAME="Lauri LEHTINEN"/>
    <VERSENYZO NAME="Lauri VIRTANEN"/>
    <VERSENYZO NAME="Lauryn WILLIAMS"/>
    <VERSENYZO NAME="Lawrence E. Joseph FEUERBACH"/>
    <VERSENYZO NAME="Lawrence JOHNSON"/>
    <VERSENYZO NAME="Lawrence SHIELDS"/>
    <VERSENYZO NAME="Lawrence WHITNEY"/>
    <VERSENYZO NAME="Lee BARNES"/>
    <VERSENYZO NAME="Lee CALHOUN"/>
    <VERSENYZO NAME="Lee EVANS"/>
    <VERSENYZO NAME="Leevan SANDS"/>
    <VERSENYZO NAME="Lennart STRAND"/>
    <VERSENYZO NAME="Lennox MILLER"/>
    <VERSENYZO NAME="Leo SEXTON"/>
    <VERSENYZO NAME="Leonard Francis TREMEER"/>
    <VERSENYZO NAME="Leonel MANZANO"/>
    <VERSENYZO NAME="Leonel SUAREZ"/>
    <VERSENYZO NAME="Leonid LITVINENKO"/>
    <VERSENYZO NAME="Leonid SHCHERBAKOV"/>
    <VERSENYZO NAME="Leonid SPIRIN"/>
    <VERSENYZO NAME="Leroy BROWN"/>
    <VERSENYZO NAME="Leroy SAMSE"/>
    <VERSENYZO NAME="Lesley ASHBURNER"/>
    <VERSENYZO NAME="Leslie DENIZ"/>
    <VERSENYZO NAME="Lester Nelson CARNEY"/>
    <VERSENYZO NAME="Lewis SHELDON"/>
    <VERSENYZO NAME="Lewis TEWANIMA"/>
    <VERSENYZO NAME="Lia MANOLIU"/>
    <VERSENYZO NAME="Lidia ALFEEVA"/>
    <VERSENYZO NAME="Lidia SIMON"/>
    <VERSENYZO NAME="Liesel WESTERMANN"/>
    <VERSENYZO NAME="Lijiao GONG"/>
    <VERSENYZO NAME="Liliya NURUTDINOVA"/>
    <VERSENYZO NAME="Lilli SCHWARZKOPF"/>
    <VERSENYZO NAME="Lillian BOARD"/>
    <VERSENYZO NAME="Lillian COPELAND"/>
    <VERSENYZO NAME="Lily CARLSTEDT"/>
    <VERSENYZO NAME="Linda STAHL"/>
    <VERSENYZO NAME="Lindy REMIGINO"/>
    <VERSENYZO NAME="Linford CHRISTIE"/>
    <VERSENYZO NAME="Liping WANG"/>
    <VERSENYZO NAME="Lisa ONDIEKI"/>
    <VERSENYZO NAME="Livio BERRUTI"/>
    <VERSENYZO NAME="Llewellyn HERBERT"/>
    <VERSENYZO NAME="Lloyd LABEACH"/>
    <VERSENYZO NAME="Lorraine FENTON"/>
    <VERSENYZO NAME="Lorraine MOLLER"/>
    <VERSENYZO NAME="Lothar MILDE"/>
    <VERSENYZO NAME="Louis WILKINS"/>
    <VERSENYZO NAME="Louise MCPAUL"/>
    <VERSENYZO NAME="Lucyna LANGER"/>
    <VERSENYZO NAME="Ludmila ENGQUIST"/>
    <VERSENYZO NAME="LudvÃ­k DANEK"/>
    <VERSENYZO NAME="Luguelin SANTOS"/>
    <VERSENYZO NAME="Luigi BECCALI"/>
    <VERSENYZO NAME="Luis BRUNETTO"/>
    <VERSENYZO NAME="Luis DELIS"/>
    <VERSENYZO NAME="Luise KRÃ&#x9c;GER"/>
    <VERSENYZO NAME="Lutz DOMBROWSKI"/>
    <VERSENYZO NAME="Luvo MANYONGA"/>
    <VERSENYZO NAME="Luz LONG"/>
    <VERSENYZO NAME="Lynn DAVIES"/>
    <VERSENYZO NAME="Lynn JENNINGS"/>
    <VERSENYZO NAME="Lyudmila BRAGINA"/>
    <VERSENYZO NAME="Lyudmila KONDRATYEVA"/>
    <VERSENYZO NAME="Lyudmila ROGACHOVA"/>
    <VERSENYZO NAME="Lyudmila SHEVTSOVA"/>
    <VERSENYZO NAME="Mac WILKINS"/>
    <VERSENYZO NAME="Madeline MANNING-JACKSON"/>
    <VERSENYZO NAME="Mahiedine MEKHISSI"/>
    <VERSENYZO NAME="Mahiedine MEKHISSI-BENABBAD"/>
    <VERSENYZO NAME="Maksim TARASOV"/>
    <VERSENYZO NAME="Mal WHITFIELD"/>
    <VERSENYZO NAME="Malcolm NOKES"/>
    <VERSENYZO NAME="Malcolm SPENCE"/>
    <VERSENYZO NAME="Mamo WOLDE"/>
    <VERSENYZO NAME="Manuel MARTINEZ"/>
    <VERSENYZO NAME="Manuel PLAZA"/>
    <VERSENYZO NAME="Manuela MONTEBRUN"/>
    <VERSENYZO NAME="Marc WRIGHT"/>
    <VERSENYZO NAME="Marcel HANSENNE"/>
    <VERSENYZO NAME="Mare DIBABA"/>
    <VERSENYZO NAME="Margaret Nyairera WAMBUI"/>
    <VERSENYZO NAME="Margitta DROESE-PUFE"/>
    <VERSENYZO NAME="Margitta HELMBOLD-GUMMEL"/>
    <VERSENYZO NAME="Maria CIONCAN"/>
    <VERSENYZO NAME="Maria COLON"/>
    <VERSENYZO NAME="Maria GOMMERS"/>
    <VERSENYZO NAME="Maria Guadalupe GONZALEZ"/>
    <VERSENYZO NAME="Maria KWASNIEWSKA"/>
    <VERSENYZO NAME="Maria MUTOLA"/>
    <VERSENYZO NAME="Maria VASCO"/>
    <VERSENYZO NAME="Maria VERGOVA-PETKOVA"/>
    <VERSENYZO NAME="Marian OPREA"/>
    <VERSENYZO NAME="Marianne WERNER"/>
    <VERSENYZO NAME="Maricica PUICA"/>
    <VERSENYZO NAME="Marie-JosÃ© PÃ&#x89;REC"/>
    <VERSENYZO NAME="Marilyn BLACK"/>
    <VERSENYZO NAME="Mario LANZI"/>
    <VERSENYZO NAME="Marion BECKER-STEINER"/>
    <VERSENYZO NAME="Marita KOCH"/>
    <VERSENYZO NAME="Marita LANGE"/>
    <VERSENYZO NAME="Maritza MARTEN"/>
    <VERSENYZO NAME="Mariya SAVINOVA"/>
    <VERSENYZO NAME="Marjorie JACKSON"/>
    <VERSENYZO NAME="Mark CREAR"/>
    <VERSENYZO NAME="Mark MCKOY"/>
    <VERSENYZO NAME="Markus RYFFEL"/>
    <VERSENYZO NAME="Marlene MATHEWS-WILLARD"/>
    <VERSENYZO NAME="Marlies OELSNER-GÃ&#x96;HR"/>
    <VERSENYZO NAME="Marquis Franklin HORR"/>
    <VERSENYZO NAME="Marta ANTAL-RUDAS"/>
    <VERSENYZO NAME="Martin HAWKINS"/>
    <VERSENYZO NAME="Martin SHERIDAN"/>
    <VERSENYZO NAME="Martinus OSENDARP"/>
    <VERSENYZO NAME="Martti MARTTELIN"/>
    <VERSENYZO NAME="Mary ONYALI"/>
    <VERSENYZO NAME="Mary RAND"/>
    <VERSENYZO NAME="Maryam Yusuf JAMAL"/>
    <VERSENYZO NAME="Maryvonne DUPUREUR"/>
    <VERSENYZO NAME="Matej TOTH"/>
    <VERSENYZO NAME="Matt HEMINGWAY"/>
    <VERSENYZO NAME="Matt MCGRATH"/>
    <VERSENYZO NAME="Matthew BIRIR"/>
    <VERSENYZO NAME="Matthew CENTROWITZ"/>
    <VERSENYZO NAME="Matthew Mackenzie ROBINSON"/>
    <VERSENYZO NAME="Matti JÃ&#x84;RVINEN"/>
    <VERSENYZO NAME="Matti SIPPALA"/>
    <VERSENYZO NAME="Maurice GREENE"/>
    <VERSENYZO NAME="Maurice HERRIOTT"/>
    <VERSENYZO NAME="Maurizio DAMILANO"/>
    <VERSENYZO NAME="Maurren Higa MAGGI"/>
    <VERSENYZO NAME="Maxwell Warburn LONG"/>
    <VERSENYZO NAME="Mbulaeni MULAUDZI"/>
    <VERSENYZO NAME="Mebrahtom KEFLEZIGHI"/>
    <VERSENYZO NAME="Medhi BAALA"/>
    <VERSENYZO NAME="Mel PATTON"/>
    <VERSENYZO NAME="Melaine WALKER"/>
    <VERSENYZO NAME="Melina ROBERT-MICHON"/>
    <VERSENYZO NAME="Melissa MORRISON"/>
    <VERSENYZO NAME="Melvin SHEPPARD"/>
    <VERSENYZO NAME="Meredith COLKETT"/>
    <VERSENYZO NAME="Meredith GOURDINE"/>
    <VERSENYZO NAME="Merlene OTTEY"/>
    <VERSENYZO NAME="Merritt GIFFIN"/>
    <VERSENYZO NAME="Meseret DEFAR"/>
    <VERSENYZO NAME="Meyer PRINSTEIN"/>
    <VERSENYZO NAME="Micah KOGO"/>
    <VERSENYZO NAME="Michael BATES"/>
    <VERSENYZO NAME="Michael D'Andrea CARTER"/>
    <VERSENYZO NAME="Michael JOHNSON"/>
    <VERSENYZO NAME="Michael Lyle SHINE"/>
    <VERSENYZO NAME="Michael MARSH"/>
    <VERSENYZO NAME="Michael MCLEOD"/>
    <VERSENYZO NAME="Michael MUSYOKI"/>
    <VERSENYZO NAME="Michael TINSLEY"/>
    <VERSENYZO NAME="Michel JAZY"/>
    <VERSENYZO NAME="Michel THÃ&#x89;ATO"/>
    <VERSENYZO NAME="Michele BROWN"/>
    <VERSENYZO NAME="Micheline OSTERMEYER"/>
    <VERSENYZO NAME="Michelle CARTER"/>
    <VERSENYZO NAME="MichÃ¨le CHARDONNET"/>
    <VERSENYZO NAME="Miguel WHITE"/>
    <VERSENYZO NAME="Mihaela LOGHIN"/>
    <VERSENYZO NAME="Mihaela PENES"/>
    <VERSENYZO NAME="Mike BOIT"/>
    <VERSENYZO NAME="Mike CONLEY"/>
    <VERSENYZO NAME="Mike LARRABEE"/>
    <VERSENYZO NAME="Mike POWELL"/>
    <VERSENYZO NAME="Mike RYAN"/>
    <VERSENYZO NAME="Mike STULCE"/>
    <VERSENYZO NAME="Mikhail SHCHENNIKOV"/>
    <VERSENYZO NAME="Miklos NEMETH"/>
    <VERSENYZO NAME="Milcah Chemos CHEYWA"/>
    <VERSENYZO NAME="Mildred DIDRIKSON"/>
    <VERSENYZO NAME="Millard Frank Jr. HAMPTON"/>
    <VERSENYZO NAME="Millon WOLDE"/>
    <VERSENYZO NAME="Miltiadis GOUSKOS"/>
    <VERSENYZO NAME="Milton Gray CAMPBELL"/>
    <VERSENYZO NAME="Mirela DEMIREVA"/>
    <VERSENYZO NAME="Mirela MANIANI"/>
    <VERSENYZO NAME="Miruts YIFTER"/>
    <VERSENYZO NAME="Mitchell WATT"/>
    <VERSENYZO NAME="Mizuki NOGUCHI"/>
    <VERSENYZO NAME="Mohamed Ahmed SULAIMAN"/>
    <VERSENYZO NAME="Mohamed FARAH"/>
    <VERSENYZO NAME="Mohamed GAMMOUDI"/>
    <VERSENYZO NAME="Mohammed KEDIR"/>
    <VERSENYZO NAME="Monika ZEHRT"/>
    <VERSENYZO NAME="Mor KOVACS"/>
    <VERSENYZO NAME="Morgan TAYLOR"/>
    <VERSENYZO NAME="Morris KIRKSEY"/>
    <VERSENYZO NAME="Moses KIPTANUI"/>
    <VERSENYZO NAME="Murray HALBERG"/>
    <VERSENYZO NAME="Mutaz Essa BARSHIM"/>
    <VERSENYZO NAME="Nadezhda CHIZHOVA"/>
    <VERSENYZO NAME="Nadezhda KHNYKINA"/>
    <VERSENYZO NAME="Nadezhda OLIZARENKO"/>
    <VERSENYZO NAME="Nadine KLEINERT-SCHMITT"/>
    <VERSENYZO NAME="Nafissatou THIAM"/>
    <VERSENYZO NAME="Naftali TEMU"/>
    <VERSENYZO NAME="Naman KEITA"/>
    <VERSENYZO NAME="Nancy Jebet LAGAT"/>
    <VERSENYZO NAME="Naoko TAKAHASHI"/>
    <VERSENYZO NAME="Naoto TAJIMA"/>
    <VERSENYZO NAME="Natalia BOCHINA"/>
    <VERSENYZO NAME="Natalia SHIKOLENKO"/>
    <VERSENYZO NAME="Nataliya TOBIAS"/>
    <VERSENYZO NAME="Natallia DOBRYNSKA"/>
    <VERSENYZO NAME="Natalya ANTYUKH"/>
    <VERSENYZO NAME="Natalya CHISTYAKOVA"/>
    <VERSENYZO NAME="Natalya LEBEDEVA"/>
    <VERSENYZO NAME="Natalya SADOVA"/>
    <VERSENYZO NAME="Natalya SAZANOVICH"/>
    <VERSENYZO NAME="Natasha DANVERS"/>
    <VERSENYZO NAME="Nate CARTMELL"/>
    <VERSENYZO NAME="Nathan DEAKES"/>
    <VERSENYZO NAME="Nawal EL MOUTAWAKEL"/>
    <VERSENYZO NAME="Nelson EVORA"/>
    <VERSENYZO NAME="Nezha BIDOUANE"/>
    <VERSENYZO NAME="Nia ALI"/>
    <VERSENYZO NAME="Nicholas WILLIS"/>
    <VERSENYZO NAME="Nick HYSONG"/>
    <VERSENYZO NAME="Nick WINTER"/>
    <VERSENYZO NAME="Nicola VIZZONI"/>
    <VERSENYZO NAME="Nijel AMOS"/>
    <VERSENYZO NAME="Niki BAKOGIANNI"/>
    <VERSENYZO NAME="Nikolai KIROV"/>
    <VERSENYZO NAME="Nikolaos GEORGANTAS"/>
    <VERSENYZO NAME="Nikolay AVILOV"/>
    <VERSENYZO NAME="Nikolay SMAGA"/>
    <VERSENYZO NAME="Nikolay SOKOLOV"/>
    <VERSENYZO NAME="Nikolina CHTEREVA"/>
    <VERSENYZO NAME="Nils ENGDAHL"/>
    <VERSENYZO NAME="Nils SCHUMANN"/>
    <VERSENYZO NAME="Nina DUMBADZE"/>
    <VERSENYZO NAME="Nina ROMASHKOVA"/>
    <VERSENYZO NAME="Niole SABAITE"/>
    <VERSENYZO NAME="Nixon KIPROTICH"/>
    <VERSENYZO NAME="Noah Kiprono NGENYI"/>
    <VERSENYZO NAME="Noe HERNANDEZ"/>
    <VERSENYZO NAME="Noel FREEMAN"/>
    <VERSENYZO NAME="Norman HALLOWS"/>
    <VERSENYZO NAME="Norman PRITCHARD"/>
    <VERSENYZO NAME="Norman READ"/>
    <VERSENYZO NAME="Norman TABER"/>
    <VERSENYZO NAME="Noureddine MORCELI"/>
    <VERSENYZO NAME="Nouria MERAH-BENIDA"/>
    <VERSENYZO NAME="NÃ¡ndor DÃ&#x81;NI"/>
    <VERSENYZO NAME="Oana PANTELIMON"/>
    <VERSENYZO NAME="Obadele THOMPSON"/>
    <VERSENYZO NAME="Oleg Georgiyevich FEDOSEYEV"/>
    <VERSENYZO NAME="Oleksandr BAGACH"/>
    <VERSENYZO NAME="Oleksandr KRYKUN"/>
    <VERSENYZO NAME="Oleksiy KRYKUN"/>
    <VERSENYZO NAME="Olena ANTONOVA"/>
    <VERSENYZO NAME="Olena HOVOROVA"/>
    <VERSENYZO NAME="Olena KRASOVSKA"/>
    <VERSENYZO NAME="Olga BRYZGINA"/>
    <VERSENYZO NAME="Olga KANISKINA"/>
    <VERSENYZO NAME="Olga KUZENKOVA"/>
    <VERSENYZO NAME="Olga MINEEVA"/>
    <VERSENYZO NAME="Olga RYPAKOVA"/>
    <VERSENYZO NAME="Olga SALADUKHA"/>
    <VERSENYZO NAME="Olga SHISHIGINA"/>
    <VERSENYZO NAME="Olimpiada IVANOVA"/>
    <VERSENYZO NAME="Ollie MATSON"/>
    <VERSENYZO NAME="Omar MCLEOD"/>
    <VERSENYZO NAME="Orlando ORTEGA"/>
    <VERSENYZO NAME="Osleidys MENÃ&#x89;NDEZ"/>
    <VERSENYZO NAME="Otis DAVIS"/>
    <VERSENYZO NAME="Otis HARRIS"/>
    <VERSENYZO NAME="Otto NILSSON"/>
    <VERSENYZO NAME="Ove ANDERSEN"/>
    <VERSENYZO NAME="Paavo NURMI"/>
    <VERSENYZO NAME="Paavo YRJÃ&#x96;LÃ&#x84;"/>
    <VERSENYZO NAME="Pamela JELIMO"/>
    <VERSENYZO NAME="Panagiotis PARASKEVOPOULOS"/>
    <VERSENYZO NAME="Paola PIGNI-CACCHI"/>
    <VERSENYZO NAME="Parry O'BRIEN"/>
    <VERSENYZO NAME="Patricia GIRARD"/>
    <VERSENYZO NAME="Patrick FLYNN"/>
    <VERSENYZO NAME="Patrick LEAHY"/>
    <VERSENYZO NAME="Patrick MCDONALD"/>
    <VERSENYZO NAME="Patrick O'CALLAGHAN"/>
    <VERSENYZO NAME="Patrick SANG"/>
    <VERSENYZO NAME="Patrik SJÃ&#x96;BERG"/>
    <VERSENYZO NAME="Paul BITOK"/>
    <VERSENYZO NAME="Paul BONTEMPS"/>
    <VERSENYZO NAME="Paul DRAYTON"/>
    <VERSENYZO NAME="Paul Kipkemoi CHELIMO"/>
    <VERSENYZO NAME="Paul Kipngetich TANUI"/>
    <VERSENYZO NAME="Paul Kipsiele KOECH"/>
    <VERSENYZO NAME="Paul MARTIN"/>
    <VERSENYZO NAME="Paul TERGAT"/>
    <VERSENYZO NAME="Paul Vincent NIHILL"/>
    <VERSENYZO NAME="Paul WEINSTEIN"/>
    <VERSENYZO NAME="Paul WINTER"/>
    <VERSENYZO NAME="Paul-Heinz WELLMANN"/>
    <VERSENYZO NAME="Paula MOLLENHAUER"/>
    <VERSENYZO NAME="Pauli NEVALA"/>
    <VERSENYZO NAME="Pauline DAVIS"/>
    <VERSENYZO NAME="Pauline KONGA"/>
    <VERSENYZO NAME="Pekka VASALA"/>
    <VERSENYZO NAME="Percy BEARD"/>
    <VERSENYZO NAME="Percy HODGE"/>
    <VERSENYZO NAME="Percy WILLIAMS"/>
    <VERSENYZO NAME="Peter FRENKEL"/>
    <VERSENYZO NAME="Peter NORMAN"/>
    <VERSENYZO NAME="Peter PETROV"/>
    <VERSENYZO NAME="Peter RADFORD"/>
    <VERSENYZO NAME="Peter SNELL"/>
    <VERSENYZO NAME="Peter ZAREMBA"/>
    <VERSENYZO NAME="Philip BAKER"/>
    <VERSENYZO NAME="Philip EDWARDS"/>
    <VERSENYZO NAME="Phillips IDOWU"/>
    <VERSENYZO NAME="Pierre LEWDEN"/>
    <VERSENYZO NAME="Pietro MENNEA"/>
    <VERSENYZO NAME="Piotr MALACHOWSKI"/>
    <VERSENYZO NAME="Piotr POCHINCHUK"/>
    <VERSENYZO NAME="Primoz KOZMUS"/>
    <VERSENYZO NAME="Priscah JEPTOO"/>
    <VERSENYZO NAME="Priscilla LOPES-SCHLIEP"/>
    <VERSENYZO NAME="Pyotr BOLOTNIKOV"/>
    <VERSENYZO NAME="Quincy WATTS"/>
    <VERSENYZO NAME="Rachid EL BASIR"/>
    <VERSENYZO NAME="Raelene Ann BOYLE"/>
    <VERSENYZO NAME="Rafer JOHNSON"/>
    <VERSENYZO NAME="Ragnar Torsten LUNDBERG"/>
    <VERSENYZO NAME="Ralph BOSTON"/>
    <VERSENYZO NAME="Ralph CRAIG"/>
    <VERSENYZO NAME="Ralph DOUBELL"/>
    <VERSENYZO NAME="Ralph HILL"/>
    <VERSENYZO NAME="Ralph HILLS"/>
    <VERSENYZO NAME="Ralph MANN"/>
    <VERSENYZO NAME="Ralph METCALFE"/>
    <VERSENYZO NAME="Ralph ROSE"/>
    <VERSENYZO NAME="Randel Luvelle WILLIAMS"/>
    <VERSENYZO NAME="Randy BARNES"/>
    <VERSENYZO NAME="Randy MATSON"/>
    <VERSENYZO NAME="Raphael HOLZDEPPE"/>
    <VERSENYZO NAME="Raymond James BARBUTI"/>
    <VERSENYZO NAME="RaÃºl GONZÃ&#x81;LEZ"/>
    <VERSENYZO NAME="Reese HOFFA"/>
    <VERSENYZO NAME="Reggie WALKER"/>
    <VERSENYZO NAME="Rein AUN"/>
    <VERSENYZO NAME="Reinaldo GORNO"/>
    <VERSENYZO NAME="Renate GARISCH-CULMBERGER-BOY"/>
    <VERSENYZO NAME="Renate STECHER"/>
    <VERSENYZO NAME="Renaud LAVILLENIE"/>
    <VERSENYZO NAME="Reuben KOSGEI"/>
    <VERSENYZO NAME="Ria STALMAN"/>
    <VERSENYZO NAME="Richard CHELIMO"/>
    <VERSENYZO NAME="Richard COCHRAN"/>
    <VERSENYZO NAME="Richard Charles WOHLHUTER"/>
    <VERSENYZO NAME="Richard HOWARD"/>
    <VERSENYZO NAME="Richard Kipkemboi MATEELONG"/>
    <VERSENYZO NAME="Richard Leslie BYRD"/>
    <VERSENYZO NAME="Richard SHELDON"/>
    <VERSENYZO NAME="Richard THOMPSON"/>
    <VERSENYZO NAME="Rick MITCHELL"/>
    <VERSENYZO NAME="Rink BABKA"/>
    <VERSENYZO NAME="Rita JAHN"/>
    <VERSENYZO NAME="Robert CLOUGHEN"/>
    <VERSENYZO NAME="Robert GARRETT"/>
    <VERSENYZO NAME="Robert GRABARZ"/>
    <VERSENYZO NAME="Robert HARTING"/>
    <VERSENYZO NAME="Robert HEFFERNAN"/>
    <VERSENYZO NAME="Robert Hyatt CLARK"/>
    <VERSENYZO NAME="Robert KERR"/>
    <VERSENYZO NAME="Robert KORZENIOWSKI"/>
    <VERSENYZO NAME="Robert Keyser SCHUL"/>
    <VERSENYZO NAME="Robert MCMILLEN"/>
    <VERSENYZO NAME="Robert Morton Newburgh TISDALL"/>
    <VERSENYZO NAME="Robert SHAVLAKADZE"/>
    <VERSENYZO NAME="Robert STANGLAND"/>
    <VERSENYZO NAME="Robert TAYLOR"/>
    <VERSENYZO NAME="Robert VAN OSDEL"/>
    <VERSENYZO NAME="Robert ZMELÃ&#x8d;K"/>
    <VERSENYZO NAME="Roberta BRUNET"/>
    <VERSENYZO NAME="Roberto MOYA"/>
    <VERSENYZO NAME="Rod MILBURN"/>
    <VERSENYZO NAME="Rodney DIXON"/>
    <VERSENYZO NAME="Roger BLACK"/>
    <VERSENYZO NAME="Roger KINGDOM"/>
    <VERSENYZO NAME="Roger MOENS"/>
    <VERSENYZO NAME="Roland WIESER"/>
    <VERSENYZO NAME="Rolf DANNEBERG"/>
    <VERSENYZO NAME="Roman SCHURENKO"/>
    <VERSENYZO NAME="Roman SEBRLE"/>
    <VERSENYZO NAME="Romas UBARTAS"/>
    <VERSENYZO NAME="Romeo BERTINI"/>
    <VERSENYZO NAME="Romuald KLIM"/>
    <VERSENYZO NAME="Ron CLARKE"/>
    <VERSENYZO NAME="Ron DELANY"/>
    <VERSENYZO NAME="Ron FREEMAN"/>
    <VERSENYZO NAME="Ronald MORRIS"/>
    <VERSENYZO NAME="Ronald WEIGEL"/>
    <VERSENYZO NAME="Rosa MOTA"/>
    <VERSENYZO NAME="Rosemarie WITSCHAS-ACKERMANN"/>
    <VERSENYZO NAME="Roy Braxton COCHRAN"/>
    <VERSENYZO NAME="Rui SILVA"/>
    <VERSENYZO NAME="Rune LARSSON"/>
    <VERSENYZO NAME="Ruth BEITIA"/>
    <VERSENYZO NAME="Ruth FUCHS"/>
    <VERSENYZO NAME="Ruth JEBET"/>
    <VERSENYZO NAME="Ruth OSBURN"/>
    <VERSENYZO NAME="Ruth SVEDBERG"/>
    <VERSENYZO NAME="Ryan CROUSER"/>
    <VERSENYZO NAME="Ryszard KATUS"/>
    <VERSENYZO NAME="Sabine BRAUN"/>
    <VERSENYZO NAME="Sabine EVERTS"/>
    <VERSENYZO NAME="Sabine JOHN"/>
    <VERSENYZO NAME="Saida GUNBA"/>
    <VERSENYZO NAME="Salah HISSOU"/>
    <VERSENYZO NAME="Sally GUNNELL"/>
    <VERSENYZO NAME="Sally Jepkosgei KIPYEGO"/>
    <VERSENYZO NAME="Sally PEARSON"/>
    <VERSENYZO NAME="Salvatore MORALE"/>
    <VERSENYZO NAME="Sam GRADDY"/>
    <VERSENYZO NAME="Sam KENDRICKS"/>
    <VERSENYZO NAME="Samson KITUR"/>
    <VERSENYZO NAME="Samuel FERRIS"/>
    <VERSENYZO NAME="Samuel JONES"/>
    <VERSENYZO NAME="Samuel Kamau WANJIRU"/>
    <VERSENYZO NAME="Samuel MATETE"/>
    <VERSENYZO NAME="Sandi MORRIS"/>
    <VERSENYZO NAME="Sandra FARMER-PATRICK"/>
    <VERSENYZO NAME="Sandra PERKOVIC"/>
    <VERSENYZO NAME="Sandro BELLUCCI"/>
    <VERSENYZO NAME="Sanya RICHARDS-ROSS"/>
    <VERSENYZO NAME="Sara KOLAK"/>
    <VERSENYZO NAME="Sara SIMEONI"/>
    <VERSENYZO NAME="Sara Slott PETERSEN"/>
    <VERSENYZO NAME="Sarka KASPARKOVA"/>
    <VERSENYZO NAME="SaÃ¯d AOUITA"/>
    <VERSENYZO NAME="Schuyler ENCK"/>
    <VERSENYZO NAME="Sebastian COE"/>
    <VERSENYZO NAME="Semyon RZISHCHIN"/>
    <VERSENYZO NAME="Seppo RÃ&#x84;TY"/>
    <VERSENYZO NAME="Sergei ZHELANOV"/>
    <VERSENYZO NAME="Sergey KLYUGIN"/>
    <VERSENYZO NAME="Sergey LITVINOV"/>
    <VERSENYZO NAME="Sergey MAKAROV"/>
    <VERSENYZO NAME="Setymkul DZHUMANAZAROV"/>
    <VERSENYZO NAME="Shalane FLANAGAN"/>
    <VERSENYZO NAME="Shaunae MILLER"/>
    <VERSENYZO NAME="Shawn CRAWFORD"/>
    <VERSENYZO NAME="Sheena TOSTA"/>
    <VERSENYZO NAME="Sheila LERWILL"/>
    <VERSENYZO NAME="Shelly-Ann FRASER-PRYCE"/>
    <VERSENYZO NAME="Shenjie QIEYANG"/>
    <VERSENYZO NAME="Shericka JACKSON"/>
    <VERSENYZO NAME="Shericka WILLIAMS"/>
    <VERSENYZO NAME="Sherone SIMPSON"/>
    <VERSENYZO NAME="Shirley CAWLEY"/>
    <VERSENYZO NAME="Shirley STRICKLAND"/>
    <VERSENYZO NAME="Shirley STRONG"/>
    <VERSENYZO NAME="Shoryu NAN"/>
    <VERSENYZO NAME="Shuhei NISHIDA"/>
    <VERSENYZO NAME="Sidney ATKINSON"/>
    <VERSENYZO NAME="Sidney ROBINSON"/>
    <VERSENYZO NAME="Siegfried WENTZ"/>
    <VERSENYZO NAME="Sileshi SIHINE"/>
    <VERSENYZO NAME="Silke RENK"/>
    <VERSENYZO NAME="Silvia CHIVAS BARO"/>
    <VERSENYZO NAME="Silvio LEONARD SARRIA"/>
    <VERSENYZO NAME="Sim INESS"/>
    <VERSENYZO NAME="Simeon TORIBIO"/>
    <VERSENYZO NAME="Sofia ASSEFA"/>
    <VERSENYZO NAME="Sonia O'SULLIVAN"/>
    <VERSENYZO NAME="Sophie HITCHON"/>
    <VERSENYZO NAME="Sotirios VERSIS"/>
    <VERSENYZO NAME="Spyridon LOUIS"/>
    <VERSENYZO NAME="Stacy DRAGILA"/>
    <VERSENYZO NAME="Stanislawa WALASIEWICZ"/>
    <VERSENYZO NAME="Stanley Frank VICKERS"/>
    <VERSENYZO NAME="Stanley ROWLEY"/>
    <VERSENYZO NAME="Stefan HOLM"/>
    <VERSENYZO NAME="Stefano BALDINI"/>
    <VERSENYZO NAME="Steffi NERIUS"/>
    <VERSENYZO NAME="Stefka KOSTADINOVA"/>
    <VERSENYZO NAME="Sten PETTERSSON"/>
    <VERSENYZO NAME="Stephan FREIGANG"/>
    <VERSENYZO NAME="Stephanie BROWN TRAFTON"/>
    <VERSENYZO NAME="Stephanie GRAF"/>
    <VERSENYZO NAME="Stephen KIPKORIR"/>
    <VERSENYZO NAME="Stephen KIPROTICH"/>
    <VERSENYZO NAME="Steve ANDERSON"/>
    <VERSENYZO NAME="Steve BACKLEY"/>
    <VERSENYZO NAME="Steve CRAM"/>
    <VERSENYZO NAME="Steve HOOKER"/>
    <VERSENYZO NAME="Steve LEWIS"/>
    <VERSENYZO NAME="Steve OVETT"/>
    <VERSENYZO NAME="Steve SMITH"/>
    <VERSENYZO NAME="Suleiman NYAMBUI"/>
    <VERSENYZO NAME="Sulo BÃ&#x84;RLUND"/>
    <VERSENYZO NAME="Sunette VILJOEN"/>
    <VERSENYZO NAME="Susanthika JAYASINGHE"/>
    <VERSENYZO NAME="Sverre HANSEN"/>
    <VERSENYZO NAME="Svetlana FEOFANOVA"/>
    <VERSENYZO NAME="Svetlana KRIVELYOVA"/>
    <VERSENYZO NAME="Svetlana MASTERKOVA"/>
    <VERSENYZO NAME="Svetlana SHKOLINA"/>
    <VERSENYZO NAME="Sylvio CATOR"/>
    <VERSENYZO NAME="Szymon ZIOLKOWSKI"/>
    <VERSENYZO NAME="SÃ&#x83;Â¡ndor ROZSNYÃ&#x83;?I"/>
    <VERSENYZO NAME="Tadeusz RUT"/>
    <VERSENYZO NAME="Tadeusz SLUSARSKI"/>
    <VERSENYZO NAME="Taisiya CHENCHIK"/>
    <VERSENYZO NAME="Tamara PRESS"/>
    <VERSENYZO NAME="Tamirat TOLA"/>
    <VERSENYZO NAME="Tanya LAWRENCE"/>
    <VERSENYZO NAME="Taoufik MAKHLOUFI"/>
    <VERSENYZO NAME="Tapio KANTANEN"/>
    <VERSENYZO NAME="Tariku BEKELE"/>
    <VERSENYZO NAME="Tatiana ANISIMOVA"/>
    <VERSENYZO NAME="Tatiana GRIGORIEVA"/>
    <VERSENYZO NAME="Tatiana KAZANKINA"/>
    <VERSENYZO NAME="Tatiana KOLPAKOVA"/>
    <VERSENYZO NAME="Tatiana LESOVAIA"/>
    <VERSENYZO NAME="Tatiana PROVIDOKHINA"/>
    <VERSENYZO NAME="Tatiana SKACHKO"/>
    <VERSENYZO NAME="Tatyana CHERNOVA"/>
    <VERSENYZO NAME="Tatyana KOTOVA"/>
    <VERSENYZO NAME="Tatyana LEBEDEVA"/>
    <VERSENYZO NAME="Tatyana PETROVA ARKHIPOVA"/>
    <VERSENYZO NAME="Tatyana SHCHELKANOVA"/>
    <VERSENYZO NAME="Tatyana TOMASHOVA"/>
    <VERSENYZO NAME="Terence Lloyd JOHNSON"/>
    <VERSENYZO NAME="Tereza MARINOVA"/>
    <VERSENYZO NAME="Tero PITKAMAKI"/>
    <VERSENYZO NAME="Terrence TRAMMELL"/>
    <VERSENYZO NAME="Tesfaye TOLA"/>
    <VERSENYZO NAME="Tetyana TERESHCHUK"/>
    <VERSENYZO NAME="Thaddeus SHIDELER"/>
    <VERSENYZO NAME="Thane BAKER"/>
    <VERSENYZO NAME="Theresia KIESL"/>
    <VERSENYZO NAME="Thiago Braz DA SILVA"/>
    <VERSENYZO NAME="Thomas BURKE"/>
    <VERSENYZO NAME="Thomas COURTNEY"/>
    <VERSENYZO NAME="Thomas CURTIS"/>
    <VERSENYZO NAME="Thomas EVENSON"/>
    <VERSENYZO NAME="Thomas Francis FARRELL"/>
    <VERSENYZO NAME="Thomas Francis KIELY"/>
    <VERSENYZO NAME="Thomas HAMPSON"/>
    <VERSENYZO NAME="Thomas HICKS"/>
    <VERSENYZO NAME="Thomas HILL"/>
    <VERSENYZO NAME="Thomas JEFFERSON"/>
    <VERSENYZO NAME="Thomas John Henry RICHARDS"/>
    <VERSENYZO NAME="Thomas LIEB"/>
    <VERSENYZO NAME="Thomas MUNKELT"/>
    <VERSENYZO NAME="Thomas Pkemei LONGOSIWA"/>
    <VERSENYZO NAME="Thomas ROHLER"/>
    <VERSENYZO NAME="Thomas William GREEN"/>
    <VERSENYZO NAME="Tia HELLEBAUT"/>
    <VERSENYZO NAME="Tianfeng SI"/>
    <VERSENYZO NAME="Tianna BARTOLETTA"/>
    <VERSENYZO NAME="Tiki GELANA"/>
    <VERSENYZO NAME="Tilly FLEISCHER"/>
    <VERSENYZO NAME="Tim AHEARNE"/>
    <VERSENYZO NAME="Tim FORSYTH"/>
    <VERSENYZO NAME="Timothy KITUM"/>
    <VERSENYZO NAME="Timothy MACK"/>
    <VERSENYZO NAME="Tirunesh DIBABA"/>
    <VERSENYZO NAME="Toby STEVENSON"/>
    <VERSENYZO NAME="Toivo HYYTIÃ&#x84;INEN"/>
    <VERSENYZO NAME="Toivo LOUKOLA"/>
    <VERSENYZO NAME="Tomas WALSH"/>
    <VERSENYZO NAME="Tomasz MAJEWSKI"/>
    <VERSENYZO NAME="Tommie SMITH"/>
    <VERSENYZO NAME="TomÃ¡? DVORÃ&#x81;K"/>
    <VERSENYZO NAME="Tonique WILLIAMS-DARLING"/>
    <VERSENYZO NAME="Tonja BUFORD-BAILEY"/>
    <VERSENYZO NAME="Tony DEES"/>
    <VERSENYZO NAME="Tore SJÃ&#x96;STRAND"/>
    <VERSENYZO NAME="Tori BOWIE"/>
    <VERSENYZO NAME="Torsten VOSS"/>
    <VERSENYZO NAME="Trey HARDEE"/>
    <VERSENYZO NAME="Trine HATTESTAD"/>
    <VERSENYZO NAME="Truxtun HARE"/>
    <VERSENYZO NAME="Tsegay KEBEDE"/>
    <VERSENYZO NAME="Tsvetanka KHRISTOVA"/>
    <VERSENYZO NAME="Udo BEYER"/>
    <VERSENYZO NAME="Ugo FRIGERIO"/>
    <VERSENYZO NAME="Ulrike KLAPEZYNSKI-BRUNS"/>
    <VERSENYZO NAME="Ursula DONATH"/>
    <VERSENYZO NAME="Urszula KIELAN"/>
    <VERSENYZO NAME="Usain BOLT"/>
    <VERSENYZO NAME="Ute HOMMOLA"/>
    <VERSENYZO NAME="Uwe BEYER"/>
    <VERSENYZO NAME="Vadim DEVYATOVSKIY"/>
    <VERSENYZO NAME="Vadims VASILEVSKIS"/>
    <VERSENYZO NAME="Vala FLOSADÃ&#x93;TTIR"/>
    <VERSENYZO NAME="Valentin MASSANA"/>
    <VERSENYZO NAME="Valentina YEGOROVA"/>
    <VERSENYZO NAME="Valeri BRUMEL"/>
    <VERSENYZO NAME="Valeri PODLUZHNYI"/>
    <VERSENYZO NAME="Valeria BUFANU"/>
    <VERSENYZO NAME="Valerie ADAMS"/>
    <VERSENYZO NAME="Valerie BRISCO"/>
    <VERSENYZO NAME="Valerio ARRI"/>
    <VERSENYZO NAME="Valeriy BORCHIN"/>
    <VERSENYZO NAME="Valery BORZOV"/>
    <VERSENYZO NAME="Vanderlei DE LIMA"/>
    <VERSENYZO NAME="Vasili ARKHIPENKO"/>
    <VERSENYZO NAME="Vasili RUDENKOV"/>
    <VERSENYZO NAME="Vasiliy KAPTYUKH"/>
    <VERSENYZO NAME="Vasily KUZNETSOV"/>
    <VERSENYZO NAME="Vassilka STOEVA"/>
    <VERSENYZO NAME="VebjÃ¸rn RODAL"/>
    <VERSENYZO NAME="Veikko KARVONEN"/>
    <VERSENYZO NAME="Veniamin SOLDATENKO"/>
    <VERSENYZO NAME="Venuste NIYONGABO"/>
    <VERSENYZO NAME="Vera KOLASHNIKOVA-KREPKINA"/>
    <VERSENYZO NAME="Vera KOMISOVA"/>
    <VERSENYZO NAME="Vera POSPISILOVA-CECHLOVA"/>
    <VERSENYZO NAME="Veronica CAMPBELL-BROWN"/>
    <VERSENYZO NAME="Viktor KRAVCHENKO"/>
    <VERSENYZO NAME="Viktor MARKIN"/>
    <VERSENYZO NAME="Viktor RASHCHUPKIN"/>
    <VERSENYZO NAME="Viktor SANEYEV"/>
    <VERSENYZO NAME="Viktor TSYBULENKO"/>
    <VERSENYZO NAME="Vilho Aleksander NIITTYMAA"/>
    <VERSENYZO NAME="Ville PÃ&#x96;RHÃ&#x96;LÃ&#x84;"/>
    <VERSENYZO NAME="Ville RITOLA"/>
    <VERSENYZO NAME="Ville TUULOS"/>
    <VERSENYZO NAME="Vilmos VARJU"/>
    <VERSENYZO NAME="Vince MATTHEWS"/>
    <VERSENYZO NAME="Violeta SZEKELY"/>
    <VERSENYZO NAME="Virgilijus ALEKNA"/>
    <VERSENYZO NAME="Vita STYOPINA"/>
    <VERSENYZO NAME="Vitold KREYER"/>
    <VERSENYZO NAME="Vivian Jepkemoi CHERUIYOT"/>
    <VERSENYZO NAME="Vladimir ANDREYEV"/>
    <VERSENYZO NAME="Vladimir DUBROVSHCHIK"/>
    <VERSENYZO NAME="Vladimir GOLUBNICHY"/>
    <VERSENYZO NAME="Vladimir GORYAYEV"/>
    <VERSENYZO NAME="Vladimir KAZANTSEV"/>
    <VERSENYZO NAME="Vladimir KISELEV"/>
    <VERSENYZO NAME="Vladimir KUTS"/>
    <VERSENYZO NAME="Voitto HELLSTEN"/>
    <VERSENYZO NAME="Volker BECK"/>
    <VERSENYZO NAME="Volmari ISO-HOLLO"/>
    <VERSENYZO NAME="Voula PATOULIDOU"/>
    <VERSENYZO NAME="Vyacheslav IVANENKO"/>
    <VERSENYZO NAME="Vyacheslav LYKHO"/>
    <VERSENYZO NAME="Waldemar CIERPINSKI"/>
    <VERSENYZO NAME="Walt DAVIS"/>
    <VERSENYZO NAME="Walter DIX"/>
    <VERSENYZO NAME="Walter KRÃ&#x9c;GER"/>
    <VERSENYZO NAME="Walter RANGELEY"/>
    <VERSENYZO NAME="Walter TEWKSBURY"/>
    <VERSENYZO NAME="Warren (Rex) Jay CAWLEY"/>
    <VERSENYZO NAME="Warren WEIR"/>
    <VERSENYZO NAME="Wayde VAN NIEKERK"/>
    <VERSENYZO NAME="Wayne COLLETT"/>
    <VERSENYZO NAME="Wendell MOTTLEY"/>
    <VERSENYZO NAME="Wenxiu ZHANG"/>
    <VERSENYZO NAME="Werner LUEG"/>
    <VERSENYZO NAME="Wesley COE"/>
    <VERSENYZO NAME="Wilfred BUNGEI"/>
    <VERSENYZO NAME="Wilhelmina VON BREMEN"/>
    <VERSENYZO NAME="Will CLAYE"/>
    <VERSENYZO NAME="Willem SLIJKHUIS"/>
    <VERSENYZO NAME="Willi HOLDORF"/>
    <VERSENYZO NAME="William APPLEGARTH"/>
    <VERSENYZO NAME="William Arthur CARR"/>
    <VERSENYZO NAME="William CROTHERS"/>
    <VERSENYZO NAME="William De Hart HUBBARD"/>
    <VERSENYZO NAME="William HAPPENNY"/>
    <VERSENYZO NAME="William HOGENSON"/>
    <VERSENYZO NAME="William HOLLAND"/>
    <VERSENYZO NAME="William MUTWOL"/>
    <VERSENYZO NAME="William NIEDER"/>
    <VERSENYZO NAME="William Preston MILLER"/>
    <VERSENYZO NAME="William TANUI"/>
    <VERSENYZO NAME="William VERNER"/>
    <VERSENYZO NAME="William Waring MILLER"/>
    <VERSENYZO NAME="William Welles HOYT"/>
    <VERSENYZO NAME="Willie DAVENPORT"/>
    <VERSENYZO NAME="Willie MAY"/>
    <VERSENYZO NAME="Willy SCHÃ&#x84;RER"/>
    <VERSENYZO NAME="Wilma RUDOLPH"/>
    <VERSENYZO NAME="Wilson Boit KIPKETER"/>
    <VERSENYZO NAME="Wilson KIPKETER"/>
    <VERSENYZO NAME="Wilson KIPRUGUT"/>
    <VERSENYZO NAME="Wilson Kipsang KIPROTICH"/>
    <VERSENYZO NAME="Winthrop GRAHAM"/>
    <VERSENYZO NAME="Wladyslaw KOZAKIEWICZ"/>
    <VERSENYZO NAME="Wojciech NOWICKI"/>
    <VERSENYZO NAME="Wolfgang HANISCH"/>
    <VERSENYZO NAME="Wolfgang REINHARDT"/>
    <VERSENYZO NAME="Wolfgang SCHMIDT"/>
    <VERSENYZO NAME="Wolrad EBERLE"/>
    <VERSENYZO NAME="Wyndham HALSWELLE"/>
    <VERSENYZO NAME="Wyomia TYUS"/>
    <VERSENYZO NAME="Xiang LIU"/>
    <VERSENYZO NAME="Ximena RESTREPO"/>
    <VERSENYZO NAME="Xinmei SUI"/>
    <VERSENYZO NAME="Xiuzhi LU"/>
    <VERSENYZO NAME="Yanfeng LI"/>
    <VERSENYZO NAME="Yanina KAROLCHIK"/>
    <VERSENYZO NAME="Yanis LUSIS"/>
    <VERSENYZO NAME="Yarelys BARRIOS"/>
    <VERSENYZO NAME="Yarisley SILVA"/>
    <VERSENYZO NAME="Yaroslav RYBAKOV"/>
    <VERSENYZO NAME="Yasmani COPELLO"/>
    <VERSENYZO NAME="Yelena GORCHAKOVA"/>
    <VERSENYZO NAME="Yelena ISINBAEVA"/>
    <VERSENYZO NAME="Yelena PROKHOROVA"/>
    <VERSENYZO NAME="Yelena YELESINA"/>
    <VERSENYZO NAME="Yelizaveta BAGRYANTSEVA"/>
    <VERSENYZO NAME="Yevgeni ARZHANOV"/>
    <VERSENYZO NAME="Yevgeni GAVRILENKO"/>
    <VERSENYZO NAME="Yevgeni MASKINSKOV"/>
    <VERSENYZO NAME="Yevgeny Mikhaylovich IVCHENKO"/>
    <VERSENYZO NAME="Yipsi MORENO"/>
    <VERSENYZO NAME="Yoel GARCÃ&#x8d;A"/>
    <VERSENYZO NAME="Yoelvis QUESADA"/>
    <VERSENYZO NAME="Yohan BLAKE"/>
    <VERSENYZO NAME="Yordanka BLAGOEVA-DIMITROVA"/>
    <VERSENYZO NAME="Yordanka DONKOVA"/>
    <VERSENYZO NAME="Young-Cho HWANG"/>
    <VERSENYZO NAME="Yuko ARIMORI"/>
    <VERSENYZO NAME="Yulimar ROJAS"/>
    <VERSENYZO NAME="Yuliya NESTSIARENKA"/>
    <VERSENYZO NAME="Yumileidi CUMBA"/>
    <VERSENYZO NAME="Yunaika CRAWFORD"/>
    <VERSENYZO NAME="Yunxia QU"/>
    <VERSENYZO NAME="Yuri KUTSENKO"/>
    <VERSENYZO NAME="Yuri SEDYKH"/>
    <VERSENYZO NAME="Yuri TAMM"/>
    <VERSENYZO NAME="Yuriy BORZAKOVSKIY"/>
    <VERSENYZO NAME="Yury Nikolayevich LITUYEV"/>
    <VERSENYZO NAME="Yvette WILLIAMS"/>
    <VERSENYZO NAME="Zdzislaw KRZYSZKOWIAK"/>
    <VERSENYZO NAME="Zelin CAI"/>
    <VERSENYZO NAME="Zersenay TADESE"/>
    <VERSENYZO NAME="Zhen WANG"/>
    <VERSENYZO NAME="Zhihong HUANG"/>
    <VERSENYZO NAME="Zoltan KOVAGO"/>
    <VERSENYZO NAME="Zuzana HEJNOVA"/>
    <VERSENYZO NAME="Ã&#x83;â&#x80;&#x93;dÃ&#x83;Â¶n FÃ&#x83;â&#x80;&#x93;LDESSY"/>
    <VERSENYZO NAME="Ã&#x89;mile CHAMPION"/>
</VERSENYZOK>
```
**7. lekérdezés:**

A lekérdezés egy olyan XML dokumentumot állít elő, amely kilistázza, hogy melyik versenyző, hányszor
vett részt az olimpián.

```xquery
xquery version "3.1";

import schema default element namespace "" at "7_feladat.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:indent "yes";
let $json := fn:json-doc("../olympic_results.json")?*

let $names := distinct-values(for $game in $json?games?*
                                for $result in $game?results?*
                                    return $result?name)

return validate {document {
            <VERSENYZOK ALL="{count($names)}">
                {
                    for $game in $json?games?*
                        for $result in $game?results?*
                        group by $name := $result?name
                        let $count := fn:count($result)
                        order by $name
                        return <VERSENYZO NEV="{$name}" HANYSZOR="{$count}"/>
                }
            </VERSENYZOK>
        }}
```
**Eredmény:**
```XML
<VERSENYZOK ALL="1681">
    <VERSENYZO NEV="" HANYSZOR="230"/>
    <VERSENYZO NEV="Abdalaati IGUIDER" HANYSZOR="1"/>
    <VERSENYZO NEV="Abderrahmane HAMMAD" HANYSZOR="1"/>
    <VERSENYZO NEV="Abdesiem RHADI BEN ABDESSELEM" HANYSZOR="1"/>
    <VERSENYZO NEV="Abdon PAMICH" HANYSZOR="2"/>
    <VERSENYZO NEV="Abdoulaye SEYE" HANYSZOR="1"/>
    <VERSENYZO NEV="Abebe BIKILA" HANYSZOR="2"/>
    <VERSENYZO NEV="Abel KIRUI" HANYSZOR="1"/>
    <VERSENYZO NEV="Abel KIVIAT" HANYSZOR="1"/>
    <VERSENYZO NEV="Abel Kiprop MUTAI" HANYSZOR="1"/>
    <VERSENYZO NEV="Adalberts BUBENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Adam GUNN" HANYSZOR="1"/>
    <VERSENYZO NEV="Adam NELSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Addis ABEBE" HANYSZOR="1"/>
    <VERSENYZO NEV="Adhemar DA SILVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Adolfo CONSOLINI" HANYSZOR="1"/>
    <VERSENYZO NEV="Aigars FADEJEVS" HANYSZOR="1"/>
    <VERSENYZO NEV="Ainars KOVALS" HANYSZOR="1"/>
    <VERSENYZO NEV="Aki JÃ&#x84;RVINEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Al BATES" HANYSZOR="1"/>
    <VERSENYZO NEV="Al OERTER" HANYSZOR="3"/>
    <VERSENYZO NEV="Alain MIMOUN" HANYSZOR="4"/>
    <VERSENYZO NEV="Alajos SZOKOLYI" HANYSZOR="1"/>
    <VERSENYZO NEV="Albert CORAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Albert GUTTERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Albert HILL" HANYSZOR="2"/>
    <VERSENYZO NEV="Albert TYLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Alberto COVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Alberto JUANTORENA" HANYSZOR="2"/>
    <VERSENYZO NEV="Albin LERMUSIAUX" HANYSZOR="1"/>
    <VERSENYZO NEV="Albin STENROOS" HANYSZOR="2"/>
    <VERSENYZO NEV="Alejandro CASAÃ&#x91;AS" HANYSZOR="2"/>
    <VERSENYZO NEV="Aleksander TAMMERT" HANYSZOR="1"/>
    <VERSENYZO NEV="Aleksandr ANUFRIYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Aleksandr BARYSHNIKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Aleksandr MAKAROV" HANYSZOR="1"/>
    <VERSENYZO NEV="Aleksandr PUCHKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Aleksandra CHUDINA" HANYSZOR="3"/>
    <VERSENYZO NEV="Aleksei SPIRIDONOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Aleksey VOYEVODIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Alessandro ANDREI" HANYSZOR="1"/>
    <VERSENYZO NEV="Alessandro LAMBRUSCHINI" HANYSZOR="1"/>
    <VERSENYZO NEV="Alex SCHWAZER" HANYSZOR="1"/>
    <VERSENYZO NEV="Alex WILSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Alexander KLUMBERG-KOLMPERE" HANYSZOR="1"/>
    <VERSENYZO NEV="Alexandre TUFFERI" HANYSZOR="1"/>
    <VERSENYZO NEV="Alfred Carleten GILBERT" HANYSZOR="1"/>
    <VERSENYZO NEV="Alfred DOMPERT" HANYSZOR="1"/>
    <VERSENYZO NEV="Alfred Kirwa YEGO" HANYSZOR="1"/>
    <VERSENYZO NEV="Alfred TYSOE" HANYSZOR="1"/>
    <VERSENYZO NEV="Ali EZZINE" HANYSZOR="1"/>
    <VERSENYZO NEV="Ali SAIDI-SIEF" HANYSZOR="1"/>
    <VERSENYZO NEV="Alice BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Alice COACHMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Allan LAWRENCE" HANYSZOR="1"/>
    <VERSENYZO NEV="Allan WELLS" HANYSZOR="2"/>
    <VERSENYZO NEV="Allen JOHNSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Allen WOODRING" HANYSZOR="1"/>
    <VERSENYZO NEV="Allyson FELIX" HANYSZOR="4"/>
    <VERSENYZO NEV="Alma RICHARDS" HANYSZOR="1"/>
    <VERSENYZO NEV="Almaz AYANA" HANYSZOR="2"/>
    <VERSENYZO NEV="Alonzo BABERS" HANYSZOR="1"/>
    <VERSENYZO NEV="Alvah MEYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Alvin HARRISON" HANYSZOR="1"/>
    <VERSENYZO NEV="Alvin KRAENZLEIN" HANYSZOR="2"/>
    <VERSENYZO NEV="Amos BIWOTT" HANYSZOR="1"/>
    <VERSENYZO NEV="Ana Fidelia QUIROT" HANYSZOR="2"/>
    <VERSENYZO NEV="Ana GUEVARA" HANYSZOR="1"/>
    <VERSENYZO NEV="Anastasia KELESIDOU" HANYSZOR="2"/>
    <VERSENYZO NEV="Anatoli BONDARCHUK" HANYSZOR="1"/>
    <VERSENYZO NEV="Anatoly MIKHAYLOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Anders GARDERUD" HANYSZOR="1"/>
    <VERSENYZO NEV="Andre DE GRASSE" HANYSZOR="2"/>
    <VERSENYZO NEV="Andreas THORKILDSEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Andrei KRAUCHANKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Andrei TIVONTCHIK" HANYSZOR="1"/>
    <VERSENYZO NEV="Andrey ABDUVALIEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Andrey PERLOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Andrey SILNOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Andrzej BADENSKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Andy STANFIELD" HANYSZOR="2"/>
    <VERSENYZO NEV="Angela NEMETH" HANYSZOR="1"/>
    <VERSENYZO NEV="Angela VOIGT" HANYSZOR="1"/>
    <VERSENYZO NEV="Angelo TAYLOR" HANYSZOR="2"/>
    <VERSENYZO NEV="Anier GARCIA" HANYSZOR="2"/>
    <VERSENYZO NEV="Anita MARTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Anita WLODARCZYK" HANYSZOR="2"/>
    <VERSENYZO NEV="Anke BEHMER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ann Marise CHAMBERLAIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ann PACKER" HANYSZOR="2"/>
    <VERSENYZO NEV="Anna CHICHEROVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Anna ROGOWSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Annegret RICHTER-IRRGANG" HANYSZOR="2"/>
    <VERSENYZO NEV="Annelie EHRHARDT" HANYSZOR="1"/>
    <VERSENYZO NEV="Antal KISS" HANYSZOR="1"/>
    <VERSENYZO NEV="Antal RÃ&#x93;KA" HANYSZOR="1"/>
    <VERSENYZO NEV="Antanas MIKENAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Antonio MCKAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Antonio PENALVER ASENSIO" HANYSZOR="1"/>
    <VERSENYZO NEV="Antti RUUSKANEN" HANYSZOR="1"/>
    <VERSENYZO NEV="AntÃ³nio LEITÃ&#x83;O" HANYSZOR="1"/>
    <VERSENYZO NEV="Archibald Franklin WILLIAMS" HANYSZOR="1"/>
    <VERSENYZO NEV="Archie HAHN" HANYSZOR="2"/>
    <VERSENYZO NEV="Ardalion IGNATYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Argentina MENIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Aries MERRITT" HANYSZOR="1"/>
    <VERSENYZO NEV="Armas TAIPALE" HANYSZOR="1"/>
    <VERSENYZO NEV="Armas TOIVONEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Armin HARY" HANYSZOR="1"/>
    <VERSENYZO NEV="Arne HALSE" HANYSZOR="1"/>
    <VERSENYZO NEV="Arnie ROBINSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Arnold JACKSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Arnoldo DEVONISH" HANYSZOR="1"/>
    <VERSENYZO NEV="Arsi HARJU" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur BARNARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur BLAKE" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur JONATH" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur NEWTON" HANYSZOR="2"/>
    <VERSENYZO NEV="Arthur PORRITT" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur SCHWAB" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur SHAW" HANYSZOR="1"/>
    <VERSENYZO NEV="Arthur WINT" HANYSZOR="3"/>
    <VERSENYZO NEV="Arto BRYGGARE" HANYSZOR="1"/>
    <VERSENYZO NEV="Arto HÃ&#x84;RKÃ&#x96;NEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Artur PARTYKA" HANYSZOR="2"/>
    <VERSENYZO NEV="Arvo ASKOLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Asbel Kipruto KIPROP" HANYSZOR="1"/>
    <VERSENYZO NEV="Ashley SPENCER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ashton EATON" HANYSZOR="2"/>
    <VERSENYZO NEV="Assefa MEZGEBU" HANYSZOR="1"/>
    <VERSENYZO NEV="Astrid KUMBERNUSS" HANYSZOR="2"/>
    <VERSENYZO NEV="Athanasia TSOUMELEKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ato BOLDON" HANYSZOR="4"/>
    <VERSENYZO NEV="Audrey PATTERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Audrey WILLIAMSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Audun BOYSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="August DESCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Austra SKUJYTE" HANYSZOR="1"/>
    <VERSENYZO NEV="BalÃ¡zs KISS" HANYSZOR="1"/>
    <VERSENYZO NEV="Barbara FERRELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Barbora SPOTAKOVA" HANYSZOR="3"/>
    <VERSENYZO NEV="Barney EWELL" HANYSZOR="2"/>
    <VERSENYZO NEV="Barry MAGEE" HANYSZOR="1"/>
    <VERSENYZO NEV="Basil HEATLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Ben JIPCHO" HANYSZOR="1"/>
    <VERSENYZO NEV="Ben JOHNSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Benita FITZGERALD-BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Benjamin Bangs EASTMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Benjamin KOGO" HANYSZOR="1"/>
    <VERSENYZO NEV="Bernard LAGAT" HANYSZOR="2"/>
    <VERSENYZO NEV="Bernard WILLIAMS III" HANYSZOR="1"/>
    <VERSENYZO NEV="Bernardo SEGURA" HANYSZOR="1"/>
    <VERSENYZO NEV="Bernd KANNENBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Bershawn JACKSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Bertha BROUWER" HANYSZOR="1"/>
    <VERSENYZO NEV="Bertil ALBERTSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Bertil OHLSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Bertil UGGLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Betty CUTHBERT" HANYSZOR="3"/>
    <VERSENYZO NEV="Betty HEIDLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Beverly MCDONALD" HANYSZOR="1"/>
    <VERSENYZO NEV="Bevil RUDD" HANYSZOR="2"/>
    <VERSENYZO NEV="Bill DELLINGER" HANYSZOR="1"/>
    <VERSENYZO NEV="Bill PORTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Bill TOOMEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Billy MILLS" HANYSZOR="1"/>
    <VERSENYZO NEV="Bin DONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Birute KALEDIENE" HANYSZOR="1"/>
    <VERSENYZO NEV="Bjorn OTTO" HANYSZOR="1"/>
    <VERSENYZO NEV="Blaine LINDGREN" HANYSZOR="1"/>
    <VERSENYZO NEV="Blanka VLASIC" HANYSZOR="2"/>
    <VERSENYZO NEV="Blessing OKAGBARE" HANYSZOR="1"/>
    <VERSENYZO NEV="Bo GUSTAFSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Bob HAYES" HANYSZOR="1"/>
    <VERSENYZO NEV="Bob MATHIAS" HANYSZOR="2"/>
    <VERSENYZO NEV="Bob RICHARDS" HANYSZOR="1"/>
    <VERSENYZO NEV="Bobby MORROW" HANYSZOR="2"/>
    <VERSENYZO NEV="Bodo TÃ&#x9c;MMLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Bohdan BONDARENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Bong Ju LEE" HANYSZOR="1"/>
    <VERSENYZO NEV="Boniface MUCHERU" HANYSZOR="1"/>
    <VERSENYZO NEV="BoughÃ¨ra EL OUAFI" HANYSZOR="1"/>
    <VERSENYZO NEV="Brahim LAHLAFI" HANYSZOR="1"/>
    <VERSENYZO NEV="Brenda JONES" HANYSZOR="1"/>
    <VERSENYZO NEV="Brendan FOSTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Brian Lee DIEMER" HANYSZOR="1"/>
    <VERSENYZO NEV="Brianna ROLLINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Brianne THEISEN EATON" HANYSZOR="1"/>
    <VERSENYZO NEV="Brigetta BARRETT" HANYSZOR="1"/>
    <VERSENYZO NEV="Brigita BUKOVEC" HANYSZOR="1"/>
    <VERSENYZO NEV="Brigitte WUJAK" HANYSZOR="1"/>
    <VERSENYZO NEV="Brimin Kiprop KIPRUTO" HANYSZOR="2"/>
    <VERSENYZO NEV="Brittney REESE" HANYSZOR="2"/>
    <VERSENYZO NEV="Bronislaw MALINOWSKI" HANYSZOR="2"/>
    <VERSENYZO NEV="Bruce JENNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Bruno JUNK" HANYSZOR="1"/>
    <VERSENYZO NEV="Bruno SÃ&#x96;DERSTRÃ&#x96;M" HANYSZOR="1"/>
    <VERSENYZO NEV="Brutus HAMILTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Bryan CLAY" HANYSZOR="2"/>
    <VERSENYZO NEV="Bud HOUSER" HANYSZOR="2"/>
    <VERSENYZO NEV="BÃ¤rbel ECKERT-WÃ&#x96;CKEL" HANYSZOR="2"/>
    <VERSENYZO NEV="Calvin BRICKER" HANYSZOR="2"/>
    <VERSENYZO NEV="Calvin DAVIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Carl Albert ANDERSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Carl KAUFMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Carl LEWIS" HANYSZOR="4"/>
    <VERSENYZO NEV="Carlos LOPES" HANYSZOR="2"/>
    <VERSENYZO NEV="Carlos MERCENARIO" HANYSZOR="1"/>
    <VERSENYZO NEV="Carmelita JETER" HANYSZOR="2"/>
    <VERSENYZO NEV="Carolina KLUFT" HANYSZOR="1"/>
    <VERSENYZO NEV="Caster SEMENYA" HANYSZOR="2"/>
    <VERSENYZO NEV="Caterine IBARGUEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Catherine Laverne MCMILLAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Catherine NDEREBA" HANYSZOR="2"/>
    <VERSENYZO NEV="Cathy FREEMAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Chandra CHEESEBOROUGH" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles AUSTIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles BACON" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles BENNETT" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles DVORAK" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles GMELIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles HEFFERON" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles Hewes Jr. MOORE" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles JACOBS" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles JENKINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles LOMBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles PADDOCK" HANYSZOR="3"/>
    <VERSENYZO NEV="Charles REIDPATH" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles SIMPKINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Charles SPEDDING" HANYSZOR="1"/>
    <VERSENYZO NEV="Charlie GREENE" HANYSZOR="1"/>
    <VERSENYZO NEV="Chioma AJUNWA" HANYSZOR="1"/>
    <VERSENYZO NEV="Chris HUFFINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Christa STUBNICK" HANYSZOR="2"/>
    <VERSENYZO NEV="Christian CANTWELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Christian OLSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Christian SCHENK" HANYSZOR="1"/>
    <VERSENYZO NEV="Christian TAYLOR" HANYSZOR="2"/>
    <VERSENYZO NEV="Christian W. GITSHAM" HANYSZOR="1"/>
    <VERSENYZO NEV="Christiane STOLL-WARTENBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Christina BREHMER-LATHAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Christina OBERGFOLL" HANYSZOR="2"/>
    <VERSENYZO NEV="Christine OHURUOGU" HANYSZOR="2"/>
    <VERSENYZO NEV="Christoph HARTING" HANYSZOR="1"/>
    <VERSENYZO NEV="Christoph HÃ&#x96;HNE" HANYSZOR="1"/>
    <VERSENYZO NEV="Christophe LEMAITRE" HANYSZOR="1"/>
    <VERSENYZO NEV="Christopher William BRASHER" HANYSZOR="1"/>
    <VERSENYZO NEV="Chuan-Kwang YANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Chuhei NAMBU" HANYSZOR="2"/>
    <VERSENYZO NEV="Chunxiu ZHOU" HANYSZOR="1"/>
    <VERSENYZO NEV="Clarence CHILDS" HANYSZOR="1"/>
    <VERSENYZO NEV="Clarence DEMAR" HANYSZOR="1"/>
    <VERSENYZO NEV="Claudia LOSCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Clayton MURPHY" HANYSZOR="1"/>
    <VERSENYZO NEV="Clifton Emmett CUSHMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Clyde SCOTT" HANYSZOR="1"/>
    <VERSENYZO NEV="Colette BESSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Conseslus KIPRUTO" HANYSZOR="1"/>
    <VERSENYZO NEV="Constantina TOMESCU" HANYSZOR="1"/>
    <VERSENYZO NEV="Cornelius LEAHY" HANYSZOR="1"/>
    <VERSENYZO NEV="Cornelius WALSH" HANYSZOR="1"/>
    <VERSENYZO NEV="Craig DIXON" HANYSZOR="1"/>
    <VERSENYZO NEV="Cristina COJOCARU" HANYSZOR="1"/>
    <VERSENYZO NEV="Cy YOUNG" HANYSZOR="1"/>
    <VERSENYZO NEV="Dafne SCHIPPERS" HANYSZOR="1"/>
    <VERSENYZO NEV="Dainis KULA" HANYSZOR="1"/>
    <VERSENYZO NEV="Daley THOMPSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Dalilah MUHAMMAD" HANYSZOR="1"/>
    <VERSENYZO NEV="Dallas LONG" HANYSZOR="2"/>
    <VERSENYZO NEV="Damian WARNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Dan O'BRIEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Dana INGROVA-ZATOPKOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Dane BIRD-SMITH" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniel BAUTISTA ROCHA" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniel FRANK" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniel JASINSKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniel KELLY" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniel KINSEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniel PLAZA" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniela COSTIAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Daniil Sergeyevich BURKENYA" HANYSZOR="1"/>
    <VERSENYZO NEV="Danny HARRIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Danny MCFARLANE" HANYSZOR="1"/>
    <VERSENYZO NEV="Daphne HASENJAGER" HANYSZOR="1"/>
    <VERSENYZO NEV="Darren CAMPBELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Darrow Clarence HOOPER" HANYSZOR="1"/>
    <VERSENYZO NEV="Dave JOHNSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Dave LAUT" HANYSZOR="1"/>
    <VERSENYZO NEV="Dave SIME" HANYSZOR="1"/>
    <VERSENYZO NEV="Dave STEEN" HANYSZOR="1"/>
    <VERSENYZO NEV="David George BURGHLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="David HALL" HANYSZOR="1"/>
    <VERSENYZO NEV="David HEMERY" HANYSZOR="2"/>
    <VERSENYZO NEV="David James WOTTLE" HANYSZOR="1"/>
    <VERSENYZO NEV="David Lawson WEILL" HANYSZOR="1"/>
    <VERSENYZO NEV="David Lekuta RUDISHA" HANYSZOR="2"/>
    <VERSENYZO NEV="David NEVILLE" HANYSZOR="1"/>
    <VERSENYZO NEV="David OLIVER" HANYSZOR="1"/>
    <VERSENYZO NEV="David OTTLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="David PAYNE" HANYSZOR="1"/>
    <VERSENYZO NEV="David POWER" HANYSZOR="1"/>
    <VERSENYZO NEV="David STORL" HANYSZOR="1"/>
    <VERSENYZO NEV="Davis KAMOGA" HANYSZOR="1"/>
    <VERSENYZO NEV="Dawn HARPER" HANYSZOR="2"/>
    <VERSENYZO NEV="Dayron ROBLES" HANYSZOR="1"/>
    <VERSENYZO NEV="Debbie FERGUSON-MCKENZIE" HANYSZOR="1"/>
    <VERSENYZO NEV="DeeDee TROTTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Deena KASTOR" HANYSZOR="1"/>
    <VERSENYZO NEV="Dejen GEBREMESKEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Delfo CABRERA" HANYSZOR="1"/>
    <VERSENYZO NEV="Denia CABALLERO" HANYSZOR="1"/>
    <VERSENYZO NEV="Denis HORGAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Denis KAPUSTIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Denis NIZHEGORODOV" HANYSZOR="2"/>
    <VERSENYZO NEV="Denise LEWIS" HANYSZOR="2"/>
    <VERSENYZO NEV="Dennis MITCHELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Deon Marie HEMMINGS" HANYSZOR="2"/>
    <VERSENYZO NEV="Derartu TULU" HANYSZOR="3"/>
    <VERSENYZO NEV="Derek DROUIN" HANYSZOR="2"/>
    <VERSENYZO NEV="Derek IBBOTSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Derek JOHNSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Derrick ADKINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Derrick BREW" HANYSZOR="1"/>
    <VERSENYZO NEV="Dick Theodorus QUAX" HANYSZOR="1"/>
    <VERSENYZO NEV="Dieter BAUMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Dieter LINDNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Dilshod NAZAROV" HANYSZOR="1"/>
    <VERSENYZO NEV="Dimitri BASCOU" HANYSZOR="1"/>
    <VERSENYZO NEV="Dimitrios GOLEMIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Ding CHEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Djabir SAID GUERNI" HANYSZOR="1"/>
    <VERSENYZO NEV="Dmitriy KARPOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Doina MELINTE" HANYSZOR="2"/>
    <VERSENYZO NEV="Don BRAGG" HANYSZOR="1"/>
    <VERSENYZO NEV="Don LAZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Donald FINLAY" HANYSZOR="2"/>
    <VERSENYZO NEV="Donald James THOMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Donald LIPPINCOTT" HANYSZOR="2"/>
    <VERSENYZO NEV="Donald QUARRIE" HANYSZOR="3"/>
    <VERSENYZO NEV="Donovan BAILEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Dorothy HALL" HANYSZOR="1"/>
    <VERSENYZO NEV="Dorothy HYMAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Dorothy ODAM" HANYSZOR="2"/>
    <VERSENYZO NEV="Dorothy SHIRLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Douglas LOWE" HANYSZOR="2"/>
    <VERSENYZO NEV="Douglas WAKIIHURI" HANYSZOR="1"/>
    <VERSENYZO NEV="Duncan GILLIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Duncan MCNAUGHTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Duncan WHITE" HANYSZOR="1"/>
    <VERSENYZO NEV="Dwayne Eugene EVANS" HANYSZOR="1"/>
    <VERSENYZO NEV="Dwight PHILLIPS" HANYSZOR="1"/>
    <VERSENYZO NEV="Dwight STONES" HANYSZOR="1"/>
    <VERSENYZO NEV="Dylan ARMSTRONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Earl EBY" HANYSZOR="1"/>
    <VERSENYZO NEV="Earl JONES" HANYSZOR="1"/>
    <VERSENYZO NEV="Earl THOMSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Earlene BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Eddie SOUTHERN" HANYSZOR="1"/>
    <VERSENYZO NEV="Eddie TOLAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Eddy OTTOZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Edera CORDIALE-GENTILE" HANYSZOR="1"/>
    <VERSENYZO NEV="Edith MCGUIRE" HANYSZOR="2"/>
    <VERSENYZO NEV="Edvard LARSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Edvin WIDE" HANYSZOR="4"/>
    <VERSENYZO NEV="Edward ARCHIBALD" HANYSZOR="1"/>
    <VERSENYZO NEV="Edward Barton HAMM" HANYSZOR="1"/>
    <VERSENYZO NEV="Edward COOK" HANYSZOR="1"/>
    <VERSENYZO NEV="Edward LINDBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Edward Lansing GORDON" HANYSZOR="1"/>
    <VERSENYZO NEV="Edward Orval GOURDIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Edwin Cheruiyot SOI" HANYSZOR="1"/>
    <VERSENYZO NEV="Edwin FLACK" HANYSZOR="2"/>
    <VERSENYZO NEV="Edwin MOSES" HANYSZOR="2"/>
    <VERSENYZO NEV="Edwin ROBERTS" HANYSZOR="1"/>
    <VERSENYZO NEV="Eeles LANDSTRÃ&#x96;M" HANYSZOR="1"/>
    <VERSENYZO NEV="Eero BERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Ehsan HADADI" HANYSZOR="1"/>
    <VERSENYZO NEV="Eino PENTTILÃ&#x84;" HANYSZOR="1"/>
    <VERSENYZO NEV="Eino PURJE" HANYSZOR="1"/>
    <VERSENYZO NEV="Ejegayehu DIBABA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ekaterina POISTOGOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ekaterini STEFANIDI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ekaterini THANOU" HANYSZOR="1"/>
    <VERSENYZO NEV="Elaine THOMPSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Elana MEYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Elena LASHMANOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Elena SLESARENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Elena SOKOLOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Elfi ZINN" HANYSZOR="1"/>
    <VERSENYZO NEV="Elfriede KAUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Elias KATZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Elisa RIGAUDO" HANYSZOR="1"/>
    <VERSENYZO NEV="Eliud Kipchoge ROTICH" HANYSZOR="3"/>
    <VERSENYZO NEV="Eliza MCCARTNEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Elizabeth ROBINSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Ellen BRAUMÃ&#x9c;LLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ellen STROPAHL-STREIDT" HANYSZOR="1"/>
    <VERSENYZO NEV="Ellen VAN LANGEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ellery CLARK" HANYSZOR="2"/>
    <VERSENYZO NEV="Ellina ZVEREVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Elvan ABEYLEGESSE" HANYSZOR="2"/>
    <VERSENYZO NEV="Elvira OZOLINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Elzbieta KRZESINSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Emerson NORTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Emiel PUTTEMANS" HANYSZOR="1"/>
    <VERSENYZO NEV="Emil BREITKREUTZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Emil ZÃ&#x81;TOPEK" HANYSZOR="5"/>
    <VERSENYZO NEV="Emilio LUNGHI" HANYSZOR="1"/>
    <VERSENYZO NEV="Emma COBURN" HANYSZOR="1"/>
    <VERSENYZO NEV="Emmanuel McDONALD BAILEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Enrique FIGUEROLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Eric BACKMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Eric LEMMING" HANYSZOR="2"/>
    <VERSENYZO NEV="Eric LIDDELL" HANYSZOR="2"/>
    <VERSENYZO NEV="Eric SVENSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Erick BARRONDO" HANYSZOR="1"/>
    <VERSENYZO NEV="Erick WAINAINA" HANYSZOR="2"/>
    <VERSENYZO NEV="Erik ALMLÃ&#x96;F" HANYSZOR="1"/>
    <VERSENYZO NEV="Erik BYLÃ&#x89;HN" HANYSZOR="1"/>
    <VERSENYZO NEV="Erik KYNARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Erki NOOL" HANYSZOR="1"/>
    <VERSENYZO NEV="Erkka WILEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ernest HARPER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ernesto AMBROSINI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ernesto CANTO" HANYSZOR="1"/>
    <VERSENYZO NEV="Ernst FAST" HANYSZOR="1"/>
    <VERSENYZO NEV="Ernst LARSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ernst SCHULTZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Ervin HALL" HANYSZOR="1"/>
    <VERSENYZO NEV="Esfira DOLCHENKO-KRACHEVSKAYA" HANYSZOR="1"/>
    <VERSENYZO NEV="Eshetu TURA" HANYSZOR="1"/>
    <VERSENYZO NEV="Esref APAK" HANYSZOR="1"/>
    <VERSENYZO NEV="Esther BRAND" HANYSZOR="1"/>
    <VERSENYZO NEV="Ethel SMITH" HANYSZOR="1"/>
    <VERSENYZO NEV="Etienne GAILLY" HANYSZOR="1"/>
    <VERSENYZO NEV="Eugene OBERST" HANYSZOR="1"/>
    <VERSENYZO NEV="Eunice JEPKORIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Eunice Jepkirui KIRWA" HANYSZOR="1"/>
    <VERSENYZO NEV="Eva DAWES" HANYSZOR="1"/>
    <VERSENYZO NEV="Eva JANKO-EGGER" HANYSZOR="1"/>
    <VERSENYZO NEV="Evan JAGER" HANYSZOR="1"/>
    <VERSENYZO NEV="Evangelos DAMASKOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Evelin SCHLAAK-JAHL" HANYSZOR="1"/>
    <VERSENYZO NEV="Evelyn ASHFORD" HANYSZOR="1"/>
    <VERSENYZO NEV="Evgeniy LUKYANENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Ewa KLOBUKOWSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ezekiel KEMBOI" HANYSZOR="2"/>
    <VERSENYZO NEV="Fabrizio DONATO" HANYSZOR="1"/>
    <VERSENYZO NEV="Faina MELNIK" HANYSZOR="1"/>
    <VERSENYZO NEV="Faith Chepngetich KIPYEGON" HANYSZOR="1"/>
    <VERSENYZO NEV="Falilat OGUNKOYA" HANYSZOR="1"/>
    <VERSENYZO NEV="Fani KHALKIA" HANYSZOR="1"/>
    <VERSENYZO NEV="Fanny BLANKERS-KOEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Fanny ROSENFELD" HANYSZOR="1"/>
    <VERSENYZO NEV="Fatuma ROBA" HANYSZOR="1"/>
    <VERSENYZO NEV="Felix SANCHEZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Fermin CACHO RUIZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Fernanda RIBEIRO" HANYSZOR="2"/>
    <VERSENYZO NEV="Feyisa LILESA" HANYSZOR="1"/>
    <VERSENYZO NEV="Filbert BAYI" HANYSZOR="1"/>
    <VERSENYZO NEV="Fiona MAY" HANYSZOR="2"/>
    <VERSENYZO NEV="Fita BAYISSA" HANYSZOR="1"/>
    <VERSENYZO NEV="Fita LOVIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Florence GRIFFITH JOYNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Florenta CRACIUNESCU" HANYSZOR="1"/>
    <VERSENYZO NEV="Florian SCHWARTHOFF" HANYSZOR="1"/>
    <VERSENYZO NEV="Floyd SIMMONS" HANYSZOR="2"/>
    <VERSENYZO NEV="Forrest SMITHSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Forrest TOWNS" HANYSZOR="1"/>
    <VERSENYZO NEV="Francine NIYONSABA" HANYSZOR="1"/>
    <VERSENYZO NEV="Francis LANE" HANYSZOR="1"/>
    <VERSENYZO NEV="Francis OBIKWELU" HANYSZOR="1"/>
    <VERSENYZO NEV="Francisco Javier FERNANDEZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Francoise MBANGO ETONE" HANYSZOR="2"/>
    <VERSENYZO NEV="Franjo MIHALIC" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank BAUMGARTL" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank BUSEMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank CUHEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank Charles SHORTER" HANYSZOR="2"/>
    <VERSENYZO NEV="Frank FREDERICKS" HANYSZOR="4"/>
    <VERSENYZO NEV="Frank IRONS" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank JARVIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank LOOMIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank MURPHY" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank NELSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank PASCHEK" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank RUTHERFORD" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank SCHAFFER" HANYSZOR="1"/>
    <VERSENYZO NEV="Frank WALLER" HANYSZOR="2"/>
    <VERSENYZO NEV="Frank WARTENBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Franti?ek DOUDA" HANYSZOR="1"/>
    <VERSENYZO NEV="Frantz KRUGER" HANYSZOR="1"/>
    <VERSENYZO NEV="Fred ENGELHARDT" HANYSZOR="1"/>
    <VERSENYZO NEV="Fred HANSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Fred ONYANCHA" HANYSZOR="1"/>
    <VERSENYZO NEV="Fred TOOTELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Frederick KELLY" HANYSZOR="1"/>
    <VERSENYZO NEV="Frederick MOLONEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Frederick MURRAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Frederick SCHULE" HANYSZOR="1"/>
    <VERSENYZO NEV="Frederick Vaughn NEWHOUSE" HANYSZOR="1"/>
    <VERSENYZO NEV="Fritz Erik ELMSÃ&#x83;?TER" HANYSZOR="1"/>
    <VERSENYZO NEV="Fritz HOFMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Fritz POLLARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Gabriel TIACOH" HANYSZOR="1"/>
    <VERSENYZO NEV="Gabriela SZABO" HANYSZOR="3"/>
    <VERSENYZO NEV="Gabriella DORIO" HANYSZOR="1"/>
    <VERSENYZO NEV="Gael MARTIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Gail DEVERS" HANYSZOR="2"/>
    <VERSENYZO NEV="Galen RUPP" HANYSZOR="2"/>
    <VERSENYZO NEV="Galina ASTAFEI" HANYSZOR="1"/>
    <VERSENYZO NEV="Galina ZYBINA" HANYSZOR="2"/>
    <VERSENYZO NEV="Gamze BULUT" HANYSZOR="1"/>
    <VERSENYZO NEV="Garfield MACDONALD" HANYSZOR="1"/>
    <VERSENYZO NEV="Garrett SERVISS" HANYSZOR="1"/>
    <VERSENYZO NEV="Gary OAKES" HANYSZOR="1"/>
    <VERSENYZO NEV="Gaston GODEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Gaston REIFF" HANYSZOR="1"/>
    <VERSENYZO NEV="Gaston ROELANTS" HANYSZOR="1"/>
    <VERSENYZO NEV="Gaston STROBINO" HANYSZOR="1"/>
    <VERSENYZO NEV="Gelindo BORDIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Genzebe DIBABA" HANYSZOR="1"/>
    <VERSENYZO NEV="Georg ABERG" HANYSZOR="2"/>
    <VERSENYZO NEV="Georg LAMMERS" HANYSZOR="1"/>
    <VERSENYZO NEV="George HORINE" HANYSZOR="1"/>
    <VERSENYZO NEV="George HUTSON" HANYSZOR="1"/>
    <VERSENYZO NEV="George JEFFERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="George KERR" HANYSZOR="1"/>
    <VERSENYZO NEV="George ORTON" HANYSZOR="2"/>
    <VERSENYZO NEV="George POAGE" HANYSZOR="1"/>
    <VERSENYZO NEV="George RHODEN" HANYSZOR="1"/>
    <VERSENYZO NEV="George SALING" HANYSZOR="1"/>
    <VERSENYZO NEV="George SIMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="George YOUNG" HANYSZOR="1"/>
    <VERSENYZO NEV="Georges ANDRE" HANYSZOR="1"/>
    <VERSENYZO NEV="Georgios PAPASIDERIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Gerard NIJBOER" HANYSZOR="1"/>
    <VERSENYZO NEV="Gerd KANTER" HANYSZOR="2"/>
    <VERSENYZO NEV="Gerd WESSIG" HANYSZOR="1"/>
    <VERSENYZO NEV="Gergely KULCSÃ&#x81;R" HANYSZOR="2"/>
    <VERSENYZO NEV="Gerhard HENNIGE" HANYSZOR="1"/>
    <VERSENYZO NEV="Gerhard STÃ&#x96;CK" HANYSZOR="1"/>
    <VERSENYZO NEV="Germaine MASON" HANYSZOR="1"/>
    <VERSENYZO NEV="Gete WAMI" HANYSZOR="3"/>
    <VERSENYZO NEV="Gezahegne ABERA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ghada SHOUAA" HANYSZOR="1"/>
    <VERSENYZO NEV="Gheorghe MEGELEA" HANYSZOR="1"/>
    <VERSENYZO NEV="Giovanni DE BENEDICTIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Gisela MAUERMAYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Giuseppe DORDONI" HANYSZOR="1"/>
    <VERSENYZO NEV="Giuseppe GIBILISCO" HANYSZOR="1"/>
    <VERSENYZO NEV="Giuseppina LEONE" HANYSZOR="1"/>
    <VERSENYZO NEV="Glenn CUNNINGHAM" HANYSZOR="1"/>
    <VERSENYZO NEV="Glenn DAVIS" HANYSZOR="2"/>
    <VERSENYZO NEV="Glenn GRAHAM" HANYSZOR="1"/>
    <VERSENYZO NEV="Glenn HARDIN" HANYSZOR="2"/>
    <VERSENYZO NEV="Glenn HARTRANFT" HANYSZOR="1"/>
    <VERSENYZO NEV="Glenn MORRIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Gloria ALOZIE" HANYSZOR="1"/>
    <VERSENYZO NEV="Glynis NUNN" HANYSZOR="1"/>
    <VERSENYZO NEV="Godfrey BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Godfrey Khotso MOKOENA" HANYSZOR="1"/>
    <VERSENYZO NEV="Gordon PIRIE" HANYSZOR="1"/>
    <VERSENYZO NEV="Gote Ernst HAGSTROM" HANYSZOR="1"/>
    <VERSENYZO NEV="Grantley GOULDING" HANYSZOR="1"/>
    <VERSENYZO NEV="Greg FOSTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Greg HAUGHTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Greg JOY" HANYSZOR="1"/>
    <VERSENYZO NEV="Greg RUTHERFORD" HANYSZOR="2"/>
    <VERSENYZO NEV="Grete ANDERSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Guido KRATSCHMER" HANYSZOR="1"/>
    <VERSENYZO NEV="Guillaume LEBLANC" HANYSZOR="1"/>
    <VERSENYZO NEV="Gulnara SAMITOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Gunhild HOFFMEISTER" HANYSZOR="3"/>
    <VERSENYZO NEV="Gunnar HÃ&#x96;CKERT" HANYSZOR="1"/>
    <VERSENYZO NEV="Gunnar LINDSTRÃ&#x96;M" HANYSZOR="1"/>
    <VERSENYZO NEV="Gustaf JANSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Gustav LINDBLOM" HANYSZOR="1"/>
    <VERSENYZO NEV="Guy BUTLER" HANYSZOR="2"/>
    <VERSENYZO NEV="Guy DRUT" HANYSZOR="2"/>
    <VERSENYZO NEV="Gwen TORRENCE" HANYSZOR="2"/>
    <VERSENYZO NEV="Gyula KELLNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Gyula ZSIVÃ&#x93;TZKY" HANYSZOR="2"/>
    <VERSENYZO NEV="GÃ¶sta HOLMER" HANYSZOR="1"/>
    <VERSENYZO NEV="Habiba GHRIBI" HANYSZOR="1"/>
    <VERSENYZO NEV="Hadi Soua An AL SOMAILY" HANYSZOR="1"/>
    <VERSENYZO NEV="Hagos GEBRHIWET" HANYSZOR="1"/>
    <VERSENYZO NEV="Haile GEBRSELASSIE" HANYSZOR="2"/>
    <VERSENYZO NEV="Halina KONOPACKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Hannes KOLEHMAINEN" HANYSZOR="3"/>
    <VERSENYZO NEV="Hanns BRAUN" HANYSZOR="2"/>
    <VERSENYZO NEV="Hannu Juhani SIITONEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Hans GRODOTZKI" HANYSZOR="2"/>
    <VERSENYZO NEV="Hans LIESCHE" HANYSZOR="1"/>
    <VERSENYZO NEV="Hans REIMANN" HANYSZOR="2"/>
    <VERSENYZO NEV="Hans WOELLKE" HANYSZOR="1"/>
    <VERSENYZO NEV="Hans-Joachim WALDE" HANYSZOR="2"/>
    <VERSENYZO NEV="Hansle PARCHMENT" HANYSZOR="1"/>
    <VERSENYZO NEV="Harald NORPOTH" HANYSZOR="1"/>
    <VERSENYZO NEV="Harald SCHMID" HANYSZOR="1"/>
    <VERSENYZO NEV="Harlow ROTHERT" HANYSZOR="1"/>
    <VERSENYZO NEV="Harold ABRAHAMS" HANYSZOR="1"/>
    <VERSENYZO NEV="Harold BARRON" HANYSZOR="1"/>
    <VERSENYZO NEV="Harold OSBORN" HANYSZOR="2"/>
    <VERSENYZO NEV="Harold WHITLOCK" HANYSZOR="1"/>
    <VERSENYZO NEV="Harold WILSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Harri LARVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Harrison DILLARD" HANYSZOR="2"/>
    <VERSENYZO NEV="Harry EDWARD" HANYSZOR="2"/>
    <VERSENYZO NEV="Harry HILLMAN" HANYSZOR="3"/>
    <VERSENYZO NEV="Harry JEROME" HANYSZOR="1"/>
    <VERSENYZO NEV="Harry PORTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Harry Stoddard BABCOCK" HANYSZOR="1"/>
    <VERSENYZO NEV="Hartwig GAUDER" HANYSZOR="2"/>
    <VERSENYZO NEV="Hasely CRAWFORD" HANYSZOR="1"/>
    <VERSENYZO NEV="Hasna BENHASSI" HANYSZOR="2"/>
    <VERSENYZO NEV="Hassiba BOULMERKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Hayes JONES" HANYSZOR="2"/>
    <VERSENYZO NEV="Hector HOGAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Heike DRECHSLER" HANYSZOR="2"/>
    <VERSENYZO NEV="Heike HENKEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Heinz ULZHEIMER" HANYSZOR="1"/>
    <VERSENYZO NEV="Helen STEPHENS" HANYSZOR="1"/>
    <VERSENYZO NEV="Helena FIBINGEROVÃ&#x81;" HANYSZOR="1"/>
    <VERSENYZO NEV="Helge LÃ&#x96;VLAND" HANYSZOR="1"/>
    <VERSENYZO NEV="Heli RANTANEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Hellen Onsando OBIRI" HANYSZOR="1"/>
    <VERSENYZO NEV="Helmut KÃ&#x96;RNIG" HANYSZOR="1"/>
    <VERSENYZO NEV="Henri DELOGE" HANYSZOR="1"/>
    <VERSENYZO NEV="Henri LABORDE" HANYSZOR="1"/>
    <VERSENYZO NEV="Henri TAUZIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Henry CARR" HANYSZOR="1"/>
    <VERSENYZO NEV="Henry ERIKSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Henry JONSSON-KÃ&#x84;LARNE" HANYSZOR="1"/>
    <VERSENYZO NEV="Henry STALLARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Herb ELLIOTT" HANYSZOR="1"/>
    <VERSENYZO NEV="Herbert JAMISON" HANYSZOR="1"/>
    <VERSENYZO NEV="Herbert MCKENLEY" HANYSZOR="3"/>
    <VERSENYZO NEV="Herbert SCHADE" HANYSZOR="1"/>
    <VERSENYZO NEV="Herma BAUMA" HANYSZOR="1"/>
    <VERSENYZO NEV="Herman GROMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Herman Ronald FRAZIER" HANYSZOR="1"/>
    <VERSENYZO NEV="Hermann ENGELHARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Hestrie CLOETE" HANYSZOR="2"/>
    <VERSENYZO NEV="Hezekiel SEPENG" HANYSZOR="1"/>
    <VERSENYZO NEV="Hicham EL GUERROUJ" HANYSZOR="3"/>
    <VERSENYZO NEV="Hilda STRIKE" HANYSZOR="1"/>
    <VERSENYZO NEV="Hildegard FALCK" HANYSZOR="1"/>
    <VERSENYZO NEV="Hildrun CLAUS" HANYSZOR="1"/>
    <VERSENYZO NEV="Hirooki ARAI" HANYSZOR="1"/>
    <VERSENYZO NEV="Hollis CONWAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Hong LIU" HANYSZOR="1"/>
    <VERSENYZO NEV="Horace ASHENFELTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Horatio FITCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Howard VALENTINE" HANYSZOR="1"/>
    <VERSENYZO NEV="Hrysopiyi DEVETZI" HANYSZOR="1"/>
    <VERSENYZO NEV="Hugo WIESLANDER" HANYSZOR="1"/>
    <VERSENYZO NEV="Huina XING" HANYSZOR="1"/>
    <VERSENYZO NEV="Hussein AHMED SALAH" HANYSZOR="1"/>
    <VERSENYZO NEV="Hyleas FOUNTAIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Hyvin Kiyeng JEPKEMOI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ian STEWART" HANYSZOR="1"/>
    <VERSENYZO NEV="Ibolya CSÃ&#x81;K" HANYSZOR="1"/>
    <VERSENYZO NEV="Ibrahim CAMEJO" HANYSZOR="1"/>
    <VERSENYZO NEV="Ignace HEINRICH" HANYSZOR="1"/>
    <VERSENYZO NEV="Igor ASTAPKOVICH" HANYSZOR="2"/>
    <VERSENYZO NEV="Igor NIKULIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Igor TER-OVANESYAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Igor TRANDENKOV" HANYSZOR="2"/>
    <VERSENYZO NEV="Ileana SILAI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ilke WYLUDDA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ilmari SALMINEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ilona SCHOKNECHT-SLUPIANEK" HANYSZOR="1"/>
    <VERSENYZO NEV="Ilya MARKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Imre NÃ&#x89;METH" HANYSZOR="1"/>
    <VERSENYZO NEV="Imrich BUGÃ&#x81;R" HANYSZOR="1"/>
    <VERSENYZO NEV="Inessa KRAVETS" HANYSZOR="2"/>
    <VERSENYZO NEV="Inga GENTZEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Inge HELTEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ingrid AUERSWALD-LANGE" HANYSZOR="1"/>
    <VERSENYZO NEV="Ingrid LOTZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Ingvar PETTERSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Inha BABAKOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Inna LASOVSKAYA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ioannis PERSAKIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Ioannis THEODOROPOULOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Iolanda BALAS" HANYSZOR="2"/>
    <VERSENYZO NEV="Ionela TIRLEA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ira DAVENPORT" HANYSZOR="1"/>
    <VERSENYZO NEV="Irena KIRSZENSTEIN" HANYSZOR="6"/>
    <VERSENYZO NEV="Irina BELOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Irina KHUDOROZHKINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Irina PRIVALOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Irina SIMAGINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Irvin ROBERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Irving BAXTER" HANYSZOR="2"/>
    <VERSENYZO NEV="Irving SALADINO" HANYSZOR="1"/>
    <VERSENYZO NEV="Iryna LISHCHYNSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Iryna YATCHENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Isabella OCHICHI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ismail Ahmed ISMAIL" HANYSZOR="1"/>
    <VERSENYZO NEV="IstvÃ¡n RÃ&#x93;ZSAVÃ&#x96;LGYI" HANYSZOR="1"/>
    <VERSENYZO NEV="IstvÃ¡n SOMODI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivan BELYAEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivan PEDROSO" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivan RILEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivan TSIKHAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Ivan UKHOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivana SPANOVIC" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivanka KHRISTOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Ivano BRUGNETTI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ivo VAN DAMME" HANYSZOR="2"/>
    <VERSENYZO NEV="Jaak UUDMÃ&#x84;E" HANYSZOR="1"/>
    <VERSENYZO NEV="Jacek WSZOLA" HANYSZOR="2"/>
    <VERSENYZO NEV="Jack DAVIS" HANYSZOR="2"/>
    <VERSENYZO NEV="Jack LONDON" HANYSZOR="1"/>
    <VERSENYZO NEV="Jack PARKER" HANYSZOR="1"/>
    <VERSENYZO NEV="Jack PIERCE" HANYSZOR="1"/>
    <VERSENYZO NEV="Jackie JOYNER" HANYSZOR="5"/>
    <VERSENYZO NEV="Jackson SCHOLZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Jacqueline MAZEAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Jacqueline TODTEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Jadwiga WAJS" HANYSZOR="2"/>
    <VERSENYZO NEV="Jai TAURIMA" HANYSZOR="1"/>
    <VERSENYZO NEV="James BALL" HANYSZOR="1"/>
    <VERSENYZO NEV="James BECKFORD" HANYSZOR="1"/>
    <VERSENYZO NEV="James BROOKER" HANYSZOR="1"/>
    <VERSENYZO NEV="James CONNOLLY" HANYSZOR="4"/>
    <VERSENYZO NEV="James DILLION" HANYSZOR="1"/>
    <VERSENYZO NEV="James DUNCAN" HANYSZOR="1"/>
    <VERSENYZO NEV="James Edwin MEREDITH" HANYSZOR="1"/>
    <VERSENYZO NEV="James Ellis LU VALLE" HANYSZOR="1"/>
    <VERSENYZO NEV="James FUCHS" HANYSZOR="1"/>
    <VERSENYZO NEV="James GATHERS" HANYSZOR="1"/>
    <VERSENYZO NEV="James LIGHTBODY" HANYSZOR="3"/>
    <VERSENYZO NEV="James WENDELL" HANYSZOR="1"/>
    <VERSENYZO NEV="James WILSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Jan Å½ELEZNÃ&#x9d;" HANYSZOR="3"/>
    <VERSENYZO NEV="Janay DELOACH" HANYSZOR="1"/>
    <VERSENYZO NEV="Jane SAVILLE" HANYSZOR="1"/>
    <VERSENYZO NEV="Janeene VICKERS" HANYSZOR="1"/>
    <VERSENYZO NEV="Janeth Jepkosgei BUSIENEI" HANYSZOR="1"/>
    <VERSENYZO NEV="Janis DALINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Janusz KUSOCINSKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Jaouad GHARIB" HANYSZOR="1"/>
    <VERSENYZO NEV="Jared TALLENT" HANYSZOR="4"/>
    <VERSENYZO NEV="Jarmila KRATOHVILOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Jaroslav BABA" HANYSZOR="1"/>
    <VERSENYZO NEV="Jaroslawa JÃ&#x93;ZWIAKOWSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Jason RICHARDSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Javier CULSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Javier GARCÃ&#x8d;A" HANYSZOR="1"/>
    <VERSENYZO NEV="Javier SOTOMAYOR" HANYSZOR="2"/>
    <VERSENYZO NEV="Jean BOUIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Jean CHASTANIE" HANYSZOR="1"/>
    <VERSENYZO NEV="Jean GALFIONE" HANYSZOR="1"/>
    <VERSENYZO NEV="Jean SHILEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Jeff HENDERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Jefferson PEREZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Jemima Jelagat SUMGONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Jennifer LAMY" HANYSZOR="1"/>
    <VERSENYZO NEV="Jennifer SIMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Jennifer SUHR" HANYSZOR="2"/>
    <VERSENYZO NEV="Jeremy WARINER" HANYSZOR="2"/>
    <VERSENYZO NEV="Jerome BIFFLE" HANYSZOR="1"/>
    <VERSENYZO NEV="Jesse OWENS" HANYSZOR="3"/>
    <VERSENYZO NEV="Jessica ENNIS HILL" HANYSZOR="2"/>
    <VERSENYZO NEV="Jim BAUSCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Jim DOEHRING" HANYSZOR="1"/>
    <VERSENYZO NEV="Jim HINES" HANYSZOR="1"/>
    <VERSENYZO NEV="Jim RYUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Jim THORPE" HANYSZOR="1"/>
    <VERSENYZO NEV="Joachim Broechner OLSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Joachim BÃ&#x9c;CHNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Joan BENOIT" HANYSZOR="1"/>
    <VERSENYZO NEV="Joan Lino MARTINEZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Joanet QUINTERO" HANYSZOR="1"/>
    <VERSENYZO NEV="Joanna HAYES" HANYSZOR="1"/>
    <VERSENYZO NEV="Joaquim CRUZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Joe GREENE" HANYSZOR="2"/>
    <VERSENYZO NEV="Joe KOVACS" HANYSZOR="1"/>
    <VERSENYZO NEV="Joel SANCHEZ GUERRERO" HANYSZOR="1"/>
    <VERSENYZO NEV="Joel SHANKLE" HANYSZOR="1"/>
    <VERSENYZO NEV="Johanna LÃ&#x9c;TTGE" HANYSZOR="1"/>
    <VERSENYZO NEV="Johanna SCHALLER-KLIER" HANYSZOR="2"/>
    <VERSENYZO NEV="John AKII-BUA" HANYSZOR="1"/>
    <VERSENYZO NEV="John ANDERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="John BRAY" HANYSZOR="1"/>
    <VERSENYZO NEV="John CARLOS" HANYSZOR="1"/>
    <VERSENYZO NEV="John COLLIER" HANYSZOR="1"/>
    <VERSENYZO NEV="John COOPER" HANYSZOR="1"/>
    <VERSENYZO NEV="John CORNES" HANYSZOR="1"/>
    <VERSENYZO NEV="John CREGAN" HANYSZOR="1"/>
    <VERSENYZO NEV="John DALY" HANYSZOR="1"/>
    <VERSENYZO NEV="John DAVIES" HANYSZOR="1"/>
    <VERSENYZO NEV="John DEWITT" HANYSZOR="1"/>
    <VERSENYZO NEV="John DISLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="John FLANAGAN" HANYSZOR="3"/>
    <VERSENYZO NEV="John GARRELLS" HANYSZOR="2"/>
    <VERSENYZO NEV="John GODINA" HANYSZOR="2"/>
    <VERSENYZO NEV="John George WALKER" HANYSZOR="1"/>
    <VERSENYZO NEV="John HAYES" HANYSZOR="1"/>
    <VERSENYZO NEV="John Kenneth DOHERTY" HANYSZOR="1"/>
    <VERSENYZO NEV="John LANDY" HANYSZOR="1"/>
    <VERSENYZO NEV="John LJUNGGREN" HANYSZOR="3"/>
    <VERSENYZO NEV="John LOARING" HANYSZOR="1"/>
    <VERSENYZO NEV="John LOVELOCK" HANYSZOR="1"/>
    <VERSENYZO NEV="John MCLEAN" HANYSZOR="1"/>
    <VERSENYZO NEV="John MOFFITT" HANYSZOR="1"/>
    <VERSENYZO NEV="John Macfarlane HOLLAND" HANYSZOR="1"/>
    <VERSENYZO NEV="John NORTON" HANYSZOR="1"/>
    <VERSENYZO NEV="John POWELL" HANYSZOR="2"/>
    <VERSENYZO NEV="John RAMBO" HANYSZOR="1"/>
    <VERSENYZO NEV="John RECTOR" HANYSZOR="1"/>
    <VERSENYZO NEV="John SHERWOOD" HANYSZOR="1"/>
    <VERSENYZO NEV="John THOMAS" HANYSZOR="2"/>
    <VERSENYZO NEV="John TREACY" HANYSZOR="1"/>
    <VERSENYZO NEV="John WOODRUFF" HANYSZOR="1"/>
    <VERSENYZO NEV="Johnny GRAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Jolan KLEIBER-KONTSEK" HANYSZOR="1"/>
    <VERSENYZO NEV="Jolanda CEPLAK" HANYSZOR="1"/>
    <VERSENYZO NEV="Jonathan EDWARDS" HANYSZOR="2"/>
    <VERSENYZO NEV="Jonni MYYRÃ&#x84;" HANYSZOR="1"/>
    <VERSENYZO NEV="Jorge LLOPART" HANYSZOR="1"/>
    <VERSENYZO NEV="Jose TELLES DA CONCEICAO" HANYSZOR="1"/>
    <VERSENYZO NEV="Josef DOLEZAL" HANYSZOR="1"/>
    <VERSENYZO NEV="Josef ODLOZIL" HANYSZOR="1"/>
    <VERSENYZO NEV="Joseph BARTHEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Joseph FORSHAW" HANYSZOR="1"/>
    <VERSENYZO NEV="Joseph GUILLEMOT" HANYSZOR="2"/>
    <VERSENYZO NEV="Joseph KETER" HANYSZOR="1"/>
    <VERSENYZO NEV="Joseph MAHMOUD" HANYSZOR="1"/>
    <VERSENYZO NEV="Joseph MCCLUSKEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Josh CULBREATH" HANYSZOR="1"/>
    <VERSENYZO NEV="Josia THUGWANE" HANYSZOR="1"/>
    <VERSENYZO NEV="Josiah MCCRACKEN" HANYSZOR="2"/>
    <VERSENYZO NEV="JosÃ© Manuel ABASCAL" HANYSZOR="1"/>
    <VERSENYZO NEV="JosÃ© PEDRAZA" HANYSZOR="1"/>
    <VERSENYZO NEV="Joyce CHEPCHUMBA" HANYSZOR="1"/>
    <VERSENYZO NEV="Jozef PRIBILINEC" HANYSZOR="1"/>
    <VERSENYZO NEV="Jozef SCHMIDT" HANYSZOR="2"/>
    <VERSENYZO NEV="JoÃ£o Carlos DE OLIVEIRA" HANYSZOR="1"/>
    <VERSENYZO NEV="Juan Carlos ZABALA" HANYSZOR="1"/>
    <VERSENYZO NEV="Judi BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Judith Florence AMOORE-POLLOCK" HANYSZOR="1"/>
    <VERSENYZO NEV="Juho Julius SAARISTO" HANYSZOR="1"/>
    <VERSENYZO NEV="Jules LADOUMEGUE" HANYSZOR="1"/>
    <VERSENYZO NEV="Juliet CUTHBERT" HANYSZOR="2"/>
    <VERSENYZO NEV="Julius KORIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Julius SANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Julius YEGO" HANYSZOR="1"/>
    <VERSENYZO NEV="Junxia WANG" HANYSZOR="2"/>
    <VERSENYZO NEV="Justin GATLIN" HANYSZOR="4"/>
    <VERSENYZO NEV="Jutta HEINE" HANYSZOR="1"/>
    <VERSENYZO NEV="Jutta KIRST" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ³zsef CSERMÃ&#x81;K" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ³zsef KOVÃ&#x81;CS" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ¶rg FREIMUTH" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ¼rgen HINGSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ¼rgen SCHULT" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ¼rgen STRAUB" HANYSZOR="1"/>
    <VERSENYZO NEV="JÃ¼ri LOSSMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Kaarlo Jalmari TUOMINEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Kaarlo MAANINKA" HANYSZOR="2"/>
    <VERSENYZO NEV="Kaisa PARVIAINEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Kajsa BERGQVIST" HANYSZOR="1"/>
    <VERSENYZO NEV="Kamila SKOLIMOWSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Karel LISMONT" HANYSZOR="2"/>
    <VERSENYZO NEV="Karen FORKEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Karin RICHERT-BALZER" HANYSZOR="1"/>
    <VERSENYZO NEV="Karl STORCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Karl-Friedrich HAAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Karoline &#34;Lina&#34; RADKE" HANYSZOR="1"/>
    <VERSENYZO NEV="Katharine MERRY" HANYSZOR="1"/>
    <VERSENYZO NEV="Kathleen HAMMOND" HANYSZOR="1"/>
    <VERSENYZO NEV="Kathrin NEIMKE" HANYSZOR="1"/>
    <VERSENYZO NEV="Kathryn Joan SCHMIDT" HANYSZOR="2"/>
    <VERSENYZO NEV="Kathryn SMALLWOOD-COOK" HANYSZOR="1"/>
    <VERSENYZO NEV="Katrin DÃ&#x96;RRE" HANYSZOR="1"/>
    <VERSENYZO NEV="Kazimierz ZIMNY" HANYSZOR="1"/>
    <VERSENYZO NEV="Kellie WELLS" HANYSZOR="1"/>
    <VERSENYZO NEV="Kelly HOLMES" HANYSZOR="3"/>
    <VERSENYZO NEV="Kelly SOTHERTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Kenenisa BEKELE" HANYSZOR="4"/>
    <VERSENYZO NEV="Kenji KIMIHARA" HANYSZOR="1"/>
    <VERSENYZO NEV="Kenkichi OSHIMA" HANYSZOR="1"/>
    <VERSENYZO NEV="Kennedy Kane MCARTHUR" HANYSZOR="1"/>
    <VERSENYZO NEV="Kenneth Joseph MATTHEWS" HANYSZOR="1"/>
    <VERSENYZO NEV="Kenneth WIESNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Kenny HARRISON" HANYSZOR="1"/>
    <VERSENYZO NEV="Kenth ELDEBRINK" HANYSZOR="1"/>
    <VERSENYZO NEV="Kerron CLEMENT" HANYSZOR="2"/>
    <VERSENYZO NEV="Kerron STEWART" HANYSZOR="2"/>
    <VERSENYZO NEV="Keshorn WALCOTT" HANYSZOR="2"/>
    <VERSENYZO NEV="Kevin MAYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Kevin YOUNG" HANYSZOR="1"/>
    <VERSENYZO NEV="Khalid BOULAMI" HANYSZOR="1"/>
    <VERSENYZO NEV="Khalid SKAH" HANYSZOR="1"/>
    <VERSENYZO NEV="Kharilaos VASILAKOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Kim BATTEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Kim GALLAGHER" HANYSZOR="1"/>
    <VERSENYZO NEV="Kim TURNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Kinue HITOMI" HANYSZOR="1"/>
    <VERSENYZO NEV="Kip KEINO" HANYSZOR="4"/>
    <VERSENYZO NEV="Kirani JAMES" HANYSZOR="2"/>
    <VERSENYZO NEV="Kirk BAPTISTE" HANYSZOR="1"/>
    <VERSENYZO NEV="Kirsten MÃ&#x9c;NCHOW" HANYSZOR="1"/>
    <VERSENYZO NEV="Kitei SON" HANYSZOR="1"/>
    <VERSENYZO NEV="Kjersti PLAETZER" HANYSZOR="2"/>
    <VERSENYZO NEV="Klaus LEHNERTZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Klaus RICHTZENHAIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Klaus-Peter HILDENBRAND" HANYSZOR="1"/>
    <VERSENYZO NEV="Klavdiya TOCHENOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Koichi MORISHITA" HANYSZOR="1"/>
    <VERSENYZO NEV="Koji MUROFUSHI" HANYSZOR="2"/>
    <VERSENYZO NEV="Kokichi TSUBURAYA" HANYSZOR="1"/>
    <VERSENYZO NEV="Konstantin VOLKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Kostas KENTERIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Kriss AKABUSI" HANYSZOR="1"/>
    <VERSENYZO NEV="Kristi CASTLIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Krisztian PARS" HANYSZOR="1"/>
    <VERSENYZO NEV="Kurt BENDLIN" HANYSZOR="1"/>
    <VERSENYZO NEV="KÃ¤the KRAUSS" HANYSZOR="1"/>
    <VERSENYZO NEV="LaVonna MARTIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Lacey HEARN" HANYSZOR="1"/>
    <VERSENYZO NEV="Lajos GÃ&#x96;NCZY" HANYSZOR="1"/>
    <VERSENYZO NEV="Lalonde GORDON" HANYSZOR="1"/>
    <VERSENYZO NEV="Lambert REDD" HANYSZOR="1"/>
    <VERSENYZO NEV="Lance Earl DEAL" HANYSZOR="1"/>
    <VERSENYZO NEV="Larisa PELESHENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Larry BLACK" HANYSZOR="1"/>
    <VERSENYZO NEV="Larry JAMES" HANYSZOR="1"/>
    <VERSENYZO NEV="Larry YOUNG" HANYSZOR="2"/>
    <VERSENYZO NEV="Lars RIEDEL" HANYSZOR="2"/>
    <VERSENYZO NEV="Lashawn MERRITT" HANYSZOR="2"/>
    <VERSENYZO NEV="Lashinda DEMUS" HANYSZOR="1"/>
    <VERSENYZO NEV="Lasse VIREN" HANYSZOR="4"/>
    <VERSENYZO NEV="Lauri LEHTINEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Lauri VIRTANEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Lauryn WILLIAMS" HANYSZOR="1"/>
    <VERSENYZO NEV="Lawrence E. Joseph FEUERBACH" HANYSZOR="1"/>
    <VERSENYZO NEV="Lawrence JOHNSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Lawrence SHIELDS" HANYSZOR="1"/>
    <VERSENYZO NEV="Lawrence WHITNEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Lee BARNES" HANYSZOR="1"/>
    <VERSENYZO NEV="Lee CALHOUN" HANYSZOR="2"/>
    <VERSENYZO NEV="Lee EVANS" HANYSZOR="1"/>
    <VERSENYZO NEV="Leevan SANDS" HANYSZOR="1"/>
    <VERSENYZO NEV="Lennart STRAND" HANYSZOR="1"/>
    <VERSENYZO NEV="Lennox MILLER" HANYSZOR="2"/>
    <VERSENYZO NEV="Leo SEXTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Leonard Francis TREMEER" HANYSZOR="1"/>
    <VERSENYZO NEV="Leonel MANZANO" HANYSZOR="1"/>
    <VERSENYZO NEV="Leonel SUAREZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Leonid LITVINENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Leonid SHCHERBAKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Leonid SPIRIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Leroy BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Leroy SAMSE" HANYSZOR="1"/>
    <VERSENYZO NEV="Lesley ASHBURNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Leslie DENIZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Lester Nelson CARNEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Lewis SHELDON" HANYSZOR="1"/>
    <VERSENYZO NEV="Lewis TEWANIMA" HANYSZOR="1"/>
    <VERSENYZO NEV="Lia MANOLIU" HANYSZOR="3"/>
    <VERSENYZO NEV="Lidia ALFEEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Lidia SIMON" HANYSZOR="1"/>
    <VERSENYZO NEV="Liesel WESTERMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Lijiao GONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Liliya NURUTDINOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Lilli SCHWARZKOPF" HANYSZOR="1"/>
    <VERSENYZO NEV="Lillian BOARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Lillian COPELAND" HANYSZOR="2"/>
    <VERSENYZO NEV="Lily CARLSTEDT" HANYSZOR="1"/>
    <VERSENYZO NEV="Linda STAHL" HANYSZOR="1"/>
    <VERSENYZO NEV="Lindy REMIGINO" HANYSZOR="1"/>
    <VERSENYZO NEV="Linford CHRISTIE" HANYSZOR="1"/>
    <VERSENYZO NEV="Liping WANG" HANYSZOR="2"/>
    <VERSENYZO NEV="Lisa ONDIEKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Livio BERRUTI" HANYSZOR="1"/>
    <VERSENYZO NEV="Llewellyn HERBERT" HANYSZOR="1"/>
    <VERSENYZO NEV="Lloyd LABEACH" HANYSZOR="2"/>
    <VERSENYZO NEV="Lorraine FENTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Lorraine MOLLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Lothar MILDE" HANYSZOR="1"/>
    <VERSENYZO NEV="Louis WILKINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Louise MCPAUL" HANYSZOR="1"/>
    <VERSENYZO NEV="Lucyna LANGER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ludmila ENGQUIST" HANYSZOR="1"/>
    <VERSENYZO NEV="LudvÃ­k DANEK" HANYSZOR="2"/>
    <VERSENYZO NEV="Luguelin SANTOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Luigi BECCALI" HANYSZOR="2"/>
    <VERSENYZO NEV="Luis BRUNETTO" HANYSZOR="1"/>
    <VERSENYZO NEV="Luis DELIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Luise KRÃ&#x9c;GER" HANYSZOR="1"/>
    <VERSENYZO NEV="Lutz DOMBROWSKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Luvo MANYONGA" HANYSZOR="1"/>
    <VERSENYZO NEV="Luz LONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Lynn DAVIES" HANYSZOR="1"/>
    <VERSENYZO NEV="Lynn JENNINGS" HANYSZOR="1"/>
    <VERSENYZO NEV="Lyudmila BRAGINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Lyudmila KONDRATYEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Lyudmila ROGACHOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Lyudmila SHEVTSOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Mac WILKINS" HANYSZOR="2"/>
    <VERSENYZO NEV="Madeline MANNING-JACKSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Mahiedine MEKHISSI" HANYSZOR="1"/>
    <VERSENYZO NEV="Mahiedine MEKHISSI-BENABBAD" HANYSZOR="2"/>
    <VERSENYZO NEV="Maksim TARASOV" HANYSZOR="2"/>
    <VERSENYZO NEV="Mal WHITFIELD" HANYSZOR="3"/>
    <VERSENYZO NEV="Malcolm NOKES" HANYSZOR="1"/>
    <VERSENYZO NEV="Malcolm SPENCE" HANYSZOR="1"/>
    <VERSENYZO NEV="Mamo WOLDE" HANYSZOR="3"/>
    <VERSENYZO NEV="Manuel MARTINEZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Manuel PLAZA" HANYSZOR="1"/>
    <VERSENYZO NEV="Manuela MONTEBRUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Marc WRIGHT" HANYSZOR="1"/>
    <VERSENYZO NEV="Marcel HANSENNE" HANYSZOR="1"/>
    <VERSENYZO NEV="Mare DIBABA" HANYSZOR="1"/>
    <VERSENYZO NEV="Margaret Nyairera WAMBUI" HANYSZOR="1"/>
    <VERSENYZO NEV="Margitta DROESE-PUFE" HANYSZOR="1"/>
    <VERSENYZO NEV="Margitta HELMBOLD-GUMMEL" HANYSZOR="2"/>
    <VERSENYZO NEV="Maria CIONCAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Maria COLON" HANYSZOR="1"/>
    <VERSENYZO NEV="Maria GOMMERS" HANYSZOR="1"/>
    <VERSENYZO NEV="Maria Guadalupe GONZALEZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Maria KWASNIEWSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Maria MUTOLA" HANYSZOR="2"/>
    <VERSENYZO NEV="Maria VASCO" HANYSZOR="1"/>
    <VERSENYZO NEV="Maria VERGOVA-PETKOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Marian OPREA" HANYSZOR="1"/>
    <VERSENYZO NEV="Marianne WERNER" HANYSZOR="1"/>
    <VERSENYZO NEV="Maricica PUICA" HANYSZOR="1"/>
    <VERSENYZO NEV="Marie-JosÃ© PÃ&#x89;REC" HANYSZOR="3"/>
    <VERSENYZO NEV="Marilyn BLACK" HANYSZOR="1"/>
    <VERSENYZO NEV="Mario LANZI" HANYSZOR="1"/>
    <VERSENYZO NEV="Marion BECKER-STEINER" HANYSZOR="1"/>
    <VERSENYZO NEV="Marita KOCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Marita LANGE" HANYSZOR="1"/>
    <VERSENYZO NEV="Maritza MARTEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Mariya SAVINOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Marjorie JACKSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Mark CREAR" HANYSZOR="2"/>
    <VERSENYZO NEV="Mark MCKOY" HANYSZOR="1"/>
    <VERSENYZO NEV="Markus RYFFEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Marlene MATHEWS-WILLARD" HANYSZOR="2"/>
    <VERSENYZO NEV="Marlies OELSNER-GÃ&#x96;HR" HANYSZOR="1"/>
    <VERSENYZO NEV="Marquis Franklin HORR" HANYSZOR="1"/>
    <VERSENYZO NEV="Marta ANTAL-RUDAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Martin HAWKINS" HANYSZOR="1"/>
    <VERSENYZO NEV="Martin SHERIDAN" HANYSZOR="2"/>
    <VERSENYZO NEV="Martinus OSENDARP" HANYSZOR="2"/>
    <VERSENYZO NEV="Martti MARTTELIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Mary ONYALI" HANYSZOR="1"/>
    <VERSENYZO NEV="Mary RAND" HANYSZOR="1"/>
    <VERSENYZO NEV="Maryam Yusuf JAMAL" HANYSZOR="1"/>
    <VERSENYZO NEV="Maryvonne DUPUREUR" HANYSZOR="1"/>
    <VERSENYZO NEV="Matej TOTH" HANYSZOR="1"/>
    <VERSENYZO NEV="Matt HEMINGWAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Matt MCGRATH" HANYSZOR="3"/>
    <VERSENYZO NEV="Matthew BIRIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Matthew CENTROWITZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Matthew Mackenzie ROBINSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Matti JÃ&#x84;RVINEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Matti SIPPALA" HANYSZOR="1"/>
    <VERSENYZO NEV="Maurice GREENE" HANYSZOR="2"/>
    <VERSENYZO NEV="Maurice HERRIOTT" HANYSZOR="1"/>
    <VERSENYZO NEV="Maurizio DAMILANO" HANYSZOR="3"/>
    <VERSENYZO NEV="Maurren Higa MAGGI" HANYSZOR="1"/>
    <VERSENYZO NEV="Maxwell Warburn LONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Mbulaeni MULAUDZI" HANYSZOR="1"/>
    <VERSENYZO NEV="Mebrahtom KEFLEZIGHI" HANYSZOR="1"/>
    <VERSENYZO NEV="Medhi BAALA" HANYSZOR="1"/>
    <VERSENYZO NEV="Mel PATTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Melaine WALKER" HANYSZOR="1"/>
    <VERSENYZO NEV="Melina ROBERT-MICHON" HANYSZOR="1"/>
    <VERSENYZO NEV="Melissa MORRISON" HANYSZOR="2"/>
    <VERSENYZO NEV="Melvin SHEPPARD" HANYSZOR="3"/>
    <VERSENYZO NEV="Meredith COLKETT" HANYSZOR="1"/>
    <VERSENYZO NEV="Meredith GOURDINE" HANYSZOR="1"/>
    <VERSENYZO NEV="Merlene OTTEY" HANYSZOR="7"/>
    <VERSENYZO NEV="Merritt GIFFIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Meseret DEFAR" HANYSZOR="3"/>
    <VERSENYZO NEV="Meyer PRINSTEIN" HANYSZOR="4"/>
    <VERSENYZO NEV="Micah KOGO" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael BATES" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael D'Andrea CARTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael JOHNSON" HANYSZOR="3"/>
    <VERSENYZO NEV="Michael Lyle SHINE" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael MARSH" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael MCLEOD" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael MUSYOKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Michael TINSLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Michel JAZY" HANYSZOR="1"/>
    <VERSENYZO NEV="Michel THÃ&#x89;ATO" HANYSZOR="1"/>
    <VERSENYZO NEV="Michele BROWN" HANYSZOR="1"/>
    <VERSENYZO NEV="Micheline OSTERMEYER" HANYSZOR="2"/>
    <VERSENYZO NEV="Michelle CARTER" HANYSZOR="1"/>
    <VERSENYZO NEV="MichÃ¨le CHARDONNET" HANYSZOR="1"/>
    <VERSENYZO NEV="Miguel WHITE" HANYSZOR="1"/>
    <VERSENYZO NEV="Mihaela LOGHIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Mihaela PENES" HANYSZOR="2"/>
    <VERSENYZO NEV="Mike BOIT" HANYSZOR="1"/>
    <VERSENYZO NEV="Mike CONLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Mike LARRABEE" HANYSZOR="1"/>
    <VERSENYZO NEV="Mike POWELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Mike RYAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Mike STULCE" HANYSZOR="1"/>
    <VERSENYZO NEV="Mikhail SHCHENNIKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Miklos NEMETH" HANYSZOR="1"/>
    <VERSENYZO NEV="Milcah Chemos CHEYWA" HANYSZOR="1"/>
    <VERSENYZO NEV="Mildred DIDRIKSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Millard Frank Jr. HAMPTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Millon WOLDE" HANYSZOR="1"/>
    <VERSENYZO NEV="Miltiadis GOUSKOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Milton Gray CAMPBELL" HANYSZOR="2"/>
    <VERSENYZO NEV="Mirela DEMIREVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Mirela MANIANI" HANYSZOR="2"/>
    <VERSENYZO NEV="Miruts YIFTER" HANYSZOR="3"/>
    <VERSENYZO NEV="Mitchell WATT" HANYSZOR="1"/>
    <VERSENYZO NEV="Mizuki NOGUCHI" HANYSZOR="1"/>
    <VERSENYZO NEV="Mohamed Ahmed SULAIMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Mohamed FARAH" HANYSZOR="4"/>
    <VERSENYZO NEV="Mohamed GAMMOUDI" HANYSZOR="4"/>
    <VERSENYZO NEV="Mohammed KEDIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Monika ZEHRT" HANYSZOR="1"/>
    <VERSENYZO NEV="Mor KOVACS" HANYSZOR="1"/>
    <VERSENYZO NEV="Morgan TAYLOR" HANYSZOR="3"/>
    <VERSENYZO NEV="Morris KIRKSEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Moses KIPTANUI" HANYSZOR="1"/>
    <VERSENYZO NEV="Murray HALBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Mutaz Essa BARSHIM" HANYSZOR="2"/>
    <VERSENYZO NEV="Nadezhda CHIZHOVA" HANYSZOR="3"/>
    <VERSENYZO NEV="Nadezhda KHNYKINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Nadezhda OLIZARENKO" HANYSZOR="2"/>
    <VERSENYZO NEV="Nadine KLEINERT-SCHMITT" HANYSZOR="1"/>
    <VERSENYZO NEV="Nafissatou THIAM" HANYSZOR="1"/>
    <VERSENYZO NEV="Naftali TEMU" HANYSZOR="2"/>
    <VERSENYZO NEV="Naman KEITA" HANYSZOR="1"/>
    <VERSENYZO NEV="Nancy Jebet LAGAT" HANYSZOR="1"/>
    <VERSENYZO NEV="Naoko TAKAHASHI" HANYSZOR="1"/>
    <VERSENYZO NEV="Naoto TAJIMA" HANYSZOR="1"/>
    <VERSENYZO NEV="Natalia BOCHINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Natalia SHIKOLENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Nataliya TOBIAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Natallia DOBRYNSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Natalya ANTYUKH" HANYSZOR="2"/>
    <VERSENYZO NEV="Natalya CHISTYAKOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Natalya LEBEDEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Natalya SADOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Natalya SAZANOVICH" HANYSZOR="2"/>
    <VERSENYZO NEV="Natasha DANVERS" HANYSZOR="1"/>
    <VERSENYZO NEV="Nate CARTMELL" HANYSZOR="3"/>
    <VERSENYZO NEV="Nathan DEAKES" HANYSZOR="1"/>
    <VERSENYZO NEV="Nawal EL MOUTAWAKEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Nelson EVORA" HANYSZOR="1"/>
    <VERSENYZO NEV="Nezha BIDOUANE" HANYSZOR="1"/>
    <VERSENYZO NEV="Nia ALI" HANYSZOR="1"/>
    <VERSENYZO NEV="Nicholas WILLIS" HANYSZOR="2"/>
    <VERSENYZO NEV="Nick HYSONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Nick WINTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Nicola VIZZONI" HANYSZOR="1"/>
    <VERSENYZO NEV="Nijel AMOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Niki BAKOGIANNI" HANYSZOR="1"/>
    <VERSENYZO NEV="Nikolai KIROV" HANYSZOR="1"/>
    <VERSENYZO NEV="Nikolaos GEORGANTAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Nikolay AVILOV" HANYSZOR="2"/>
    <VERSENYZO NEV="Nikolay SMAGA" HANYSZOR="1"/>
    <VERSENYZO NEV="Nikolay SOKOLOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Nikolina CHTEREVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Nils ENGDAHL" HANYSZOR="1"/>
    <VERSENYZO NEV="Nils SCHUMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Nina DUMBADZE" HANYSZOR="1"/>
    <VERSENYZO NEV="Nina ROMASHKOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Niole SABAITE" HANYSZOR="1"/>
    <VERSENYZO NEV="Nixon KIPROTICH" HANYSZOR="1"/>
    <VERSENYZO NEV="Noah Kiprono NGENYI" HANYSZOR="1"/>
    <VERSENYZO NEV="Noe HERNANDEZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Noel FREEMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Norman HALLOWS" HANYSZOR="1"/>
    <VERSENYZO NEV="Norman PRITCHARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Norman READ" HANYSZOR="1"/>
    <VERSENYZO NEV="Norman TABER" HANYSZOR="1"/>
    <VERSENYZO NEV="Noureddine MORCELI" HANYSZOR="1"/>
    <VERSENYZO NEV="Nouria MERAH-BENIDA" HANYSZOR="1"/>
    <VERSENYZO NEV="NÃ¡ndor DÃ&#x81;NI" HANYSZOR="1"/>
    <VERSENYZO NEV="Oana PANTELIMON" HANYSZOR="1"/>
    <VERSENYZO NEV="Obadele THOMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Oleg Georgiyevich FEDOSEYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Oleksandr BAGACH" HANYSZOR="1"/>
    <VERSENYZO NEV="Oleksandr KRYKUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Oleksiy KRYKUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Olena ANTONOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olena HOVOROVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olena KRASOVSKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olga BRYZGINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olga KANISKINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olga KUZENKOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Olga MINEEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olga RYPAKOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Olga SALADUKHA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olga SHISHIGINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Olimpiada IVANOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ollie MATSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Omar MCLEOD" HANYSZOR="1"/>
    <VERSENYZO NEV="Orlando ORTEGA" HANYSZOR="1"/>
    <VERSENYZO NEV="Osleidys MENÃ&#x89;NDEZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Otis DAVIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Otis HARRIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Otto NILSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Ove ANDERSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Paavo NURMI" HANYSZOR="7"/>
    <VERSENYZO NEV="Paavo YRJÃ&#x96;LÃ&#x84;" HANYSZOR="1"/>
    <VERSENYZO NEV="Pamela JELIMO" HANYSZOR="1"/>
    <VERSENYZO NEV="Panagiotis PARASKEVOPOULOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Paola PIGNI-CACCHI" HANYSZOR="1"/>
    <VERSENYZO NEV="Parry O'BRIEN" HANYSZOR="2"/>
    <VERSENYZO NEV="Patricia GIRARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Patrick FLYNN" HANYSZOR="1"/>
    <VERSENYZO NEV="Patrick LEAHY" HANYSZOR="2"/>
    <VERSENYZO NEV="Patrick MCDONALD" HANYSZOR="1"/>
    <VERSENYZO NEV="Patrick O'CALLAGHAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Patrick SANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Patrik SJÃ&#x96;BERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul BITOK" HANYSZOR="2"/>
    <VERSENYZO NEV="Paul BONTEMPS" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul DRAYTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul Kipkemoi CHELIMO" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul Kipngetich TANUI" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul Kipsiele KOECH" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul MARTIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul TERGAT" HANYSZOR="2"/>
    <VERSENYZO NEV="Paul Vincent NIHILL" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul WEINSTEIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul WINTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Paul-Heinz WELLMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Paula MOLLENHAUER" HANYSZOR="1"/>
    <VERSENYZO NEV="Pauli NEVALA" HANYSZOR="1"/>
    <VERSENYZO NEV="Pauline DAVIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Pauline KONGA" HANYSZOR="1"/>
    <VERSENYZO NEV="Pekka VASALA" HANYSZOR="1"/>
    <VERSENYZO NEV="Percy BEARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Percy HODGE" HANYSZOR="1"/>
    <VERSENYZO NEV="Percy WILLIAMS" HANYSZOR="2"/>
    <VERSENYZO NEV="Peter FRENKEL" HANYSZOR="2"/>
    <VERSENYZO NEV="Peter NORMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Peter PETROV" HANYSZOR="1"/>
    <VERSENYZO NEV="Peter RADFORD" HANYSZOR="1"/>
    <VERSENYZO NEV="Peter SNELL" HANYSZOR="3"/>
    <VERSENYZO NEV="Peter ZAREMBA" HANYSZOR="1"/>
    <VERSENYZO NEV="Philip BAKER" HANYSZOR="1"/>
    <VERSENYZO NEV="Philip EDWARDS" HANYSZOR="3"/>
    <VERSENYZO NEV="Phillips IDOWU" HANYSZOR="1"/>
    <VERSENYZO NEV="Pierre LEWDEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Pietro MENNEA" HANYSZOR="2"/>
    <VERSENYZO NEV="Piotr MALACHOWSKI" HANYSZOR="2"/>
    <VERSENYZO NEV="Piotr POCHINCHUK" HANYSZOR="1"/>
    <VERSENYZO NEV="Primoz KOZMUS" HANYSZOR="2"/>
    <VERSENYZO NEV="Priscah JEPTOO" HANYSZOR="1"/>
    <VERSENYZO NEV="Priscilla LOPES-SCHLIEP" HANYSZOR="1"/>
    <VERSENYZO NEV="Pyotr BOLOTNIKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Quincy WATTS" HANYSZOR="1"/>
    <VERSENYZO NEV="Rachid EL BASIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Raelene Ann BOYLE" HANYSZOR="3"/>
    <VERSENYZO NEV="Rafer JOHNSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Ragnar Torsten LUNDBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Ralph BOSTON" HANYSZOR="2"/>
    <VERSENYZO NEV="Ralph CRAIG" HANYSZOR="2"/>
    <VERSENYZO NEV="Ralph DOUBELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Ralph HILL" HANYSZOR="1"/>
    <VERSENYZO NEV="Ralph HILLS" HANYSZOR="1"/>
    <VERSENYZO NEV="Ralph MANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ralph METCALFE" HANYSZOR="3"/>
    <VERSENYZO NEV="Ralph ROSE" HANYSZOR="5"/>
    <VERSENYZO NEV="Randel Luvelle WILLIAMS" HANYSZOR="1"/>
    <VERSENYZO NEV="Randy BARNES" HANYSZOR="1"/>
    <VERSENYZO NEV="Randy MATSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Raphael HOLZDEPPE" HANYSZOR="1"/>
    <VERSENYZO NEV="Raymond James BARBUTI" HANYSZOR="1"/>
    <VERSENYZO NEV="RaÃºl GONZÃ&#x81;LEZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Reese HOFFA" HANYSZOR="1"/>
    <VERSENYZO NEV="Reggie WALKER" HANYSZOR="1"/>
    <VERSENYZO NEV="Rein AUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Reinaldo GORNO" HANYSZOR="1"/>
    <VERSENYZO NEV="Renate GARISCH-CULMBERGER-BOY" HANYSZOR="1"/>
    <VERSENYZO NEV="Renate STECHER" HANYSZOR="4"/>
    <VERSENYZO NEV="Renaud LAVILLENIE" HANYSZOR="2"/>
    <VERSENYZO NEV="Reuben KOSGEI" HANYSZOR="1"/>
    <VERSENYZO NEV="Ria STALMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard CHELIMO" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard COCHRAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard Charles WOHLHUTER" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard HOWARD" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard Kipkemboi MATEELONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard Leslie BYRD" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard SHELDON" HANYSZOR="1"/>
    <VERSENYZO NEV="Richard THOMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Rick MITCHELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Rink BABKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Rita JAHN" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert CLOUGHEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert GARRETT" HANYSZOR="5"/>
    <VERSENYZO NEV="Robert GRABARZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert HARTING" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert HEFFERNAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert Hyatt CLARK" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert KERR" HANYSZOR="2"/>
    <VERSENYZO NEV="Robert KORZENIOWSKI" HANYSZOR="4"/>
    <VERSENYZO NEV="Robert Keyser SCHUL" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert MCMILLEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert Morton Newburgh TISDALL" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert SHAVLAKADZE" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert STANGLAND" HANYSZOR="2"/>
    <VERSENYZO NEV="Robert TAYLOR" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert VAN OSDEL" HANYSZOR="1"/>
    <VERSENYZO NEV="Robert ZMELÃ&#x8d;K" HANYSZOR="1"/>
    <VERSENYZO NEV="Roberta BRUNET" HANYSZOR="1"/>
    <VERSENYZO NEV="Roberto MOYA" HANYSZOR="1"/>
    <VERSENYZO NEV="Rod MILBURN" HANYSZOR="1"/>
    <VERSENYZO NEV="Rodney DIXON" HANYSZOR="1"/>
    <VERSENYZO NEV="Roger BLACK" HANYSZOR="1"/>
    <VERSENYZO NEV="Roger KINGDOM" HANYSZOR="1"/>
    <VERSENYZO NEV="Roger MOENS" HANYSZOR="1"/>
    <VERSENYZO NEV="Roland WIESER" HANYSZOR="1"/>
    <VERSENYZO NEV="Rolf DANNEBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Roman SCHURENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Roman SEBRLE" HANYSZOR="2"/>
    <VERSENYZO NEV="Romas UBARTAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Romeo BERTINI" HANYSZOR="1"/>
    <VERSENYZO NEV="Romuald KLIM" HANYSZOR="1"/>
    <VERSENYZO NEV="Ron CLARKE" HANYSZOR="1"/>
    <VERSENYZO NEV="Ron DELANY" HANYSZOR="1"/>
    <VERSENYZO NEV="Ron FREEMAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ronald MORRIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Ronald WEIGEL" HANYSZOR="3"/>
    <VERSENYZO NEV="Rosa MOTA" HANYSZOR="2"/>
    <VERSENYZO NEV="Rosemarie WITSCHAS-ACKERMANN" HANYSZOR="1"/>
    <VERSENYZO NEV="Roy Braxton COCHRAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Rui SILVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Rune LARSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Ruth BEITIA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ruth FUCHS" HANYSZOR="2"/>
    <VERSENYZO NEV="Ruth JEBET" HANYSZOR="1"/>
    <VERSENYZO NEV="Ruth OSBURN" HANYSZOR="1"/>
    <VERSENYZO NEV="Ruth SVEDBERG" HANYSZOR="1"/>
    <VERSENYZO NEV="Ryan CROUSER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ryszard KATUS" HANYSZOR="1"/>
    <VERSENYZO NEV="Sabine BRAUN" HANYSZOR="1"/>
    <VERSENYZO NEV="Sabine EVERTS" HANYSZOR="1"/>
    <VERSENYZO NEV="Sabine JOHN" HANYSZOR="1"/>
    <VERSENYZO NEV="Saida GUNBA" HANYSZOR="1"/>
    <VERSENYZO NEV="Salah HISSOU" HANYSZOR="1"/>
    <VERSENYZO NEV="Sally GUNNELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Sally Jepkosgei KIPYEGO" HANYSZOR="1"/>
    <VERSENYZO NEV="Sally PEARSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Salvatore MORALE" HANYSZOR="1"/>
    <VERSENYZO NEV="Sam GRADDY" HANYSZOR="1"/>
    <VERSENYZO NEV="Sam KENDRICKS" HANYSZOR="1"/>
    <VERSENYZO NEV="Samson KITUR" HANYSZOR="1"/>
    <VERSENYZO NEV="Samuel FERRIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Samuel JONES" HANYSZOR="1"/>
    <VERSENYZO NEV="Samuel Kamau WANJIRU" HANYSZOR="1"/>
    <VERSENYZO NEV="Samuel MATETE" HANYSZOR="1"/>
    <VERSENYZO NEV="Sandi MORRIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Sandra FARMER-PATRICK" HANYSZOR="1"/>
    <VERSENYZO NEV="Sandra PERKOVIC" HANYSZOR="2"/>
    <VERSENYZO NEV="Sandro BELLUCCI" HANYSZOR="1"/>
    <VERSENYZO NEV="Sanya RICHARDS-ROSS" HANYSZOR="2"/>
    <VERSENYZO NEV="Sara KOLAK" HANYSZOR="1"/>
    <VERSENYZO NEV="Sara SIMEONI" HANYSZOR="2"/>
    <VERSENYZO NEV="Sara Slott PETERSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Sarka KASPARKOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="SaÃ¯d AOUITA" HANYSZOR="1"/>
    <VERSENYZO NEV="Schuyler ENCK" HANYSZOR="1"/>
    <VERSENYZO NEV="Sebastian COE" HANYSZOR="4"/>
    <VERSENYZO NEV="Semyon RZISHCHIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Seppo RÃ&#x84;TY" HANYSZOR="2"/>
    <VERSENYZO NEV="Sergei ZHELANOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Sergey KLYUGIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Sergey LITVINOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Sergey MAKAROV" HANYSZOR="2"/>
    <VERSENYZO NEV="Setymkul DZHUMANAZAROV" HANYSZOR="1"/>
    <VERSENYZO NEV="Shalane FLANAGAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Shaunae MILLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Shawn CRAWFORD" HANYSZOR="2"/>
    <VERSENYZO NEV="Sheena TOSTA" HANYSZOR="1"/>
    <VERSENYZO NEV="Sheila LERWILL" HANYSZOR="1"/>
    <VERSENYZO NEV="Shelly-Ann FRASER-PRYCE" HANYSZOR="4"/>
    <VERSENYZO NEV="Shenjie QIEYANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Shericka JACKSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Shericka WILLIAMS" HANYSZOR="1"/>
    <VERSENYZO NEV="Sherone SIMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Shirley CAWLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Shirley STRICKLAND" HANYSZOR="2"/>
    <VERSENYZO NEV="Shirley STRONG" HANYSZOR="1"/>
    <VERSENYZO NEV="Shoryu NAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Shuhei NISHIDA" HANYSZOR="1"/>
    <VERSENYZO NEV="Sidney ATKINSON" HANYSZOR="2"/>
    <VERSENYZO NEV="Sidney ROBINSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Siegfried WENTZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Sileshi SIHINE" HANYSZOR="2"/>
    <VERSENYZO NEV="Silke RENK" HANYSZOR="1"/>
    <VERSENYZO NEV="Silvia CHIVAS BARO" HANYSZOR="1"/>
    <VERSENYZO NEV="Silvio LEONARD SARRIA" HANYSZOR="1"/>
    <VERSENYZO NEV="Sim INESS" HANYSZOR="1"/>
    <VERSENYZO NEV="Simeon TORIBIO" HANYSZOR="1"/>
    <VERSENYZO NEV="Sofia ASSEFA" HANYSZOR="1"/>
    <VERSENYZO NEV="Sonia O'SULLIVAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Sophie HITCHON" HANYSZOR="1"/>
    <VERSENYZO NEV="Sotirios VERSIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Spyridon LOUIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Stacy DRAGILA" HANYSZOR="1"/>
    <VERSENYZO NEV="Stanislawa WALASIEWICZ" HANYSZOR="2"/>
    <VERSENYZO NEV="Stanley Frank VICKERS" HANYSZOR="1"/>
    <VERSENYZO NEV="Stanley ROWLEY" HANYSZOR="2"/>
    <VERSENYZO NEV="Stefan HOLM" HANYSZOR="1"/>
    <VERSENYZO NEV="Stefano BALDINI" HANYSZOR="1"/>
    <VERSENYZO NEV="Steffi NERIUS" HANYSZOR="1"/>
    <VERSENYZO NEV="Stefka KOSTADINOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Sten PETTERSSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Stephan FREIGANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Stephanie BROWN TRAFTON" HANYSZOR="1"/>
    <VERSENYZO NEV="Stephanie GRAF" HANYSZOR="1"/>
    <VERSENYZO NEV="Stephen KIPKORIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Stephen KIPROTICH" HANYSZOR="1"/>
    <VERSENYZO NEV="Steve ANDERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Steve BACKLEY" HANYSZOR="3"/>
    <VERSENYZO NEV="Steve CRAM" HANYSZOR="1"/>
    <VERSENYZO NEV="Steve HOOKER" HANYSZOR="1"/>
    <VERSENYZO NEV="Steve LEWIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Steve OVETT" HANYSZOR="2"/>
    <VERSENYZO NEV="Steve SMITH" HANYSZOR="1"/>
    <VERSENYZO NEV="Suleiman NYAMBUI" HANYSZOR="1"/>
    <VERSENYZO NEV="Sulo BÃ&#x84;RLUND" HANYSZOR="1"/>
    <VERSENYZO NEV="Sunette VILJOEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Susanthika JAYASINGHE" HANYSZOR="1"/>
    <VERSENYZO NEV="Sverre HANSEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Svetlana FEOFANOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Svetlana KRIVELYOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Svetlana MASTERKOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Svetlana SHKOLINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Sylvio CATOR" HANYSZOR="1"/>
    <VERSENYZO NEV="Szymon ZIOLKOWSKI" HANYSZOR="1"/>
    <VERSENYZO NEV="SÃ&#x83;Â¡ndor ROZSNYÃ&#x83;?I" HANYSZOR="1"/>
    <VERSENYZO NEV="Tadeusz RUT" HANYSZOR="1"/>
    <VERSENYZO NEV="Tadeusz SLUSARSKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Taisiya CHENCHIK" HANYSZOR="1"/>
    <VERSENYZO NEV="Tamara PRESS" HANYSZOR="4"/>
    <VERSENYZO NEV="Tamirat TOLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tanya LAWRENCE" HANYSZOR="1"/>
    <VERSENYZO NEV="Taoufik MAKHLOUFI" HANYSZOR="3"/>
    <VERSENYZO NEV="Tapio KANTANEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Tariku BEKELE" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatiana ANISIMOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatiana GRIGORIEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatiana KAZANKINA" HANYSZOR="3"/>
    <VERSENYZO NEV="Tatiana KOLPAKOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatiana LESOVAIA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatiana PROVIDOKHINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatiana SKACHKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatyana CHERNOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Tatyana KOTOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Tatyana LEBEDEVA" HANYSZOR="3"/>
    <VERSENYZO NEV="Tatyana PETROVA ARKHIPOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatyana SHCHELKANOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tatyana TOMASHOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Terence Lloyd JOHNSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Tereza MARINOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tero PITKAMAKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Terrence TRAMMELL" HANYSZOR="2"/>
    <VERSENYZO NEV="Tesfaye TOLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tetyana TERESHCHUK" HANYSZOR="1"/>
    <VERSENYZO NEV="Thaddeus SHIDELER" HANYSZOR="1"/>
    <VERSENYZO NEV="Thane BAKER" HANYSZOR="3"/>
    <VERSENYZO NEV="Theresia KIESL" HANYSZOR="1"/>
    <VERSENYZO NEV="Thiago Braz DA SILVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas BURKE" HANYSZOR="2"/>
    <VERSENYZO NEV="Thomas COURTNEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas CURTIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas EVENSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas Francis FARRELL" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas Francis KIELY" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas HAMPSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas HICKS" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas HILL" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas JEFFERSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas John Henry RICHARDS" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas LIEB" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas MUNKELT" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas Pkemei LONGOSIWA" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas ROHLER" HANYSZOR="1"/>
    <VERSENYZO NEV="Thomas William GREEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Tia HELLEBAUT" HANYSZOR="1"/>
    <VERSENYZO NEV="Tianfeng SI" HANYSZOR="1"/>
    <VERSENYZO NEV="Tianna BARTOLETTA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tiki GELANA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tilly FLEISCHER" HANYSZOR="2"/>
    <VERSENYZO NEV="Tim AHEARNE" HANYSZOR="1"/>
    <VERSENYZO NEV="Tim FORSYTH" HANYSZOR="1"/>
    <VERSENYZO NEV="Timothy KITUM" HANYSZOR="1"/>
    <VERSENYZO NEV="Timothy MACK" HANYSZOR="1"/>
    <VERSENYZO NEV="Tirunesh DIBABA" HANYSZOR="6"/>
    <VERSENYZO NEV="Toby STEVENSON" HANYSZOR="1"/>
    <VERSENYZO NEV="Toivo HYYTIÃ&#x84;INEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Toivo LOUKOLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Tomas WALSH" HANYSZOR="1"/>
    <VERSENYZO NEV="Tomasz MAJEWSKI" HANYSZOR="2"/>
    <VERSENYZO NEV="Tommie SMITH" HANYSZOR="1"/>
    <VERSENYZO NEV="TomÃ¡? DVORÃ&#x81;K" HANYSZOR="1"/>
    <VERSENYZO NEV="Tonique WILLIAMS-DARLING" HANYSZOR="1"/>
    <VERSENYZO NEV="Tonja BUFORD-BAILEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Tony DEES" HANYSZOR="1"/>
    <VERSENYZO NEV="Tore SJÃ&#x96;STRAND" HANYSZOR="1"/>
    <VERSENYZO NEV="Tori BOWIE" HANYSZOR="2"/>
    <VERSENYZO NEV="Torsten VOSS" HANYSZOR="1"/>
    <VERSENYZO NEV="Trey HARDEE" HANYSZOR="1"/>
    <VERSENYZO NEV="Trine HATTESTAD" HANYSZOR="2"/>
    <VERSENYZO NEV="Truxtun HARE" HANYSZOR="2"/>
    <VERSENYZO NEV="Tsegay KEBEDE" HANYSZOR="1"/>
    <VERSENYZO NEV="Tsvetanka KHRISTOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Udo BEYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Ugo FRIGERIO" HANYSZOR="1"/>
    <VERSENYZO NEV="Ulrike KLAPEZYNSKI-BRUNS" HANYSZOR="1"/>
    <VERSENYZO NEV="Ursula DONATH" HANYSZOR="1"/>
    <VERSENYZO NEV="Urszula KIELAN" HANYSZOR="1"/>
    <VERSENYZO NEV="Usain BOLT" HANYSZOR="6"/>
    <VERSENYZO NEV="Ute HOMMOLA" HANYSZOR="1"/>
    <VERSENYZO NEV="Uwe BEYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Vadim DEVYATOVSKIY" HANYSZOR="1"/>
    <VERSENYZO NEV="Vadims VASILEVSKIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Vala FLOSADÃ&#x93;TTIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Valentin MASSANA" HANYSZOR="1"/>
    <VERSENYZO NEV="Valentina YEGOROVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Valeri BRUMEL" HANYSZOR="2"/>
    <VERSENYZO NEV="Valeri PODLUZHNYI" HANYSZOR="1"/>
    <VERSENYZO NEV="Valeria BUFANU" HANYSZOR="1"/>
    <VERSENYZO NEV="Valerie ADAMS" HANYSZOR="3"/>
    <VERSENYZO NEV="Valerie BRISCO" HANYSZOR="2"/>
    <VERSENYZO NEV="Valerio ARRI" HANYSZOR="1"/>
    <VERSENYZO NEV="Valeriy BORCHIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Valery BORZOV" HANYSZOR="3"/>
    <VERSENYZO NEV="Vanderlei DE LIMA" HANYSZOR="1"/>
    <VERSENYZO NEV="Vasili ARKHIPENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Vasili RUDENKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Vasiliy KAPTYUKH" HANYSZOR="1"/>
    <VERSENYZO NEV="Vasily KUZNETSOV" HANYSZOR="2"/>
    <VERSENYZO NEV="Vassilka STOEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="VebjÃ¸rn RODAL" HANYSZOR="1"/>
    <VERSENYZO NEV="Veikko KARVONEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Veniamin SOLDATENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Venuste NIYONGABO" HANYSZOR="1"/>
    <VERSENYZO NEV="Vera KOLASHNIKOVA-KREPKINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Vera KOMISOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Vera POSPISILOVA-CECHLOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Veronica CAMPBELL-BROWN" HANYSZOR="4"/>
    <VERSENYZO NEV="Viktor KRAVCHENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Viktor MARKIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Viktor RASHCHUPKIN" HANYSZOR="1"/>
    <VERSENYZO NEV="Viktor SANEYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Viktor TSYBULENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Vilho Aleksander NIITTYMAA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ville PÃ&#x96;RHÃ&#x96;LÃ&#x84;" HANYSZOR="1"/>
    <VERSENYZO NEV="Ville RITOLA" HANYSZOR="5"/>
    <VERSENYZO NEV="Ville TUULOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Vilmos VARJU" HANYSZOR="1"/>
    <VERSENYZO NEV="Vince MATTHEWS" HANYSZOR="1"/>
    <VERSENYZO NEV="Violeta SZEKELY" HANYSZOR="1"/>
    <VERSENYZO NEV="Virgilijus ALEKNA" HANYSZOR="3"/>
    <VERSENYZO NEV="Vita STYOPINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Vitold KREYER" HANYSZOR="1"/>
    <VERSENYZO NEV="Vivian Jepkemoi CHERUIYOT" HANYSZOR="4"/>
    <VERSENYZO NEV="Vladimir ANDREYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Vladimir DUBROVSHCHIK" HANYSZOR="1"/>
    <VERSENYZO NEV="Vladimir GOLUBNICHY" HANYSZOR="4"/>
    <VERSENYZO NEV="Vladimir GORYAYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Vladimir KAZANTSEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Vladimir KISELEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Vladimir KUTS" HANYSZOR="2"/>
    <VERSENYZO NEV="Voitto HELLSTEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Volker BECK" HANYSZOR="1"/>
    <VERSENYZO NEV="Volmari ISO-HOLLO" HANYSZOR="4"/>
    <VERSENYZO NEV="Voula PATOULIDOU" HANYSZOR="1"/>
    <VERSENYZO NEV="Vyacheslav IVANENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Vyacheslav LYKHO" HANYSZOR="1"/>
    <VERSENYZO NEV="Waldemar CIERPINSKI" HANYSZOR="2"/>
    <VERSENYZO NEV="Walt DAVIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Walter DIX" HANYSZOR="2"/>
    <VERSENYZO NEV="Walter KRÃ&#x9c;GER" HANYSZOR="1"/>
    <VERSENYZO NEV="Walter RANGELEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Walter TEWKSBURY" HANYSZOR="3"/>
    <VERSENYZO NEV="Warren (Rex) Jay CAWLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Warren WEIR" HANYSZOR="1"/>
    <VERSENYZO NEV="Wayde VAN NIEKERK" HANYSZOR="1"/>
    <VERSENYZO NEV="Wayne COLLETT" HANYSZOR="1"/>
    <VERSENYZO NEV="Wendell MOTTLEY" HANYSZOR="1"/>
    <VERSENYZO NEV="Wenxiu ZHANG" HANYSZOR="2"/>
    <VERSENYZO NEV="Werner LUEG" HANYSZOR="1"/>
    <VERSENYZO NEV="Wesley COE" HANYSZOR="1"/>
    <VERSENYZO NEV="Wilfred BUNGEI" HANYSZOR="1"/>
    <VERSENYZO NEV="Wilhelmina VON BREMEN" HANYSZOR="1"/>
    <VERSENYZO NEV="Will CLAYE" HANYSZOR="3"/>
    <VERSENYZO NEV="Willem SLIJKHUIS" HANYSZOR="2"/>
    <VERSENYZO NEV="Willi HOLDORF" HANYSZOR="1"/>
    <VERSENYZO NEV="William APPLEGARTH" HANYSZOR="1"/>
    <VERSENYZO NEV="William Arthur CARR" HANYSZOR="1"/>
    <VERSENYZO NEV="William CROTHERS" HANYSZOR="1"/>
    <VERSENYZO NEV="William De Hart HUBBARD" HANYSZOR="1"/>
    <VERSENYZO NEV="William HAPPENNY" HANYSZOR="1"/>
    <VERSENYZO NEV="William HOGENSON" HANYSZOR="2"/>
    <VERSENYZO NEV="William HOLLAND" HANYSZOR="1"/>
    <VERSENYZO NEV="William MUTWOL" HANYSZOR="1"/>
    <VERSENYZO NEV="William NIEDER" HANYSZOR="1"/>
    <VERSENYZO NEV="William Preston MILLER" HANYSZOR="1"/>
    <VERSENYZO NEV="William TANUI" HANYSZOR="1"/>
    <VERSENYZO NEV="William VERNER" HANYSZOR="1"/>
    <VERSENYZO NEV="William Waring MILLER" HANYSZOR="1"/>
    <VERSENYZO NEV="William Welles HOYT" HANYSZOR="1"/>
    <VERSENYZO NEV="Willie DAVENPORT" HANYSZOR="2"/>
    <VERSENYZO NEV="Willie MAY" HANYSZOR="1"/>
    <VERSENYZO NEV="Willy SCHÃ&#x84;RER" HANYSZOR="1"/>
    <VERSENYZO NEV="Wilma RUDOLPH" HANYSZOR="2"/>
    <VERSENYZO NEV="Wilson Boit KIPKETER" HANYSZOR="1"/>
    <VERSENYZO NEV="Wilson KIPKETER" HANYSZOR="2"/>
    <VERSENYZO NEV="Wilson KIPRUGUT" HANYSZOR="2"/>
    <VERSENYZO NEV="Wilson Kipsang KIPROTICH" HANYSZOR="1"/>
    <VERSENYZO NEV="Winthrop GRAHAM" HANYSZOR="1"/>
    <VERSENYZO NEV="Wladyslaw KOZAKIEWICZ" HANYSZOR="1"/>
    <VERSENYZO NEV="Wojciech NOWICKI" HANYSZOR="1"/>
    <VERSENYZO NEV="Wolfgang HANISCH" HANYSZOR="1"/>
    <VERSENYZO NEV="Wolfgang REINHARDT" HANYSZOR="1"/>
    <VERSENYZO NEV="Wolfgang SCHMIDT" HANYSZOR="1"/>
    <VERSENYZO NEV="Wolrad EBERLE" HANYSZOR="1"/>
    <VERSENYZO NEV="Wyndham HALSWELLE" HANYSZOR="1"/>
    <VERSENYZO NEV="Wyomia TYUS" HANYSZOR="2"/>
    <VERSENYZO NEV="Xiang LIU" HANYSZOR="1"/>
    <VERSENYZO NEV="Ximena RESTREPO" HANYSZOR="1"/>
    <VERSENYZO NEV="Xinmei SUI" HANYSZOR="1"/>
    <VERSENYZO NEV="Xiuzhi LU" HANYSZOR="1"/>
    <VERSENYZO NEV="Yanfeng LI" HANYSZOR="1"/>
    <VERSENYZO NEV="Yanina KAROLCHIK" HANYSZOR="1"/>
    <VERSENYZO NEV="Yanis LUSIS" HANYSZOR="1"/>
    <VERSENYZO NEV="Yarelys BARRIOS" HANYSZOR="1"/>
    <VERSENYZO NEV="Yarisley SILVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yaroslav RYBAKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Yasmani COPELLO" HANYSZOR="1"/>
    <VERSENYZO NEV="Yelena GORCHAKOVA" HANYSZOR="2"/>
    <VERSENYZO NEV="Yelena ISINBAEVA" HANYSZOR="3"/>
    <VERSENYZO NEV="Yelena PROKHOROVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yelena YELESINA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yelizaveta BAGRYANTSEVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yevgeni ARZHANOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Yevgeni GAVRILENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Yevgeni MASKINSKOV" HANYSZOR="1"/>
    <VERSENYZO NEV="Yevgeny Mikhaylovich IVCHENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Yipsi MORENO" HANYSZOR="2"/>
    <VERSENYZO NEV="Yoel GARCÃ&#x8d;A" HANYSZOR="1"/>
    <VERSENYZO NEV="Yoelvis QUESADA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yohan BLAKE" HANYSZOR="2"/>
    <VERSENYZO NEV="Yordanka BLAGOEVA-DIMITROVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yordanka DONKOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Young-Cho HWANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Yuko ARIMORI" HANYSZOR="2"/>
    <VERSENYZO NEV="Yulimar ROJAS" HANYSZOR="1"/>
    <VERSENYZO NEV="Yuliya NESTSIARENKA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yumileidi CUMBA" HANYSZOR="1"/>
    <VERSENYZO NEV="Yunaika CRAWFORD" HANYSZOR="1"/>
    <VERSENYZO NEV="Yunxia QU" HANYSZOR="1"/>
    <VERSENYZO NEV="Yuri KUTSENKO" HANYSZOR="1"/>
    <VERSENYZO NEV="Yuri SEDYKH" HANYSZOR="2"/>
    <VERSENYZO NEV="Yuri TAMM" HANYSZOR="1"/>
    <VERSENYZO NEV="Yuriy BORZAKOVSKIY" HANYSZOR="1"/>
    <VERSENYZO NEV="Yury Nikolayevich LITUYEV" HANYSZOR="1"/>
    <VERSENYZO NEV="Yvette WILLIAMS" HANYSZOR="1"/>
    <VERSENYZO NEV="Zdzislaw KRZYSZKOWIAK" HANYSZOR="1"/>
    <VERSENYZO NEV="Zelin CAI" HANYSZOR="1"/>
    <VERSENYZO NEV="Zersenay TADESE" HANYSZOR="1"/>
    <VERSENYZO NEV="Zhen WANG" HANYSZOR="2"/>
    <VERSENYZO NEV="Zhihong HUANG" HANYSZOR="1"/>
    <VERSENYZO NEV="Zoltan KOVAGO" HANYSZOR="1"/>
    <VERSENYZO NEV="Zuzana HEJNOVA" HANYSZOR="1"/>
    <VERSENYZO NEV="Ã&#x83;â&#x80;&#x93;dÃ&#x83;Â¶n FÃ&#x83;â&#x80;&#x93;LDESSY" HANYSZOR="1"/>
    <VERSENYZO NEV="Ã&#x89;mile CHAMPION" HANYSZOR="1"/>
</VERSENYZOK>
```
**8. lekérdezés:**

A lekérdezés egy olyan XML dokumentumot állít elő, amely visszaadja a női versenyszámok nevét, illetve a versenyszám aranyérmesének adatait, olimpiánként.

```xquery
xquery version "3.1";

import schema default element namespace "" at "8_feladat.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:indent "yes";

let $json := fn:json-doc("../olympic_results.json")?*
let $events := distinct-values($json?name)
let $items := for $item in $json
                return $item
                
return validate {document {
            <VERSENYSZAMOK ALL="{fn:count($events)}">
                {
                    for $item in $items
                    where fn:contains($item?name, "Women")
                    return <VERSENYSZAM NEV="{$item?name}">
                    { for $game in $item?games?*
                      return <OLIMPIA EV="{$game?year}" HELYSZIN="{$game?location}">
                        { for $result in $game?results?*
                            where $result?medal eq "G"
                            return <VERSENYZO NEV="{$result?name}" EREDMENY="{$result?result}" NEMZETISEG="{$result?nationality}"/>
                        }
                        </OLIMPIA>
                    }
                    </VERSENYSZAM>
                }
            </VERSENYSZAMOK>
        }}
```
**Eredmény:**
```xml
<VERSENYSZAMOK ALL="47">
    <VERSENYSZAM NEV="10000M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Almaz AYANA" EREDMENY="29:17.45" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Tirunesh DIBABA" EREDMENY="29:54.66" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Derartu TULU" EREDMENY="30:17.49" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Derartu TULU" EREDMENY="31:06.02" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Tirunesh DIBABA" EREDMENY="30:20.75" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Huina XING" EREDMENY="30:24.36" NEMZETISEG="CHN"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Fernanda RIBEIRO" EREDMENY="31:01.63" NEMZETISEG="POR"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="100M Hurdles Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Brianna ROLLINS" EREDMENY="12.48" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Dawn HARPER" EREDMENY="12.54,+0.1" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Olga SHISHIGINA" EREDMENY="12.65" NEMZETISEG="KAZ"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Voula PATOULIDOU" EREDMENY="12.64" NEMZETISEG="GRE"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Benita FITZGERALD-BROWN" EREDMENY="12.84" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Johanna SCHALLER-KLIER" EREDMENY="12.77" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Sally PEARSON" EREDMENY="12.35" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Joanna HAYES" EREDMENY="12.37" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Ludmila ENGQUIST" EREDMENY="12.58" NEMZETISEG="SWE"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Vera KOMISOVA" EREDMENY="12.56" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Annelie EHRHARDT" EREDMENY="12.59" NEMZETISEG="GDR"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="100M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Elaine THOMPSON" EREDMENY="10.71" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Shelly-Ann FRASER-PRYCE" EREDMENY="10.78" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney"/>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Gail DEVERS" EREDMENY="10.82" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Evelyn ASHFORD" EREDMENY="10.97" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Annegret RICHTER-IRRGANG" EREDMENY="11.08" NEMZETISEG="FRG"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Wyomia TYUS" EREDMENY="11" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Wilma RUDOLPH" EREDMENY="11" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Marjorie JACKSON" EREDMENY="11.5" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1936" HELYSZIN="Berlin">
            <VERSENYZO NEV="Helen STEPHENS" EREDMENY="11.5" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1928" HELYSZIN="Amsterdam">
            <VERSENYZO NEV="Elizabeth ROBINSON" EREDMENY="12.2" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Shelly-Ann FRASER-PRYCE" EREDMENY="10.75" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Yuliya NESTSIARENKA" EREDMENY="10.93" NEMZETISEG="BLR"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Gail DEVERS" EREDMENY="10.94" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Lyudmila KONDRATYEVA" EREDMENY="11.06" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Renate STECHER" EREDMENY="11.07" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Wyomia TYUS" EREDMENY="11.4" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1956" HELYSZIN="Melbourne / Stockholm">
            <VERSENYZO NEV="Betty CUTHBERT" EREDMENY="11.5" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1948" HELYSZIN="London">
            <VERSENYZO NEV="Fanny BLANKERS-KOEN" EREDMENY="11.9" NEMZETISEG="NED"/>
        </OLIMPIA>
        <OLIMPIA EV="1932" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Stanislawa WALASIEWICZ" EREDMENY="11.9" NEMZETISEG="POL"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="1500M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Faith Chepngetich KIPYEGON"
                       EREDMENY="4:08.92"
                       NEMZETISEG="KEN"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Nancy Jebet LAGAT" EREDMENY="4:00.23" NEMZETISEG="KEN"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Nouria MERAH-BENIDA" EREDMENY="04:05.10" NEMZETISEG="ALG"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Hassiba BOULMERKA" EREDMENY="3:55.30" NEMZETISEG="ALG"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Gabriella DORIO" EREDMENY="4:03.25" NEMZETISEG="ITA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Tatiana KAZANKINA" EREDMENY="4:05.48" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London"/>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Kelly HOLMES" EREDMENY="3:57.90" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Svetlana MASTERKOVA" EREDMENY="4:00.83" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Tatiana KAZANKINA" EREDMENY="3:56.6" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Lyudmila BRAGINA" EREDMENY="4:01.38" NEMZETISEG="URS"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="200M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Elaine THOMPSON" EREDMENY="21.78" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Veronica CAMPBELL-BROWN"
                       EREDMENY="21.74,+0.6"
                       NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Pauline DAVIS" EREDMENY="22.27" NEMZETISEG="BAH"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Gwen TORRENCE" EREDMENY="21.81" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Valerie BRISCO" EREDMENY="21.81" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="BÃ¤rbel ECKERT-WÃ&#x96;CKEL" EREDMENY="22.37" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Irena KIRSZENSTEIN" EREDMENY="22.5" NEMZETISEG="POL"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Wilma RUDOLPH" EREDMENY="24" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Marjorie JACKSON" EREDMENY="23.7" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Allyson FELIX" EREDMENY="21.88" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Veronica CAMPBELL-BROWN" EREDMENY="22.05" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Marie-JosÃ© PÃ&#x89;REC" EREDMENY="22.12" NEMZETISEG="FRA"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="BÃ¤rbel ECKERT-WÃ&#x96;CKEL" EREDMENY="22.03" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Renate STECHER" EREDMENY="22.4" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Edith MCGUIRE" EREDMENY="23" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1956" HELYSZIN="Melbourne / Stockholm">
            <VERSENYZO NEV="Betty CUTHBERT" EREDMENY="23.4" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1948" HELYSZIN="London">
            <VERSENYZO NEV="Fanny BLANKERS-KOEN" EREDMENY="24.4" NEMZETISEG="NED"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="20Km Race Walk Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Hong LIU" EREDMENY="1:28:35" NEMZETISEG="CHN"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Olga KANISKINA" EREDMENY="1h26:31" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Liping WANG" EREDMENY="01h29:05" NEMZETISEG="CHN"/>
            <VERSENYZO NEV="Liping WANG" EREDMENY="01h29:05" NEMZETISEG="CHN"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Elena LASHMANOVA" EREDMENY="1:25:02" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Athanasia TSOUMELEKA" EREDMENY="1h29:12" NEMZETISEG="GRE"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="3000M Steeplechase Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Ruth JEBET" EREDMENY="8:59.75" NEMZETISEG="BRN"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Gulnara SAMITOVA" EREDMENY="8:58.81" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Habiba GHRIBI" EREDMENY="9:08.37" NEMZETISEG="TUN"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="400M Hurdles Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Dalilah MUHAMMAD" EREDMENY="53.13" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Melaine WALKER" EREDMENY="52.64" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Irina PRIVALOVA" EREDMENY="53.02" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Sally GUNNELL" EREDMENY="53.23" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Nawal EL MOUTAWAKEL" EREDMENY="54.61" NEMZETISEG="MAR"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Natalya ANTYUKH" EREDMENY="52.7" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Fani KHALKIA" EREDMENY="52.82" NEMZETISEG="GRE"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Deon Marie HEMMINGS" EREDMENY="52.82" NEMZETISEG="JAM"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="400M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Shaunae MILLER" EREDMENY="49.44" NEMZETISEG="BAH"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Christine OHURUOGU" EREDMENY="49.62" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Cathy FREEMAN" EREDMENY="49.11" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Marie-JosÃ© PÃ&#x89;REC" EREDMENY="48.83" NEMZETISEG="FRA"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Valerie BRISCO" EREDMENY="48.83" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Irena KIRSZENSTEIN" EREDMENY="49.29" NEMZETISEG="POL"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Colette BESSON" EREDMENY="52" NEMZETISEG="FRA"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Sanya RICHARDS-ROSS" EREDMENY="49.55" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Tonique WILLIAMS-DARLING" EREDMENY="49.41" NEMZETISEG="BAH"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Marie-JosÃ© PÃ&#x89;REC" EREDMENY="48.25" NEMZETISEG="FRA"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Marita KOCH" EREDMENY="48.88" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Monika ZEHRT" EREDMENY="51.08" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Betty CUTHBERT" EREDMENY="52" NEMZETISEG="AUS"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="4X100M Relay Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="" EREDMENY="41.01" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="" EREDMENY="42.54" NEMZETISEG="BEL"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="" EREDMENY="41.95" NEMZETISEG="BAH"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="" EREDMENY="42.11" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="" EREDMENY="41.65" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="" EREDMENY="42.55" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="" EREDMENY="42.8" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="" EREDMENY="44.5" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="" EREDMENY="45.9" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1936" HELYSZIN="Berlin">
            <VERSENYZO NEV="" EREDMENY="46.9" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1928" HELYSZIN="Amsterdam">
            <VERSENYZO NEV="" EREDMENY="48.4" NEMZETISEG="CAN"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="" EREDMENY="40.82" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="" EREDMENY="41.73" NEMZETISEG="JAM"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="" EREDMENY="41.95" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="" EREDMENY="41.6" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="" EREDMENY="42.81" NEMZETISEG="FRG"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="" EREDMENY="43.6" NEMZETISEG="POL"/>
        </OLIMPIA>
        <OLIMPIA EV="1956" HELYSZIN="Melbourne / Stockholm">
            <VERSENYZO NEV="" EREDMENY="44.5" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1948" HELYSZIN="London">
            <VERSENYZO NEV="" EREDMENY="47.5" NEMZETISEG="NED"/>
        </OLIMPIA>
        <OLIMPIA EV="1932" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="" EREDMENY="47" NEMZETISEG="USA"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="4X400M Relay Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="" EREDMENY="" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="" EREDMENY="3:18.54" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="" EREDMENY="03:22.62" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="" EREDMENY="3:20.20" NEMZETISEG="EUN"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="" EREDMENY="3:18.29" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="" EREDMENY="3:19.23" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="" EREDMENY="3:16.87" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="" EREDMENY="3:19.01" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="" EREDMENY="3:20.91" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="" EREDMENY="3:20.2" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="" EREDMENY="3:23.0" NEMZETISEG="GDR"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="5000M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Vivian Jepkemoi CHERUIYOT"
                       EREDMENY="14:26.17"
                       NEMZETISEG="KEN"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Tirunesh DIBABA" EREDMENY="15:41.40" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Gabriela SZABO" EREDMENY="14:40.79" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Meseret DEFAR" EREDMENY="15:04.25" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Meseret DEFAR" EREDMENY="14:45.65" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Junxia WANG" EREDMENY="14:59.88" NEMZETISEG="CHN"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="800M Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Caster SEMENYA" EREDMENY="1:55.28" NEMZETISEG="RSA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Pamela JELIMO" EREDMENY="1:54.87" NEMZETISEG="KEN"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Maria MUTOLA" EREDMENY="01:56.15" NEMZETISEG="MOZ"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Ellen VAN LANGEN" EREDMENY="1:55.54" NEMZETISEG="NED"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Doina MELINTE" EREDMENY="1:57.60" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Tatiana KAZANKINA" EREDMENY="1:54.94" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Madeline MANNING-JACKSON" EREDMENY="2:00.9" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Lyudmila SHEVTSOVA" EREDMENY="2:04.3" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Mariya SAVINOVA" EREDMENY="1:56.19" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Kelly HOLMES" EREDMENY="1:56.38" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Svetlana MASTERKOVA" EREDMENY="1:57.73" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Nadezhda OLIZARENKO" EREDMENY="1:53.5" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Hildegard FALCK" EREDMENY="1:58.55" NEMZETISEG="FRG"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Ann PACKER" EREDMENY="2:01.1" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="1928" HELYSZIN="Amsterdam">
            <VERSENYZO NEV="Karoline &#34;Lina&#34; RADKE" EREDMENY="2:16.8" NEMZETISEG="GER"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Discus Throw Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Sandra PERKOVIC" EREDMENY="69.21" NEMZETISEG="CRO"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Stephanie BROWN TRAFTON" EREDMENY="64.74" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Ellina ZVEREVA" EREDMENY="68.4" NEMZETISEG="BLR"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Maritza MARTEN" EREDMENY="70.06" NEMZETISEG="CUB"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Ria STALMAN" EREDMENY="65.36" NEMZETISEG="NED"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Lia MANOLIU" EREDMENY="58.28" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Nina ROMASHKOVA" EREDMENY="55.1" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Nina ROMASHKOVA" EREDMENY="51.42" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1936" HELYSZIN="Berlin">
            <VERSENYZO NEV="Gisela MAUERMAYER" EREDMENY="47.63" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1928" HELYSZIN="Amsterdam">
            <VERSENYZO NEV="Halina KONOPACKA" EREDMENY="39.62" NEMZETISEG="POL"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Sandra PERKOVIC" EREDMENY="69.11" NEMZETISEG="CRO"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Natalya SADOVA" EREDMENY="67.02" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Ilke WYLUDDA" EREDMENY="69.66" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Evelin SCHLAAK-JAHL" EREDMENY="69.96" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Faina MELNIK" EREDMENY="66.62" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Tamara PRESS" EREDMENY="57.27" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1948" HELYSZIN="London">
            <VERSENYZO NEV="Micheline OSTERMEYER" EREDMENY="41.92" NEMZETISEG="FRA"/>
        </OLIMPIA>
        <OLIMPIA EV="1932" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Lillian COPELAND" EREDMENY="40.58" NEMZETISEG="USA"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Hammer Throw Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Anita WLODARCZYK" EREDMENY="82.29" NEMZETISEG="POL"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Yipsi MORENO" EREDMENY="75.2" NEMZETISEG="CUB"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Kamila SKOLIMOWSKA" EREDMENY="71.16" NEMZETISEG="POL"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London"/>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Olga KUZENKOVA" EREDMENY="75.02" NEMZETISEG="RUS"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Heptathlon Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Nafissatou THIAM" EREDMENY="6810" NEMZETISEG="BEL"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Natallia DOBRYNSKA" EREDMENY="6733" NEMZETISEG="UKR"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Denise LEWIS" EREDMENY="6584" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Jackie JOYNER" EREDMENY="7044 P." NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Glynis NUNN" EREDMENY="6390" NEMZETISEG="AUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Jessica ENNIS HILL" EREDMENY="6955" NEMZETISEG="GBR"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Carolina KLUFT" EREDMENY="6952" NEMZETISEG="SWE"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Ghada SHOUAA" EREDMENY="6780" NEMZETISEG="SYR"/>
        </OLIMPIA>
        <OLIMPIA EV="1988" HELYSZIN="Seoul">
            <VERSENYZO NEV="Jackie JOYNER" EREDMENY="7291 P." NEMZETISEG="USA"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="High Jump Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Ruth BEITIA" EREDMENY="" NEMZETISEG="ESP"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Tia HELLEBAUT" EREDMENY="2.05" NEMZETISEG="BEL"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Yelena YELESINA" EREDMENY="2.01" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Heike HENKEL" EREDMENY="2.02" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Rosemarie WITSCHAS-ACKERMANN" EREDMENY="1.93" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Iolanda BALAS" EREDMENY="1.85" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Esther BRAND" EREDMENY="1.67" NEMZETISEG="RSA"/>
        </OLIMPIA>
        <OLIMPIA EV="1936" HELYSZIN="Berlin">
            <VERSENYZO NEV="Ibolya CSÃ&#x81;K" EREDMENY="1.6" NEMZETISEG="HUN"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Anna CHICHEROVA" EREDMENY="2.05" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Elena SLESARENKO" EREDMENY="2.06" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Stefka KOSTADINOVA" EREDMENY="2.05" NEMZETISEG="BUL"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Sara SIMEONI" EREDMENY="1.97" NEMZETISEG="ITA"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Iolanda BALAS" EREDMENY="1.9" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="1948" HELYSZIN="London">
            <VERSENYZO NEV="Alice COACHMAN" EREDMENY="1.68" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="1932" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Jean SHILEY" EREDMENY="1.65" NEMZETISEG="USA"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Javelin Throw Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Sara KOLAK" EREDMENY="66.18" NEMZETISEG="CRO"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Barbora SPOTAKOVA" EREDMENY="71.42" NEMZETISEG="CZE"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Trine HATTESTAD" EREDMENY="68.91" NEMZETISEG="NOR"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Silke RENK" EREDMENY="68.34" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Ruth FUCHS" EREDMENY="65.94" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Angela NEMETH" EREDMENY="60.36" NEMZETISEG="HUN"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Elvira OZOLINA" EREDMENY="55.98" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Dana INGROVA-ZATOPKOVA" EREDMENY="50.47" NEMZETISEG="TCH"/>
        </OLIMPIA>
        <OLIMPIA EV="1936" HELYSZIN="Berlin">
            <VERSENYZO NEV="Tilly FLEISCHER" EREDMENY="45.18" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Barbora SPOTAKOVA" EREDMENY="69.55" NEMZETISEG="CZE"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Osleidys MENÃ&#x89;NDEZ" EREDMENY="71.53" NEMZETISEG="CUB"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Heli RANTANEN" EREDMENY="67.94" NEMZETISEG="FIN"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Maria COLON" EREDMENY="68.4" NEMZETISEG="CUB"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Ruth FUCHS" EREDMENY="63.88" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Mihaela PENES" EREDMENY="60.54" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="1948" HELYSZIN="London">
            <VERSENYZO NEV="Herma BAUMA" EREDMENY="45.57" NEMZETISEG="AUT"/>
        </OLIMPIA>
        <OLIMPIA EV="1932" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Mildred DIDRIKSON" EREDMENY="43.68" NEMZETISEG="USA"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Long Jump Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Tianna BARTOLETTA" EREDMENY="7.17" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Maurren Higa MAGGI" EREDMENY="7.04" NEMZETISEG="BRA"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Heike DRECHSLER" EREDMENY="6.99" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Heike DRECHSLER" EREDMENY="7.14" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Angela VOIGT" EREDMENY="6.72" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Vera KOLASHNIKOVA-KREPKINA" EREDMENY="6.37" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Yvette WILLIAMS" EREDMENY="6.24" NEMZETISEG="NZL"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Brittney REESE" EREDMENY="7.12" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Tatyana LEBEDEVA" EREDMENY="7.07" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Chioma AJUNWA" EREDMENY="7.12" NEMZETISEG="NGR"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Tatiana KOLPAKOVA" EREDMENY="7.06" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Mary RAND" EREDMENY="6.76" NEMZETISEG="GBR"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Marathon Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Jemima Jelagat SUMGONG" EREDMENY="2:24:04" NEMZETISEG="KEN"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Constantina TOMESCU" EREDMENY="2h26:44" NEMZETISEG="ROU"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Naoko TAKAHASHI" EREDMENY="02h23:14" NEMZETISEG="JPN"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Valentina YEGOROVA" EREDMENY="2:32:41" NEMZETISEG="EUN"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Joan BENOIT" EREDMENY="2:24:52" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Tiki GELANA" EREDMENY="2:23:07" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Mizuki NOGUCHI" EREDMENY="2h26:20" NEMZETISEG="JPN"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Fatuma ROBA" EREDMENY="2:26:05" NEMZETISEG="ETH"/>
        </OLIMPIA>
        <OLIMPIA EV="1988" HELYSZIN="Seoul">
            <VERSENYZO NEV="Rosa MOTA" EREDMENY="2:25:40" NEMZETISEG="POR"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Pole Vault Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Ekaterini STEFANIDI" EREDMENY="4.85" NEMZETISEG="GRE"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Yelena ISINBAEVA" EREDMENY="5.05" NEMZETISEG="RUS"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Stacy DRAGILA" EREDMENY="4.6" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Jennifer SUHR" EREDMENY="4.75" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Yelena ISINBAEVA" EREDMENY="4.91" NEMZETISEG="RUS"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Shot Put Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Michelle CARTER" EREDMENY="20.63" NEMZETISEG="USA"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Valerie ADAMS" EREDMENY="20.56" NEMZETISEG="NZL"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Yanina KAROLCHIK" EREDMENY="20.56" NEMZETISEG="BLR"/>
        </OLIMPIA>
        <OLIMPIA EV="1992" HELYSZIN="Barcelona">
            <VERSENYZO NEV="Svetlana KRIVELYOVA" EREDMENY="21.06" NEMZETISEG="EUN"/>
        </OLIMPIA>
        <OLIMPIA EV="1984" HELYSZIN="Los Angeles">
            <VERSENYZO NEV="Claudia LOSCH" EREDMENY="20.48" NEMZETISEG="FRG"/>
        </OLIMPIA>
        <OLIMPIA EV="1976" HELYSZIN="Montreal">
            <VERSENYZO NEV="Ivanka KHRISTOVA" EREDMENY="21.16" NEMZETISEG="BUL"/>
        </OLIMPIA>
        <OLIMPIA EV="1968" HELYSZIN="Mexico">
            <VERSENYZO NEV="Margitta HELMBOLD-GUMMEL" EREDMENY="19.61" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1960" HELYSZIN="Rome">
            <VERSENYZO NEV="Tamara PRESS" EREDMENY="17.32" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1952" HELYSZIN="Helsinki">
            <VERSENYZO NEV="Galina ZYBINA" EREDMENY="15.28" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Valerie ADAMS" EREDMENY="20.7" NEMZETISEG="NZL"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Yumileidi CUMBA" EREDMENY="19.59" NEMZETISEG="CUB"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Astrid KUMBERNUSS" EREDMENY="20.56" NEMZETISEG="GER"/>
        </OLIMPIA>
        <OLIMPIA EV="1980" HELYSZIN="Moscow">
            <VERSENYZO NEV="Ilona SCHOKNECHT-SLUPIANEK" EREDMENY="22.41" NEMZETISEG="GDR"/>
        </OLIMPIA>
        <OLIMPIA EV="1972" HELYSZIN="Munich">
            <VERSENYZO NEV="Nadezhda CHIZHOVA" EREDMENY="21.03" NEMZETISEG="URS"/>
        </OLIMPIA>
        <OLIMPIA EV="1964" HELYSZIN="Tokyo">
            <VERSENYZO NEV="Tamara PRESS" EREDMENY="18.14" NEMZETISEG="URS"/>
        </OLIMPIA>
    </VERSENYSZAM>
    <VERSENYSZAM NEV="Triple Jump Women">
        <OLIMPIA EV="2016" HELYSZIN="Rio">
            <VERSENYZO NEV="Caterine IBARGUEN" EREDMENY="15.17" NEMZETISEG="COL"/>
        </OLIMPIA>
        <OLIMPIA EV="2008" HELYSZIN="Beijing">
            <VERSENYZO NEV="Francoise MBANGO ETONE" EREDMENY="15.39" NEMZETISEG="CMR"/>
        </OLIMPIA>
        <OLIMPIA EV="2000" HELYSZIN="Sydney">
            <VERSENYZO NEV="Tereza MARINOVA" EREDMENY="15.2" NEMZETISEG="BUL"/>
        </OLIMPIA>
        <OLIMPIA EV="2012" HELYSZIN="London">
            <VERSENYZO NEV="Olga RYPAKOVA" EREDMENY="14.98" NEMZETISEG="KAZ"/>
        </OLIMPIA>
        <OLIMPIA EV="2004" HELYSZIN="Athens">
            <VERSENYZO NEV="Francoise MBANGO ETONE" EREDMENY="15.3" NEMZETISEG="CMR"/>
        </OLIMPIA>
        <OLIMPIA EV="1996" HELYSZIN="Atlanta">
            <VERSENYZO NEV="Inessa KRAVETS" EREDMENY="15.33" NEMZETISEG="UKR"/>
        </OLIMPIA>
    </VERSENYSZAM>
</VERSENYSZAMOK>
```
**9. lekérdezés:**

A lekérdezés egy olyan XML dokumentumot állít elő, amely visszaadja, hogy Usain Bolt melyik olimpián szerepelt és milyen eredménnyel.

```xquery
xquery version "3.1";

import schema default element namespace "" at "9_feladat.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:indent "yes";
let $json := fn:json-doc("../olympic_results.json")?*,
    $result_of_games := for $game in $json?games?*
                            for $result in $game?results?*
                                return $result[?name eq "Usain BOLT"]
                                
let $data_of_games :=   for $game in $json?games?*
                            for $result in $game?results?*
                            where $result?name eq "Usain BOLT"
                            return $game    

return validate {document {
                <USAIN>
                    {
                    <ALKALOM ALL="{fn:count($result_of_games)}">
                        {
                            for $game in $data_of_games
                            return <OLIMPIA HELYSZIN="{$game?location}" EVSZAM="{$game?year}">
                            {
                                for $result in $game?results?*
                                where $result?name eq "Usain BOLT"
                                return <EREDMENY NEV="{$result?name}" EREDMENY="{$result?result}" MEDAL="{$result?medal}"/>
                            }
                            </OLIMPIA>   
                        }
                    </ALKALOM>
                    }
               </USAIN>
        }}
```
**Eredmény:**
```xml
<USAIN>
    <ALKALOM ALL="6">
        <OLIMPIA HELYSZIN="Rio" EVSZAM="2016">
            <EREDMENY NEV="Usain BOLT" EREDMENY="9.81" MEDAL="G"/>
        </OLIMPIA>
        <OLIMPIA HELYSZIN="Beijing" EVSZAM="2008">
            <EREDMENY NEV="Usain BOLT" EREDMENY="9.69" MEDAL="G"/>
        </OLIMPIA>
        <OLIMPIA HELYSZIN="London" EVSZAM="2012">
            <EREDMENY NEV="Usain BOLT" EREDMENY="9.63" MEDAL="G"/>
        </OLIMPIA>
        <OLIMPIA HELYSZIN="Rio" EVSZAM="2016">
            <EREDMENY NEV="Usain BOLT" EREDMENY="19.78" MEDAL="G"/>
        </OLIMPIA>
        <OLIMPIA HELYSZIN="Beijing" EVSZAM="2008">
            <EREDMENY NEV="Usain BOLT" EREDMENY="19.30,-0.9" MEDAL="G"/>
        </OLIMPIA>
        <OLIMPIA HELYSZIN="London" EVSZAM="2012">
            <EREDMENY NEV="Usain BOLT" EREDMENY="19.32" MEDAL="G"/>
        </OLIMPIA>
    </ALKALOM>
</USAIN>
```
**10. lekérdezés:**

Az olimpiai játékoknak legtöbbször London adott helyet. A lekérdezés egy olyan HTML dokumentumot állít elő, amely szemlélteti a londoni olimpián részt vett dobogós versenyzők adatait, év szerint csökkenő sorrendben.

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $json := fn:json-doc("../olympic_results.json")?*,
    $games := for $game in $json?games?*
            return $game[?location eq "London"]
            

return document {
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title> London </title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"/>
    </head>    
    <body style="background-color:#e6e6ff">
        <table class="table mx-auto table-striped table-hover caption-top" style="width:85%">
        	<br></br>
            <h1 style="text-align:center;font-size:300%;">London</h1>
            <thead class="thead-dark">
            	<br></br>
                <tr>
                    <th style="font-size:130%">Évszám</th>
                    <th style="font-size:130%">Név</th>
                    <th style="font-size:130%">Nemzetiség</th>
                    <th style="font-size:130%">Eredmény</th>
                    <th style="font-size:130%">Medál</th>
                </tr>
            </thead>
                <tbody>
                    {
                        for $game in $games
                        let $results := $game?results?*
                        for $result in $results
                        order by $game?year descending
                        return
                            <tr>
                                <td>{$game?year}</td>
                                <td>{$result?name}</td>
                                <td>{$result?nationality}</td>
                                <td>{$result?result}</td>
                                <td>{$result?medal}</td>
                            </tr>
                    }
                </tbody>
            </table>
        </body>
    </html>
}
```
## Képernyőmentések
Desktop:
