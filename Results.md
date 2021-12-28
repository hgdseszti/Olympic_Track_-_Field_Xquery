# Olympic_Track_and_Field_Xquery
### Olympic Track & Field Results (Kaggle) - https://www.kaggle.com/jayrav13/olympic-track-field-results


#### XQuery lekérdezések


**1. lekérdezés:**

A lekérdezés visszaadja az olimpiai játékok számát 1896 és 2016 között.

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

Kapcsolódó [XML Séma](./xml+schema/6_feladat.xsd)

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
            <PLAYERS ALL="{fn:count($versenyzok)}">
                {
                    for $versenyzo in $versenyzok
                    order by $versenyzo ascending
                    return <PLAYER NAME="{$versenyzo}"/>
                }
            </PLAYERS>
        }}
```
**Eredmény:**
```xml
<PLAYERS ALL="1681">
    <PLAYER NAME="Abdalaati IGUIDER"/>
    <PLAYER NAME="Abderrahmane HAMMAD"/>
    <PLAYER NAME="Abdesiem RHADI BEN ABDESSELEM"/>
    <PLAYER NAME="Abdon PAMICH"/>
    <PLAYER NAME="Abdoulaye SEYE"/>
    <PLAYER NAME="Abebe BIKILA"/>
    <PLAYER NAME="Abel KIRUI"/>
    <PLAYER NAME="Abel KIVIAT"/>
    <PLAYER NAME="Abel Kiprop MUTAI"/>
    <PLAYER NAME="Adalberts BUBENKO"/>
    <PLAYER NAME="Adam GUNN"/>
    <PLAYER NAME="Adam NELSON"/>
    <PLAYER NAME="Addis ABEBE"/>
    <PLAYER NAME="Adhemar DA SILVA"/>
    <PLAYER NAME="Adolfo CONSOLINI"/>
    <PLAYER NAME="Aigars FADEJEVS"/>
    <PLAYER NAME="Ainars KOVALS"/>
    <PLAYER NAME="Aki JÃ&#x84;RVINEN"/>
    <PLAYER NAME="Al BATES"/>
    <PLAYER NAME="Al OERTER"/>
    <PLAYER NAME="Alain MIMOUN"/>
    <PLAYER NAME="Alajos SZOKOLYI"/>
    <PLAYER NAME="Albert CORAY"/>
    <PLAYER NAME="Albert GUTTERSON"/>
    <PLAYER NAME="Albert HILL"/>
    <PLAYER NAME="Albert TYLER"/>
    <PLAYER NAME="Alberto COVA"/>
    <PLAYER NAME="Alberto JUANTORENA"/>
    <PLAYER NAME="Albin LERMUSIAUX"/>
    <PLAYER NAME="Albin STENROOS"/>
    <PLAYER NAME="Alejandro CASAÃ&#x91;AS"/>
    <PLAYER NAME="Aleksander TAMMERT"/>
    <PLAYER NAME="Aleksandr ANUFRIYEV"/>
    <PLAYER NAME="Aleksandr BARYSHNIKOV"/>
    <PLAYER NAME="Aleksandr MAKAROV"/>
    <PLAYER NAME="Aleksandr PUCHKOV"/>
    <PLAYER NAME="Aleksandra CHUDINA"/>
    <PLAYER NAME="Aleksei SPIRIDONOV"/>
    <PLAYER NAME="Aleksey VOYEVODIN"/>
    <PLAYER NAME="Alessandro ANDREI"/>
    <PLAYER NAME="Alessandro LAMBRUSCHINI"/>
    <PLAYER NAME="Alex SCHWAZER"/>
    <PLAYER NAME="Alex WILSON"/>
    <PLAYER NAME="Alexander KLUMBERG-KOLMPERE"/>
    <PLAYER NAME="Alexandre TUFFERI"/>
    <PLAYER NAME="Alfred Carleten GILBERT"/>
    <PLAYER NAME="Alfred DOMPERT"/>
    <PLAYER NAME="Alfred Kirwa YEGO"/>
    <PLAYER NAME="Alfred TYSOE"/>
    <PLAYER NAME="Ali EZZINE"/>
    <PLAYER NAME="Ali SAIDI-SIEF"/>
    <PLAYER NAME="Alice BROWN"/>
    <PLAYER NAME="Alice COACHMAN"/>
    <PLAYER NAME="Allan LAWRENCE"/>
    <PLAYER NAME="Allan WELLS"/>
    <PLAYER NAME="Allen JOHNSON"/>
    <PLAYER NAME="Allen WOODRING"/>
    <PLAYER NAME="Allyson FELIX"/>
    <PLAYER NAME="Alma RICHARDS"/>
    <PLAYER NAME="Almaz AYANA"/>
    <PLAYER NAME="Alonzo BABERS"/>
    <PLAYER NAME="Alvah MEYER"/>
    <PLAYER NAME="Alvin HARRISON"/>
    <PLAYER NAME="Alvin KRAENZLEIN"/>
    <PLAYER NAME="Amos BIWOTT"/>
    <PLAYER NAME="Ana Fidelia QUIROT"/>
    <PLAYER NAME="Ana GUEVARA"/>
    <PLAYER NAME="Anastasia KELESIDOU"/>
    <PLAYER NAME="Anatoli BONDARCHUK"/>
    <PLAYER NAME="Anatoly MIKHAYLOV"/>
    <PLAYER NAME="Anders GARDERUD"/>
    <PLAYER NAME="Andre DE GRASSE"/>
    <PLAYER NAME="Andreas THORKILDSEN"/>
    <PLAYER NAME="Andrei KRAUCHANKA"/>
    <PLAYER NAME="Andrei TIVONTCHIK"/>
    <PLAYER NAME="Andrey ABDUVALIEV"/>
    <PLAYER NAME="Andrey PERLOV"/>
    <PLAYER NAME="Andrey SILNOV"/>
    <PLAYER NAME="Andrzej BADENSKI"/>
    <PLAYER NAME="Andy STANFIELD"/>
    <PLAYER NAME="Angela NEMETH"/>
    <PLAYER NAME="Angela VOIGT"/>
    <PLAYER NAME="Angelo TAYLOR"/>
    <PLAYER NAME="Anier GARCIA"/>
    <PLAYER NAME="Anita MARTON"/>
    <PLAYER NAME="Anita WLODARCZYK"/>
    <PLAYER NAME="Anke BEHMER"/>
    <PLAYER NAME="Ann Marise CHAMBERLAIN"/>
    <PLAYER NAME="Ann PACKER"/>
    <PLAYER NAME="Anna CHICHEROVA"/>
    <PLAYER NAME="Anna ROGOWSKA"/>
    <PLAYER NAME="Annegret RICHTER-IRRGANG"/>
    <PLAYER NAME="Annelie EHRHARDT"/>
    <PLAYER NAME="Antal KISS"/>
    <PLAYER NAME="Antal RÃ&#x93;KA"/>
    <PLAYER NAME="Antanas MIKENAS"/>
    <PLAYER NAME="Antonio MCKAY"/>
    <PLAYER NAME="Antonio PENALVER ASENSIO"/>
    <PLAYER NAME="Antti RUUSKANEN"/>
    <PLAYER NAME="AntÃ³nio LEITÃ&#x83;O"/>
    <PLAYER NAME="Archibald Franklin WILLIAMS"/>
    <PLAYER NAME="Archie HAHN"/>
    <PLAYER NAME="Ardalion IGNATYEV"/>
    <PLAYER NAME="Argentina MENIS"/>
    <PLAYER NAME="Aries MERRITT"/>
    <PLAYER NAME="Armas TAIPALE"/>
    <PLAYER NAME="Armas TOIVONEN"/>
    <PLAYER NAME="Armin HARY"/>
    <PLAYER NAME="Arne HALSE"/>
    <PLAYER NAME="Arnie ROBINSON"/>
    <PLAYER NAME="Arnold JACKSON"/>
    <PLAYER NAME="Arnoldo DEVONISH"/>
    <PLAYER NAME="Arsi HARJU"/>
    <PLAYER NAME="Arthur BARNARD"/>
    <PLAYER NAME="Arthur BLAKE"/>
    <PLAYER NAME="Arthur JONATH"/>
    <PLAYER NAME="Arthur NEWTON"/>
    <PLAYER NAME="Arthur PORRITT"/>
    <PLAYER NAME="Arthur SCHWAB"/>
    <PLAYER NAME="Arthur SHAW"/>
    <PLAYER NAME="Arthur WINT"/>
    <PLAYER NAME="Arto BRYGGARE"/>
    <PLAYER NAME="Arto HÃ&#x84;RKÃ&#x96;NEN"/>
    <PLAYER NAME="Artur PARTYKA"/>
    <PLAYER NAME="Arvo ASKOLA"/>
    <PLAYER NAME="Asbel Kipruto KIPROP"/>
    <PLAYER NAME="Ashley SPENCER"/>
    <PLAYER NAME="Ashton EATON"/>
    <PLAYER NAME="Assefa MEZGEBU"/>
    <PLAYER NAME="Astrid KUMBERNUSS"/>
    <PLAYER NAME="Athanasia TSOUMELEKA"/>
    <PLAYER NAME="Ato BOLDON"/>
    <PLAYER NAME="Audrey PATTERSON"/>
    <PLAYER NAME="Audrey WILLIAMSON"/>
    <PLAYER NAME="Audun BOYSEN"/>
    <PLAYER NAME="August DESCH"/>
    <PLAYER NAME="Austra SKUJYTE"/>
    <PLAYER NAME="BalÃ¡zs KISS"/>
    <PLAYER NAME="Barbara FERRELL"/>
    <PLAYER NAME="Barbora SPOTAKOVA"/>
    <PLAYER NAME="Barney EWELL"/>
    <PLAYER NAME="Barry MAGEE"/>
    <PLAYER NAME="Basil HEATLEY"/>
    <PLAYER NAME="Ben JIPCHO"/>
    <PLAYER NAME="Ben JOHNSON"/>
    <PLAYER NAME="Benita FITZGERALD-BROWN"/>
    <PLAYER NAME="Benjamin Bangs EASTMAN"/>
    <PLAYER NAME="Benjamin KOGO"/>
    <PLAYER NAME="Bernard LAGAT"/>
    <PLAYER NAME="Bernard WILLIAMS III"/>
    <PLAYER NAME="Bernardo SEGURA"/>
    <PLAYER NAME="Bernd KANNENBERG"/>
    <PLAYER NAME="Bershawn JACKSON"/>
    <PLAYER NAME="Bertha BROUWER"/>
    <PLAYER NAME="Bertil ALBERTSSON"/>
    <PLAYER NAME="Bertil OHLSON"/>
    <PLAYER NAME="Bertil UGGLA"/>
    <PLAYER NAME="Betty CUTHBERT"/>
    <PLAYER NAME="Betty HEIDLER"/>
    <PLAYER NAME="Beverly MCDONALD"/>
    <PLAYER NAME="Bevil RUDD"/>
    <PLAYER NAME="Bill DELLINGER"/>
    <PLAYER NAME="Bill PORTER"/>
    <PLAYER NAME="Bill TOOMEY"/>
    <PLAYER NAME="Billy MILLS"/>
    <PLAYER NAME="Bin DONG"/>
    <PLAYER NAME="Birute KALEDIENE"/>
    <PLAYER NAME="Bjorn OTTO"/>
    <PLAYER NAME="Blaine LINDGREN"/>
    <PLAYER NAME="Blanka VLASIC"/>
    <PLAYER NAME="Blessing OKAGBARE"/>
    <PLAYER NAME="Bo GUSTAFSSON"/>
    <PLAYER NAME="Bob HAYES"/>
    <PLAYER NAME="Bob MATHIAS"/>
    <PLAYER NAME="Bob RICHARDS"/>
    <PLAYER NAME="Bobby MORROW"/>
    <PLAYER NAME="Bodo TÃ&#x9c;MMLER"/>
    <PLAYER NAME="Bohdan BONDARENKO"/>
    <PLAYER NAME="Bong Ju LEE"/>
    <PLAYER NAME="Boniface MUCHERU"/>
    <PLAYER NAME="BoughÃ¨ra EL OUAFI"/>
    <PLAYER NAME="Brahim LAHLAFI"/>
    <PLAYER NAME="Brenda JONES"/>
    <PLAYER NAME="Brendan FOSTER"/>
    <PLAYER NAME="Brian Lee DIEMER"/>
    <PLAYER NAME="Brianna ROLLINS"/>
    <PLAYER NAME="Brianne THEISEN EATON"/>
    <PLAYER NAME="Brigetta BARRETT"/>
    <PLAYER NAME="Brigita BUKOVEC"/>
    <PLAYER NAME="Brigitte WUJAK"/>
    <PLAYER NAME="Brimin Kiprop KIPRUTO"/>
    <PLAYER NAME="Brittney REESE"/>
    <PLAYER NAME="Bronislaw MALINOWSKI"/>
    <PLAYER NAME="Bruce JENNER"/>
    <PLAYER NAME="Bruno JUNK"/>
    <PLAYER NAME="Bruno SÃ&#x96;DERSTRÃ&#x96;M"/>
    <PLAYER NAME="Brutus HAMILTON"/>
    <PLAYER NAME="Bryan CLAY"/>
    <PLAYER NAME="Bud HOUSER"/>
    <PLAYER NAME="BÃ¤rbel ECKERT-WÃ&#x96;CKEL"/>
    <PLAYER NAME="Calvin BRICKER"/>
    <PLAYER NAME="Calvin DAVIS"/>
    <PLAYER NAME="Carl Albert ANDERSEN"/>
    <PLAYER NAME="Carl KAUFMANN"/>
    <PLAYER NAME="Carl LEWIS"/>
    <PLAYER NAME="Carlos LOPES"/>
    <PLAYER NAME="Carlos MERCENARIO"/>
    <PLAYER NAME="Carmelita JETER"/>
    <PLAYER NAME="Carolina KLUFT"/>
    <PLAYER NAME="Caster SEMENYA"/>
    <PLAYER NAME="Caterine IBARGUEN"/>
    <PLAYER NAME="Catherine Laverne MCMILLAN"/>
    <PLAYER NAME="Catherine NDEREBA"/>
    <PLAYER NAME="Cathy FREEMAN"/>
    <PLAYER NAME="Chandra CHEESEBOROUGH"/>
    <PLAYER NAME="Charles AUSTIN"/>
    <PLAYER NAME="Charles BACON"/>
    <PLAYER NAME="Charles BENNETT"/>
    <PLAYER NAME="Charles DVORAK"/>
    <PLAYER NAME="Charles GMELIN"/>
    <PLAYER NAME="Charles HEFFERON"/>
    <PLAYER NAME="Charles Hewes Jr. MOORE"/>
    <PLAYER NAME="Charles JACOBS"/>
    <PLAYER NAME="Charles JENKINS"/>
    <PLAYER NAME="Charles LOMBERG"/>
    <PLAYER NAME="Charles PADDOCK"/>
    <PLAYER NAME="Charles REIDPATH"/>
    <PLAYER NAME="Charles SIMPKINS"/>
    <PLAYER NAME="Charles SPEDDING"/>
    <PLAYER NAME="Charlie GREENE"/>
    <PLAYER NAME="Chioma AJUNWA"/>
    <PLAYER NAME="Chris HUFFINS"/>
    <PLAYER NAME="Christa STUBNICK"/>
    <PLAYER NAME="Christian CANTWELL"/>
    <PLAYER NAME="Christian OLSSON"/>
    <PLAYER NAME="Christian SCHENK"/>
    <PLAYER NAME="Christian TAYLOR"/>
    <PLAYER NAME="Christian W. GITSHAM"/>
    <PLAYER NAME="Christiane STOLL-WARTENBERG"/>
    <PLAYER NAME="Christina BREHMER-LATHAN"/>
    <PLAYER NAME="Christina OBERGFOLL"/>
    <PLAYER NAME="Christine OHURUOGU"/>
    <PLAYER NAME="Christoph HARTING"/>
    <PLAYER NAME="Christoph HÃ&#x96;HNE"/>
    <PLAYER NAME="Christophe LEMAITRE"/>
    <PLAYER NAME="Christopher William BRASHER"/>
    <PLAYER NAME="Chuan-Kwang YANG"/>
    <PLAYER NAME="Chuhei NAMBU"/>
    <PLAYER NAME="Chunxiu ZHOU"/>
    <PLAYER NAME="Clarence CHILDS"/>
    <PLAYER NAME="Clarence DEMAR"/>
    <PLAYER NAME="Claudia LOSCH"/>
    <PLAYER NAME="Clayton MURPHY"/>
    <PLAYER NAME="Clifton Emmett CUSHMAN"/>
    <PLAYER NAME="Clyde SCOTT"/>
    <PLAYER NAME="Colette BESSON"/>
    <PLAYER NAME="Conseslus KIPRUTO"/>
    <PLAYER NAME="Constantina TOMESCU"/>
    <PLAYER NAME="Cornelius LEAHY"/>
    <PLAYER NAME="Cornelius WALSH"/>
    <PLAYER NAME="Craig DIXON"/>
    <PLAYER NAME="Cristina COJOCARU"/>
    <PLAYER NAME="Cy YOUNG"/>
    <PLAYER NAME="Dafne SCHIPPERS"/>
    <PLAYER NAME="Dainis KULA"/>
    <PLAYER NAME="Daley THOMPSON"/>
    <PLAYER NAME="Dalilah MUHAMMAD"/>
    <PLAYER NAME="Dallas LONG"/>
    <PLAYER NAME="Damian WARNER"/>
    <PLAYER NAME="Dan O'BRIEN"/>
    <PLAYER NAME="Dana INGROVA-ZATOPKOVA"/>
    <PLAYER NAME="Dane BIRD-SMITH"/>
    <PLAYER NAME="Daniel BAUTISTA ROCHA"/>
    <PLAYER NAME="Daniel FRANK"/>
    <PLAYER NAME="Daniel JASINSKI"/>
    <PLAYER NAME="Daniel KELLY"/>
    <PLAYER NAME="Daniel KINSEY"/>
    <PLAYER NAME="Daniel PLAZA"/>
    <PLAYER NAME="Daniela COSTIAN"/>
    <PLAYER NAME="Daniil Sergeyevich BURKENYA"/>
    <PLAYER NAME="Danny HARRIS"/>
    <PLAYER NAME="Danny MCFARLANE"/>
    <PLAYER NAME="Daphne HASENJAGER"/>
    <PLAYER NAME="Darren CAMPBELL"/>
    <PLAYER NAME="Darrow Clarence HOOPER"/>
    <PLAYER NAME="Dave JOHNSON"/>
    <PLAYER NAME="Dave LAUT"/>
    <PLAYER NAME="Dave SIME"/>
    <PLAYER NAME="Dave STEEN"/>
    <PLAYER NAME="David George BURGHLEY"/>
    <PLAYER NAME="David HALL"/>
    <PLAYER NAME="David HEMERY"/>
    <PLAYER NAME="David James WOTTLE"/>
    <PLAYER NAME="David Lawson WEILL"/>
    <PLAYER NAME="David Lekuta RUDISHA"/>
    <PLAYER NAME="David NEVILLE"/>
    <PLAYER NAME="David OLIVER"/>
    <PLAYER NAME="David OTTLEY"/>
    <PLAYER NAME="David PAYNE"/>
    <PLAYER NAME="David POWER"/>
    <PLAYER NAME="David STORL"/>
    <PLAYER NAME="Davis KAMOGA"/>
    <PLAYER NAME="Dawn HARPER"/>
    <PLAYER NAME="Dayron ROBLES"/>
    <PLAYER NAME="Debbie FERGUSON-MCKENZIE"/>
    <PLAYER NAME="DeeDee TROTTER"/>
    <PLAYER NAME="Deena KASTOR"/>
    <PLAYER NAME="Dejen GEBREMESKEL"/>
    <PLAYER NAME="Delfo CABRERA"/>
    <PLAYER NAME="Denia CABALLERO"/>
    <PLAYER NAME="Denis HORGAN"/>
    <PLAYER NAME="Denis KAPUSTIN"/>
    <PLAYER NAME="Denis NIZHEGORODOV"/>
    <PLAYER NAME="Denise LEWIS"/>
    <PLAYER NAME="Dennis MITCHELL"/>
    <PLAYER NAME="Deon Marie HEMMINGS"/>
    <PLAYER NAME="Derartu TULU"/>
    <PLAYER NAME="Derek DROUIN"/>
    <PLAYER NAME="Derek IBBOTSON"/>
    <PLAYER NAME="Derek JOHNSON"/>
    <PLAYER NAME="Derrick ADKINS"/>
    <PLAYER NAME="Derrick BREW"/>
    <PLAYER NAME="Dick Theodorus QUAX"/>
    <PLAYER NAME="Dieter BAUMANN"/>
    <PLAYER NAME="Dieter LINDNER"/>
    <PLAYER NAME="Dilshod NAZAROV"/>
    <PLAYER NAME="Dimitri BASCOU"/>
    <PLAYER NAME="Dimitrios GOLEMIS"/>
    <PLAYER NAME="Ding CHEN"/>
    <PLAYER NAME="Djabir SAID GUERNI"/>
    <PLAYER NAME="Dmitriy KARPOV"/>
    <PLAYER NAME="Doina MELINTE"/>
    <PLAYER NAME="Don BRAGG"/>
    <PLAYER NAME="Don LAZ"/>
    <PLAYER NAME="Donald FINLAY"/>
    <PLAYER NAME="Donald James THOMPSON"/>
    <PLAYER NAME="Donald LIPPINCOTT"/>
    <PLAYER NAME="Donald QUARRIE"/>
    <PLAYER NAME="Donovan BAILEY"/>
    <PLAYER NAME="Dorothy HALL"/>
    <PLAYER NAME="Dorothy HYMAN"/>
    <PLAYER NAME="Dorothy ODAM"/>
    <PLAYER NAME="Dorothy SHIRLEY"/>
    <PLAYER NAME="Douglas LOWE"/>
    <PLAYER NAME="Douglas WAKIIHURI"/>
    <PLAYER NAME="Duncan GILLIS"/>
    <PLAYER NAME="Duncan MCNAUGHTON"/>
    <PLAYER NAME="Duncan WHITE"/>
    <PLAYER NAME="Dwayne Eugene EVANS"/>
    <PLAYER NAME="Dwight PHILLIPS"/>
    <PLAYER NAME="Dwight STONES"/>
    <PLAYER NAME="Dylan ARMSTRONG"/>
    <PLAYER NAME="Earl EBY"/>
    <PLAYER NAME="Earl JONES"/>
    <PLAYER NAME="Earl THOMSON"/>
    <PLAYER NAME="Earlene BROWN"/>
    <PLAYER NAME="Eddie SOUTHERN"/>
    <PLAYER NAME="Eddie TOLAN"/>
    <PLAYER NAME="Eddy OTTOZ"/>
    <PLAYER NAME="Edera CORDIALE-GENTILE"/>
    <PLAYER NAME="Edith MCGUIRE"/>
    <PLAYER NAME="Edvard LARSEN"/>
    <PLAYER NAME="Edvin WIDE"/>
    <PLAYER NAME="Edward ARCHIBALD"/>
    <PLAYER NAME="Edward Barton HAMM"/>
    <PLAYER NAME="Edward COOK"/>
    <PLAYER NAME="Edward LINDBERG"/>
    <PLAYER NAME="Edward Lansing GORDON"/>
    <PLAYER NAME="Edward Orval GOURDIN"/>
    <PLAYER NAME="Edwin Cheruiyot SOI"/>
    <PLAYER NAME="Edwin FLACK"/>
    <PLAYER NAME="Edwin MOSES"/>
    <PLAYER NAME="Edwin ROBERTS"/>
    <PLAYER NAME="Eeles LANDSTRÃ&#x96;M"/>
    <PLAYER NAME="Eero BERG"/>
    <PLAYER NAME="Ehsan HADADI"/>
    <PLAYER NAME="Eino PENTTILÃ&#x84;"/>
    <PLAYER NAME="Eino PURJE"/>
    <PLAYER NAME="Ejegayehu DIBABA"/>
    <PLAYER NAME="Ekaterina POISTOGOVA"/>
    <PLAYER NAME="Ekaterini STEFANIDI"/>
    <PLAYER NAME="Ekaterini THANOU"/>
    <PLAYER NAME="Elaine THOMPSON"/>
    <PLAYER NAME="Elana MEYER"/>
    <PLAYER NAME="Elena LASHMANOVA"/>
    <PLAYER NAME="Elena SLESARENKO"/>
    <PLAYER NAME="Elena SOKOLOVA"/>
    <PLAYER NAME="Elfi ZINN"/>
    <PLAYER NAME="Elfriede KAUN"/>
    <PLAYER NAME="Elias KATZ"/>
    <PLAYER NAME="Elisa RIGAUDO"/>
    <PLAYER NAME="Eliud Kipchoge ROTICH"/>
    <PLAYER NAME="Eliza MCCARTNEY"/>
    <PLAYER NAME="Elizabeth ROBINSON"/>
    <PLAYER NAME="Ellen BRAUMÃ&#x9c;LLER"/>
    <PLAYER NAME="Ellen STROPAHL-STREIDT"/>
    <PLAYER NAME="Ellen VAN LANGEN"/>
    <PLAYER NAME="Ellery CLARK"/>
    <PLAYER NAME="Ellina ZVEREVA"/>
    <PLAYER NAME="Elvan ABEYLEGESSE"/>
    <PLAYER NAME="Elvira OZOLINA"/>
    <PLAYER NAME="Elzbieta KRZESINSKA"/>
    <PLAYER NAME="Emerson NORTON"/>
    <PLAYER NAME="Emiel PUTTEMANS"/>
    <PLAYER NAME="Emil BREITKREUTZ"/>
    <PLAYER NAME="Emil ZÃ&#x81;TOPEK"/>
    <PLAYER NAME="Emilio LUNGHI"/>
    <PLAYER NAME="Emma COBURN"/>
    <PLAYER NAME="Emmanuel McDONALD BAILEY"/>
    <PLAYER NAME="Enrique FIGUEROLA"/>
    <PLAYER NAME="Eric BACKMAN"/>
    <PLAYER NAME="Eric LEMMING"/>
    <PLAYER NAME="Eric LIDDELL"/>
    <PLAYER NAME="Eric SVENSSON"/>
    <PLAYER NAME="Erick BARRONDO"/>
    <PLAYER NAME="Erick WAINAINA"/>
    <PLAYER NAME="Erik ALMLÃ&#x96;F"/>
    <PLAYER NAME="Erik BYLÃ&#x89;HN"/>
    <PLAYER NAME="Erik KYNARD"/>
    <PLAYER NAME="Erki NOOL"/>
    <PLAYER NAME="Erkka WILEN"/>
    <PLAYER NAME="Ernest HARPER"/>
    <PLAYER NAME="Ernesto AMBROSINI"/>
    <PLAYER NAME="Ernesto CANTO"/>
    <PLAYER NAME="Ernst FAST"/>
    <PLAYER NAME="Ernst LARSEN"/>
    <PLAYER NAME="Ernst SCHULTZ"/>
    <PLAYER NAME="Ervin HALL"/>
    <PLAYER NAME="Esfira DOLCHENKO-KRACHEVSKAYA"/>
    <PLAYER NAME="Eshetu TURA"/>
    <PLAYER NAME="Esref APAK"/>
    <PLAYER NAME="Esther BRAND"/>
    <PLAYER NAME="Ethel SMITH"/>
    <PLAYER NAME="Etienne GAILLY"/>
    <PLAYER NAME="Eugene OBERST"/>
    <PLAYER NAME="Eunice JEPKORIR"/>
    <PLAYER NAME="Eunice Jepkirui KIRWA"/>
    <PLAYER NAME="Eva DAWES"/>
    <PLAYER NAME="Eva JANKO-EGGER"/>
    <PLAYER NAME="Evan JAGER"/>
    <PLAYER NAME="Evangelos DAMASKOS"/>
    <PLAYER NAME="Evelin SCHLAAK-JAHL"/>
    <PLAYER NAME="Evelyn ASHFORD"/>
    <PLAYER NAME="Evgeniy LUKYANENKO"/>
    <PLAYER NAME="Ewa KLOBUKOWSKA"/>
    <PLAYER NAME="Ezekiel KEMBOI"/>
    <PLAYER NAME="Fabrizio DONATO"/>
    <PLAYER NAME="Faina MELNIK"/>
    <PLAYER NAME="Faith Chepngetich KIPYEGON"/>
    <PLAYER NAME="Falilat OGUNKOYA"/>
    <PLAYER NAME="Fani KHALKIA"/>
    <PLAYER NAME="Fanny BLANKERS-KOEN"/>
    <PLAYER NAME="Fanny ROSENFELD"/>
    <PLAYER NAME="Fatuma ROBA"/>
    <PLAYER NAME="Felix SANCHEZ"/>
    <PLAYER NAME="Fermin CACHO RUIZ"/>
    <PLAYER NAME="Fernanda RIBEIRO"/>
    <PLAYER NAME="Feyisa LILESA"/>
    <PLAYER NAME="Filbert BAYI"/>
    <PLAYER NAME="Fiona MAY"/>
    <PLAYER NAME="Fita BAYISSA"/>
    <PLAYER NAME="Fita LOVIN"/>
    <PLAYER NAME="Florence GRIFFITH JOYNER"/>
    <PLAYER NAME="Florenta CRACIUNESCU"/>
    <PLAYER NAME="Florian SCHWARTHOFF"/>
    <PLAYER NAME="Floyd SIMMONS"/>
    <PLAYER NAME="Forrest SMITHSON"/>
    <PLAYER NAME="Forrest TOWNS"/>
    <PLAYER NAME="Francine NIYONSABA"/>
    <PLAYER NAME="Francis LANE"/>
    <PLAYER NAME="Francis OBIKWELU"/>
    <PLAYER NAME="Francisco Javier FERNANDEZ"/>
    <PLAYER NAME="Francoise MBANGO ETONE"/>
    <PLAYER NAME="Franjo MIHALIC"/>
    <PLAYER NAME="Frank BAUMGARTL"/>
    <PLAYER NAME="Frank BUSEMANN"/>
    <PLAYER NAME="Frank CUHEL"/>
    <PLAYER NAME="Frank Charles SHORTER"/>
    <PLAYER NAME="Frank FREDERICKS"/>
    <PLAYER NAME="Frank IRONS"/>
    <PLAYER NAME="Frank JARVIS"/>
    <PLAYER NAME="Frank LOOMIS"/>
    <PLAYER NAME="Frank MURPHY"/>
    <PLAYER NAME="Frank NELSON"/>
    <PLAYER NAME="Frank PASCHEK"/>
    <PLAYER NAME="Frank RUTHERFORD"/>
    <PLAYER NAME="Frank SCHAFFER"/>
    <PLAYER NAME="Frank WALLER"/>
    <PLAYER NAME="Frank WARTENBERG"/>
    <PLAYER NAME="Franti?ek DOUDA"/>
    <PLAYER NAME="Frantz KRUGER"/>
    <PLAYER NAME="Fred ENGELHARDT"/>
    <PLAYER NAME="Fred HANSEN"/>
    <PLAYER NAME="Fred ONYANCHA"/>
    <PLAYER NAME="Fred TOOTELL"/>
    <PLAYER NAME="Frederick KELLY"/>
    <PLAYER NAME="Frederick MOLONEY"/>
    <PLAYER NAME="Frederick MURRAY"/>
    <PLAYER NAME="Frederick SCHULE"/>
    <PLAYER NAME="Frederick Vaughn NEWHOUSE"/>
    <PLAYER NAME="Fritz Erik ELMSÃ&#x83;?TER"/>
    <PLAYER NAME="Fritz HOFMANN"/>
    <PLAYER NAME="Fritz POLLARD"/>
    <PLAYER NAME="Gabriel TIACOH"/>
    <PLAYER NAME="Gabriela SZABO"/>
    <PLAYER NAME="Gabriella DORIO"/>
    <PLAYER NAME="Gael MARTIN"/>
    <PLAYER NAME="Gail DEVERS"/>
    <PLAYER NAME="Galen RUPP"/>
    <PLAYER NAME="Galina ASTAFEI"/>
    <PLAYER NAME="Galina ZYBINA"/>
    <PLAYER NAME="Gamze BULUT"/>
    <PLAYER NAME="Garfield MACDONALD"/>
    <PLAYER NAME="Garrett SERVISS"/>
    <PLAYER NAME="Gary OAKES"/>
    <PLAYER NAME="Gaston GODEL"/>
    <PLAYER NAME="Gaston REIFF"/>
    <PLAYER NAME="Gaston ROELANTS"/>
    <PLAYER NAME="Gaston STROBINO"/>
    <PLAYER NAME="Gelindo BORDIN"/>
    <PLAYER NAME="Genzebe DIBABA"/>
    <PLAYER NAME="Georg ABERG"/>
    <PLAYER NAME="Georg LAMMERS"/>
    <PLAYER NAME="George HORINE"/>
    <PLAYER NAME="George HUTSON"/>
    <PLAYER NAME="George JEFFERSON"/>
    <PLAYER NAME="George KERR"/>
    <PLAYER NAME="George ORTON"/>
    <PLAYER NAME="George POAGE"/>
    <PLAYER NAME="George RHODEN"/>
    <PLAYER NAME="George SALING"/>
    <PLAYER NAME="George SIMPSON"/>
    <PLAYER NAME="George YOUNG"/>
    <PLAYER NAME="Georges ANDRE"/>
    <PLAYER NAME="Georgios PAPASIDERIS"/>
    <PLAYER NAME="Gerard NIJBOER"/>
    <PLAYER NAME="Gerd KANTER"/>
    <PLAYER NAME="Gerd WESSIG"/>
    <PLAYER NAME="Gergely KULCSÃ&#x81;R"/>
    <PLAYER NAME="Gerhard HENNIGE"/>
    <PLAYER NAME="Gerhard STÃ&#x96;CK"/>
    <PLAYER NAME="Germaine MASON"/>
    <PLAYER NAME="Gete WAMI"/>
    <PLAYER NAME="Gezahegne ABERA"/>
    <PLAYER NAME="Ghada SHOUAA"/>
    <PLAYER NAME="Gheorghe MEGELEA"/>
    <PLAYER NAME="Giovanni DE BENEDICTIS"/>
    <PLAYER NAME="Gisela MAUERMAYER"/>
    <PLAYER NAME="Giuseppe DORDONI"/>
    <PLAYER NAME="Giuseppe GIBILISCO"/>
    <PLAYER NAME="Giuseppina LEONE"/>
    <PLAYER NAME="Glenn CUNNINGHAM"/>
    <PLAYER NAME="Glenn DAVIS"/>
    <PLAYER NAME="Glenn GRAHAM"/>
    <PLAYER NAME="Glenn HARDIN"/>
    <PLAYER NAME="Glenn HARTRANFT"/>
    <PLAYER NAME="Glenn MORRIS"/>
    <PLAYER NAME="Gloria ALOZIE"/>
    <PLAYER NAME="Glynis NUNN"/>
    <PLAYER NAME="Godfrey BROWN"/>
    <PLAYER NAME="Godfrey Khotso MOKOENA"/>
    <PLAYER NAME="Gordon PIRIE"/>
    <PLAYER NAME="Gote Ernst HAGSTROM"/>
    <PLAYER NAME="Grantley GOULDING"/>
    <PLAYER NAME="Greg FOSTER"/>
    <PLAYER NAME="Greg HAUGHTON"/>
    <PLAYER NAME="Greg JOY"/>
    <PLAYER NAME="Greg RUTHERFORD"/>
    <PLAYER NAME="Grete ANDERSEN"/>
    <PLAYER NAME="Guido KRATSCHMER"/>
    <PLAYER NAME="Guillaume LEBLANC"/>
    <PLAYER NAME="Gulnara SAMITOVA"/>
    <PLAYER NAME="Gunhild HOFFMEISTER"/>
    <PLAYER NAME="Gunnar HÃ&#x96;CKERT"/>
    <PLAYER NAME="Gunnar LINDSTRÃ&#x96;M"/>
    <PLAYER NAME="Gustaf JANSSON"/>
    <PLAYER NAME="Gustav LINDBLOM"/>
    <PLAYER NAME="Guy BUTLER"/>
    <PLAYER NAME="Guy DRUT"/>
    <PLAYER NAME="Gwen TORRENCE"/>
    <PLAYER NAME="Gyula KELLNER"/>
    <PLAYER NAME="Gyula ZSIVÃ&#x93;TZKY"/>
    <PLAYER NAME="GÃ¶sta HOLMER"/>
    <PLAYER NAME="Habiba GHRIBI"/>
    <PLAYER NAME="Hadi Soua An AL SOMAILY"/>
    <PLAYER NAME="Hagos GEBRHIWET"/>
    <PLAYER NAME="Haile GEBRSELASSIE"/>
    <PLAYER NAME="Halina KONOPACKA"/>
    <PLAYER NAME="Hannes KOLEHMAINEN"/>
    <PLAYER NAME="Hanns BRAUN"/>
    <PLAYER NAME="Hannu Juhani SIITONEN"/>
    <PLAYER NAME="Hans GRODOTZKI"/>
    <PLAYER NAME="Hans LIESCHE"/>
    <PLAYER NAME="Hans REIMANN"/>
    <PLAYER NAME="Hans WOELLKE"/>
    <PLAYER NAME="Hans-Joachim WALDE"/>
    <PLAYER NAME="Hansle PARCHMENT"/>
    <PLAYER NAME="Harald NORPOTH"/>
    <PLAYER NAME="Harald SCHMID"/>
    <PLAYER NAME="Harlow ROTHERT"/>
    <PLAYER NAME="Harold ABRAHAMS"/>
    <PLAYER NAME="Harold BARRON"/>
    <PLAYER NAME="Harold OSBORN"/>
    <PLAYER NAME="Harold WHITLOCK"/>
    <PLAYER NAME="Harold WILSON"/>
    <PLAYER NAME="Harri LARVA"/>
    <PLAYER NAME="Harrison DILLARD"/>
    <PLAYER NAME="Harry EDWARD"/>
    <PLAYER NAME="Harry HILLMAN"/>
    <PLAYER NAME="Harry JEROME"/>
    <PLAYER NAME="Harry PORTER"/>
    <PLAYER NAME="Harry Stoddard BABCOCK"/>
    <PLAYER NAME="Hartwig GAUDER"/>
    <PLAYER NAME="Hasely CRAWFORD"/>
    <PLAYER NAME="Hasna BENHASSI"/>
    <PLAYER NAME="Hassiba BOULMERKA"/>
    <PLAYER NAME="Hayes JONES"/>
    <PLAYER NAME="Hector HOGAN"/>
    <PLAYER NAME="Heike DRECHSLER"/>
    <PLAYER NAME="Heike HENKEL"/>
    <PLAYER NAME="Heinz ULZHEIMER"/>
    <PLAYER NAME="Helen STEPHENS"/>
    <PLAYER NAME="Helena FIBINGEROVÃ&#x81;"/>
    <PLAYER NAME="Helge LÃ&#x96;VLAND"/>
    <PLAYER NAME="Heli RANTANEN"/>
    <PLAYER NAME="Hellen Onsando OBIRI"/>
    <PLAYER NAME="Helmut KÃ&#x96;RNIG"/>
    <PLAYER NAME="Henri DELOGE"/>
    <PLAYER NAME="Henri LABORDE"/>
    <PLAYER NAME="Henri TAUZIN"/>
    <PLAYER NAME="Henry CARR"/>
    <PLAYER NAME="Henry ERIKSSON"/>
    <PLAYER NAME="Henry JONSSON-KÃ&#x84;LARNE"/>
    <PLAYER NAME="Henry STALLARD"/>
    <PLAYER NAME="Herb ELLIOTT"/>
    <PLAYER NAME="Herbert JAMISON"/>
    <PLAYER NAME="Herbert MCKENLEY"/>
    <PLAYER NAME="Herbert SCHADE"/>
    <PLAYER NAME="Herma BAUMA"/>
    <PLAYER NAME="Herman GROMAN"/>
    <PLAYER NAME="Herman Ronald FRAZIER"/>
    <PLAYER NAME="Hermann ENGELHARD"/>
    <PLAYER NAME="Hestrie CLOETE"/>
    <PLAYER NAME="Hezekiel SEPENG"/>
    <PLAYER NAME="Hicham EL GUERROUJ"/>
    <PLAYER NAME="Hilda STRIKE"/>
    <PLAYER NAME="Hildegard FALCK"/>
    <PLAYER NAME="Hildrun CLAUS"/>
    <PLAYER NAME="Hirooki ARAI"/>
    <PLAYER NAME="Hollis CONWAY"/>
    <PLAYER NAME="Hong LIU"/>
    <PLAYER NAME="Horace ASHENFELTER"/>
    <PLAYER NAME="Horatio FITCH"/>
    <PLAYER NAME="Howard VALENTINE"/>
    <PLAYER NAME="Hrysopiyi DEVETZI"/>
    <PLAYER NAME="Hugo WIESLANDER"/>
    <PLAYER NAME="Huina XING"/>
    <PLAYER NAME="Hussein AHMED SALAH"/>
    <PLAYER NAME="Hyleas FOUNTAIN"/>
    <PLAYER NAME="Hyvin Kiyeng JEPKEMOI"/>
    <PLAYER NAME="Ian STEWART"/>
    <PLAYER NAME="Ibolya CSÃ&#x81;K"/>
    <PLAYER NAME="Ibrahim CAMEJO"/>
    <PLAYER NAME="Ignace HEINRICH"/>
    <PLAYER NAME="Igor ASTAPKOVICH"/>
    <PLAYER NAME="Igor NIKULIN"/>
    <PLAYER NAME="Igor TER-OVANESYAN"/>
    <PLAYER NAME="Igor TRANDENKOV"/>
    <PLAYER NAME="Ileana SILAI"/>
    <PLAYER NAME="Ilke WYLUDDA"/>
    <PLAYER NAME="Ilmari SALMINEN"/>
    <PLAYER NAME="Ilona SCHOKNECHT-SLUPIANEK"/>
    <PLAYER NAME="Ilya MARKOV"/>
    <PLAYER NAME="Imre NÃ&#x89;METH"/>
    <PLAYER NAME="Imrich BUGÃ&#x81;R"/>
    <PLAYER NAME="Inessa KRAVETS"/>
    <PLAYER NAME="Inga GENTZEL"/>
    <PLAYER NAME="Inge HELTEN"/>
    <PLAYER NAME="Ingrid AUERSWALD-LANGE"/>
    <PLAYER NAME="Ingrid LOTZ"/>
    <PLAYER NAME="Ingvar PETTERSSON"/>
    <PLAYER NAME="Inha BABAKOVA"/>
    <PLAYER NAME="Inna LASOVSKAYA"/>
    <PLAYER NAME="Ioannis PERSAKIS"/>
    <PLAYER NAME="Ioannis THEODOROPOULOS"/>
    <PLAYER NAME="Iolanda BALAS"/>
    <PLAYER NAME="Ionela TIRLEA"/>
    <PLAYER NAME="Ira DAVENPORT"/>
    <PLAYER NAME="Irena KIRSZENSTEIN"/>
    <PLAYER NAME="Irina BELOVA"/>
    <PLAYER NAME="Irina KHUDOROZHKINA"/>
    <PLAYER NAME="Irina PRIVALOVA"/>
    <PLAYER NAME="Irina SIMAGINA"/>
    <PLAYER NAME="Irvin ROBERSON"/>
    <PLAYER NAME="Irving BAXTER"/>
    <PLAYER NAME="Irving SALADINO"/>
    <PLAYER NAME="Iryna LISHCHYNSKA"/>
    <PLAYER NAME="Iryna YATCHENKO"/>
    <PLAYER NAME="Isabella OCHICHI"/>
    <PLAYER NAME="Ismail Ahmed ISMAIL"/>
    <PLAYER NAME="IstvÃ¡n RÃ&#x93;ZSAVÃ&#x96;LGYI"/>
    <PLAYER NAME="IstvÃ¡n SOMODI"/>
    <PLAYER NAME="Ivan BELYAEV"/>
    <PLAYER NAME="Ivan PEDROSO"/>
    <PLAYER NAME="Ivan RILEY"/>
    <PLAYER NAME="Ivan TSIKHAN"/>
    <PLAYER NAME="Ivan UKHOV"/>
    <PLAYER NAME="Ivana SPANOVIC"/>
    <PLAYER NAME="Ivanka KHRISTOVA"/>
    <PLAYER NAME="Ivano BRUGNETTI"/>
    <PLAYER NAME="Ivo VAN DAMME"/>
    <PLAYER NAME="Jaak UUDMÃ&#x84;E"/>
    <PLAYER NAME="Jacek WSZOLA"/>
    <PLAYER NAME="Jack DAVIS"/>
    <PLAYER NAME="Jack LONDON"/>
    <PLAYER NAME="Jack PARKER"/>
    <PLAYER NAME="Jack PIERCE"/>
    <PLAYER NAME="Jackie JOYNER"/>
    <PLAYER NAME="Jackson SCHOLZ"/>
    <PLAYER NAME="Jacqueline MAZEAS"/>
    <PLAYER NAME="Jacqueline TODTEN"/>
    <PLAYER NAME="Jadwiga WAJS"/>
    <PLAYER NAME="Jai TAURIMA"/>
    <PLAYER NAME="James BALL"/>
    <PLAYER NAME="James BECKFORD"/>
    <PLAYER NAME="James BROOKER"/>
    <PLAYER NAME="James CONNOLLY"/>
    <PLAYER NAME="James DILLION"/>
    <PLAYER NAME="James DUNCAN"/>
    <PLAYER NAME="James Edwin MEREDITH"/>
    <PLAYER NAME="James Ellis LU VALLE"/>
    <PLAYER NAME="James FUCHS"/>
    <PLAYER NAME="James GATHERS"/>
    <PLAYER NAME="James LIGHTBODY"/>
    <PLAYER NAME="James WENDELL"/>
    <PLAYER NAME="James WILSON"/>
    <PLAYER NAME="Jan Å½ELEZNÃ&#x9d;"/>
    <PLAYER NAME="Janay DELOACH"/>
    <PLAYER NAME="Jane SAVILLE"/>
    <PLAYER NAME="Janeene VICKERS"/>
    <PLAYER NAME="Janeth Jepkosgei BUSIENEI"/>
    <PLAYER NAME="Janis DALINS"/>
    <PLAYER NAME="Janusz KUSOCINSKI"/>
    <PLAYER NAME="Jaouad GHARIB"/>
    <PLAYER NAME="Jared TALLENT"/>
    <PLAYER NAME="Jarmila KRATOHVILOVA"/>
    <PLAYER NAME="Jaroslav BABA"/>
    <PLAYER NAME="Jaroslawa JÃ&#x93;ZWIAKOWSKA"/>
    <PLAYER NAME="Jason RICHARDSON"/>
    <PLAYER NAME="Javier CULSON"/>
    <PLAYER NAME="Javier GARCÃ&#x8d;A"/>
    <PLAYER NAME="Javier SOTOMAYOR"/>
    <PLAYER NAME="Jean BOUIN"/>
    <PLAYER NAME="Jean CHASTANIE"/>
    <PLAYER NAME="Jean GALFIONE"/>
    <PLAYER NAME="Jean SHILEY"/>
    <PLAYER NAME="Jeff HENDERSON"/>
    <PLAYER NAME="Jefferson PEREZ"/>
    <PLAYER NAME="Jemima Jelagat SUMGONG"/>
    <PLAYER NAME="Jennifer LAMY"/>
    <PLAYER NAME="Jennifer SIMPSON"/>
    <PLAYER NAME="Jennifer SUHR"/>
    <PLAYER NAME="Jeremy WARINER"/>
    <PLAYER NAME="Jerome BIFFLE"/>
    <PLAYER NAME="Jesse OWENS"/>
    <PLAYER NAME="Jessica ENNIS HILL"/>
    <PLAYER NAME="Jim BAUSCH"/>
    <PLAYER NAME="Jim DOEHRING"/>
    <PLAYER NAME="Jim HINES"/>
    <PLAYER NAME="Jim RYUN"/>
    <PLAYER NAME="Jim THORPE"/>
    <PLAYER NAME="Joachim Broechner OLSEN"/>
    <PLAYER NAME="Joachim BÃ&#x9c;CHNER"/>
    <PLAYER NAME="Joan BENOIT"/>
    <PLAYER NAME="Joan Lino MARTINEZ"/>
    <PLAYER NAME="Joanet QUINTERO"/>
    <PLAYER NAME="Joanna HAYES"/>
    <PLAYER NAME="Joaquim CRUZ"/>
    <PLAYER NAME="Joe GREENE"/>
    <PLAYER NAME="Joe KOVACS"/>
    <PLAYER NAME="Joel SANCHEZ GUERRERO"/>
    <PLAYER NAME="Joel SHANKLE"/>
    <PLAYER NAME="Johanna LÃ&#x9c;TTGE"/>
    <PLAYER NAME="Johanna SCHALLER-KLIER"/>
    <PLAYER NAME="John AKII-BUA"/>
    <PLAYER NAME="John ANDERSON"/>
    <PLAYER NAME="John BRAY"/>
    <PLAYER NAME="John CARLOS"/>
    <PLAYER NAME="John COLLIER"/>
    <PLAYER NAME="John COOPER"/>
    <PLAYER NAME="John CORNES"/>
    <PLAYER NAME="John CREGAN"/>
    <PLAYER NAME="John DALY"/>
    <PLAYER NAME="John DAVIES"/>
    <PLAYER NAME="John DEWITT"/>
    <PLAYER NAME="John DISLEY"/>
    <PLAYER NAME="John FLANAGAN"/>
    <PLAYER NAME="John GARRELLS"/>
    <PLAYER NAME="John GODINA"/>
    <PLAYER NAME="John George WALKER"/>
    <PLAYER NAME="John HAYES"/>
    <PLAYER NAME="John Kenneth DOHERTY"/>
    <PLAYER NAME="John LANDY"/>
    <PLAYER NAME="John LJUNGGREN"/>
    <PLAYER NAME="John LOARING"/>
    <PLAYER NAME="John LOVELOCK"/>
    <PLAYER NAME="John MCLEAN"/>
    <PLAYER NAME="John MOFFITT"/>
    <PLAYER NAME="John Macfarlane HOLLAND"/>
    <PLAYER NAME="John NORTON"/>
    <PLAYER NAME="John POWELL"/>
    <PLAYER NAME="John RAMBO"/>
    <PLAYER NAME="John RECTOR"/>
    <PLAYER NAME="John SHERWOOD"/>
    <PLAYER NAME="John THOMAS"/>
    <PLAYER NAME="John TREACY"/>
    <PLAYER NAME="John WOODRUFF"/>
    <PLAYER NAME="Johnny GRAY"/>
    <PLAYER NAME="Jolan KLEIBER-KONTSEK"/>
    <PLAYER NAME="Jolanda CEPLAK"/>
    <PLAYER NAME="Jonathan EDWARDS"/>
    <PLAYER NAME="Jonni MYYRÃ&#x84;"/>
    <PLAYER NAME="Jorge LLOPART"/>
    <PLAYER NAME="Jose TELLES DA CONCEICAO"/>
    <PLAYER NAME="Josef DOLEZAL"/>
    <PLAYER NAME="Josef ODLOZIL"/>
    <PLAYER NAME="Joseph BARTHEL"/>
    <PLAYER NAME="Joseph FORSHAW"/>
    <PLAYER NAME="Joseph GUILLEMOT"/>
    <PLAYER NAME="Joseph KETER"/>
    <PLAYER NAME="Joseph MAHMOUD"/>
    <PLAYER NAME="Joseph MCCLUSKEY"/>
    <PLAYER NAME="Josh CULBREATH"/>
    <PLAYER NAME="Josia THUGWANE"/>
    <PLAYER NAME="Josiah MCCRACKEN"/>
    <PLAYER NAME="JosÃ© Manuel ABASCAL"/>
    <PLAYER NAME="JosÃ© PEDRAZA"/>
    <PLAYER NAME="Joyce CHEPCHUMBA"/>
    <PLAYER NAME="Jozef PRIBILINEC"/>
    <PLAYER NAME="Jozef SCHMIDT"/>
    <PLAYER NAME="JoÃ£o Carlos DE OLIVEIRA"/>
    <PLAYER NAME="Juan Carlos ZABALA"/>
    <PLAYER NAME="Judi BROWN"/>
    <PLAYER NAME="Judith Florence AMOORE-POLLOCK"/>
    <PLAYER NAME="Juho Julius SAARISTO"/>
    <PLAYER NAME="Jules LADOUMEGUE"/>
    <PLAYER NAME="Juliet CUTHBERT"/>
    <PLAYER NAME="Julius KORIR"/>
    <PLAYER NAME="Julius SANG"/>
    <PLAYER NAME="Julius YEGO"/>
    <PLAYER NAME="Junxia WANG"/>
    <PLAYER NAME="Justin GATLIN"/>
    <PLAYER NAME="Jutta HEINE"/>
    <PLAYER NAME="Jutta KIRST"/>
    <PLAYER NAME="JÃ³zsef CSERMÃ&#x81;K"/>
    <PLAYER NAME="JÃ³zsef KOVÃ&#x81;CS"/>
    <PLAYER NAME="JÃ¶rg FREIMUTH"/>
    <PLAYER NAME="JÃ¼rgen HINGSEN"/>
    <PLAYER NAME="JÃ¼rgen SCHULT"/>
    <PLAYER NAME="JÃ¼rgen STRAUB"/>
    <PLAYER NAME="JÃ¼ri LOSSMANN"/>
    <PLAYER NAME="Kaarlo Jalmari TUOMINEN"/>
    <PLAYER NAME="Kaarlo MAANINKA"/>
    <PLAYER NAME="Kaisa PARVIAINEN"/>
    <PLAYER NAME="Kajsa BERGQVIST"/>
    <PLAYER NAME="Kamila SKOLIMOWSKA"/>
    <PLAYER NAME="Karel LISMONT"/>
    <PLAYER NAME="Karen FORKEL"/>
    <PLAYER NAME="Karin RICHERT-BALZER"/>
    <PLAYER NAME="Karl STORCH"/>
    <PLAYER NAME="Karl-Friedrich HAAS"/>
    <PLAYER NAME="Karoline &#34;Lina&#34; RADKE"/>
    <PLAYER NAME="Katharine MERRY"/>
    <PLAYER NAME="Kathleen HAMMOND"/>
    <PLAYER NAME="Kathrin NEIMKE"/>
    <PLAYER NAME="Kathryn Joan SCHMIDT"/>
    <PLAYER NAME="Kathryn SMALLWOOD-COOK"/>
    <PLAYER NAME="Katrin DÃ&#x96;RRE"/>
    <PLAYER NAME="Kazimierz ZIMNY"/>
    <PLAYER NAME="Kellie WELLS"/>
    <PLAYER NAME="Kelly HOLMES"/>
    <PLAYER NAME="Kelly SOTHERTON"/>
    <PLAYER NAME="Kenenisa BEKELE"/>
    <PLAYER NAME="Kenji KIMIHARA"/>
    <PLAYER NAME="Kenkichi OSHIMA"/>
    <PLAYER NAME="Kennedy Kane MCARTHUR"/>
    <PLAYER NAME="Kenneth Joseph MATTHEWS"/>
    <PLAYER NAME="Kenneth WIESNER"/>
    <PLAYER NAME="Kenny HARRISON"/>
    <PLAYER NAME="Kenth ELDEBRINK"/>
    <PLAYER NAME="Kerron CLEMENT"/>
    <PLAYER NAME="Kerron STEWART"/>
    <PLAYER NAME="Keshorn WALCOTT"/>
    <PLAYER NAME="Kevin MAYER"/>
    <PLAYER NAME="Kevin YOUNG"/>
    <PLAYER NAME="Khalid BOULAMI"/>
    <PLAYER NAME="Khalid SKAH"/>
    <PLAYER NAME="Kharilaos VASILAKOS"/>
    <PLAYER NAME="Kim BATTEN"/>
    <PLAYER NAME="Kim GALLAGHER"/>
    <PLAYER NAME="Kim TURNER"/>
    <PLAYER NAME="Kinue HITOMI"/>
    <PLAYER NAME="Kip KEINO"/>
    <PLAYER NAME="Kirani JAMES"/>
    <PLAYER NAME="Kirk BAPTISTE"/>
    <PLAYER NAME="Kirsten MÃ&#x9c;NCHOW"/>
    <PLAYER NAME="Kitei SON"/>
    <PLAYER NAME="Kjersti PLAETZER"/>
    <PLAYER NAME="Klaus LEHNERTZ"/>
    <PLAYER NAME="Klaus RICHTZENHAIN"/>
    <PLAYER NAME="Klaus-Peter HILDENBRAND"/>
    <PLAYER NAME="Klavdiya TOCHENOVA"/>
    <PLAYER NAME="Koichi MORISHITA"/>
    <PLAYER NAME="Koji MUROFUSHI"/>
    <PLAYER NAME="Kokichi TSUBURAYA"/>
    <PLAYER NAME="Konstantin VOLKOV"/>
    <PLAYER NAME="Kostas KENTERIS"/>
    <PLAYER NAME="Kriss AKABUSI"/>
    <PLAYER NAME="Kristi CASTLIN"/>
    <PLAYER NAME="Krisztian PARS"/>
    <PLAYER NAME="Kurt BENDLIN"/>
    <PLAYER NAME="KÃ¤the KRAUSS"/>
    <PLAYER NAME="LaVonna MARTIN"/>
    <PLAYER NAME="Lacey HEARN"/>
    <PLAYER NAME="Lajos GÃ&#x96;NCZY"/>
    <PLAYER NAME="Lalonde GORDON"/>
    <PLAYER NAME="Lambert REDD"/>
    <PLAYER NAME="Lance Earl DEAL"/>
    <PLAYER NAME="Larisa PELESHENKO"/>
    <PLAYER NAME="Larry BLACK"/>
    <PLAYER NAME="Larry JAMES"/>
    <PLAYER NAME="Larry YOUNG"/>
    <PLAYER NAME="Lars RIEDEL"/>
    <PLAYER NAME="Lashawn MERRITT"/>
    <PLAYER NAME="Lashinda DEMUS"/>
    <PLAYER NAME="Lasse VIREN"/>
    <PLAYER NAME="Lauri LEHTINEN"/>
    <PLAYER NAME="Lauri VIRTANEN"/>
    <PLAYER NAME="Lauryn WILLIAMS"/>
    <PLAYER NAME="Lawrence E. Joseph FEUERBACH"/>
    <PLAYER NAME="Lawrence JOHNSON"/>
    <PLAYER NAME="Lawrence SHIELDS"/>
    <PLAYER NAME="Lawrence WHITNEY"/>
    <PLAYER NAME="Lee BARNES"/>
    <PLAYER NAME="Lee CALHOUN"/>
    <PLAYER NAME="Lee EVANS"/>
    <PLAYER NAME="Leevan SANDS"/>
    <PLAYER NAME="Lennart STRAND"/>
    <PLAYER NAME="Lennox MILLER"/>
    <PLAYER NAME="Leo SEXTON"/>
    <PLAYER NAME="Leonard Francis TREMEER"/>
    <PLAYER NAME="Leonel MANZANO"/>
    <PLAYER NAME="Leonel SUAREZ"/>
    <PLAYER NAME="Leonid LITVINENKO"/>
    <PLAYER NAME="Leonid SHCHERBAKOV"/>
    <PLAYER NAME="Leonid SPIRIN"/>
    <PLAYER NAME="Leroy BROWN"/>
    <PLAYER NAME="Leroy SAMSE"/>
    <PLAYER NAME="Lesley ASHBURNER"/>
    <PLAYER NAME="Leslie DENIZ"/>
    <PLAYER NAME="Lester Nelson CARNEY"/>
    <PLAYER NAME="Lewis SHELDON"/>
    <PLAYER NAME="Lewis TEWANIMA"/>
    <PLAYER NAME="Lia MANOLIU"/>
    <PLAYER NAME="Lidia ALFEEVA"/>
    <PLAYER NAME="Lidia SIMON"/>
    <PLAYER NAME="Liesel WESTERMANN"/>
    <PLAYER NAME="Lijiao GONG"/>
    <PLAYER NAME="Liliya NURUTDINOVA"/>
    <PLAYER NAME="Lilli SCHWARZKOPF"/>
    <PLAYER NAME="Lillian BOARD"/>
    <PLAYER NAME="Lillian COPELAND"/>
    <PLAYER NAME="Lily CARLSTEDT"/>
    <PLAYER NAME="Linda STAHL"/>
    <PLAYER NAME="Lindy REMIGINO"/>
    <PLAYER NAME="Linford CHRISTIE"/>
    <PLAYER NAME="Liping WANG"/>
    <PLAYER NAME="Lisa ONDIEKI"/>
    <PLAYER NAME="Livio BERRUTI"/>
    <PLAYER NAME="Llewellyn HERBERT"/>
    <PLAYER NAME="Lloyd LABEACH"/>
    <PLAYER NAME="Lorraine FENTON"/>
    <PLAYER NAME="Lorraine MOLLER"/>
    <PLAYER NAME="Lothar MILDE"/>
    <PLAYER NAME="Louis WILKINS"/>
    <PLAYER NAME="Louise MCPAUL"/>
    <PLAYER NAME="Lucyna LANGER"/>
    <PLAYER NAME="Ludmila ENGQUIST"/>
    <PLAYER NAME="LudvÃ­k DANEK"/>
    <PLAYER NAME="Luguelin SANTOS"/>
    <PLAYER NAME="Luigi BECCALI"/>
    <PLAYER NAME="Luis BRUNETTO"/>
    <PLAYER NAME="Luis DELIS"/>
    <PLAYER NAME="Luise KRÃ&#x9c;GER"/>
    <PLAYER NAME="Lutz DOMBROWSKI"/>
    <PLAYER NAME="Luvo MANYONGA"/>
    <PLAYER NAME="Luz LONG"/>
    <PLAYER NAME="Lynn DAVIES"/>
    <PLAYER NAME="Lynn JENNINGS"/>
    <PLAYER NAME="Lyudmila BRAGINA"/>
    <PLAYER NAME="Lyudmila KONDRATYEVA"/>
    <PLAYER NAME="Lyudmila ROGACHOVA"/>
    <PLAYER NAME="Lyudmila SHEVTSOVA"/>
    <PLAYER NAME="Mac WILKINS"/>
    <PLAYER NAME="Madeline MANNING-JACKSON"/>
    <PLAYER NAME="Mahiedine MEKHISSI"/>
    <PLAYER NAME="Mahiedine MEKHISSI-BENABBAD"/>
    <PLAYER NAME="Maksim TARASOV"/>
    <PLAYER NAME="Mal WHITFIELD"/>
    <PLAYER NAME="Malcolm NOKES"/>
    <PLAYER NAME="Malcolm SPENCE"/>
    <PLAYER NAME="Mamo WOLDE"/>
    <PLAYER NAME="Manuel MARTINEZ"/>
    <PLAYER NAME="Manuel PLAZA"/>
    <PLAYER NAME="Manuela MONTEBRUN"/>
    <PLAYER NAME="Marc WRIGHT"/>
    <PLAYER NAME="Marcel HANSENNE"/>
    <PLAYER NAME="Mare DIBABA"/>
    <PLAYER NAME="Margaret Nyairera WAMBUI"/>
    <PLAYER NAME="Margitta DROESE-PUFE"/>
    <PLAYER NAME="Margitta HELMBOLD-GUMMEL"/>
    <PLAYER NAME="Maria CIONCAN"/>
    <PLAYER NAME="Maria COLON"/>
    <PLAYER NAME="Maria GOMMERS"/>
    <PLAYER NAME="Maria Guadalupe GONZALEZ"/>
    <PLAYER NAME="Maria KWASNIEWSKA"/>
    <PLAYER NAME="Maria MUTOLA"/>
    <PLAYER NAME="Maria VASCO"/>
    <PLAYER NAME="Maria VERGOVA-PETKOVA"/>
    <PLAYER NAME="Marian OPREA"/>
    <PLAYER NAME="Marianne WERNER"/>
    <PLAYER NAME="Maricica PUICA"/>
    <PLAYER NAME="Marie-JosÃ© PÃ&#x89;REC"/>
    <PLAYER NAME="Marilyn BLACK"/>
    <PLAYER NAME="Mario LANZI"/>
    <PLAYER NAME="Marion BECKER-STEINER"/>
    <PLAYER NAME="Marita KOCH"/>
    <PLAYER NAME="Marita LANGE"/>
    <PLAYER NAME="Maritza MARTEN"/>
    <PLAYER NAME="Mariya SAVINOVA"/>
    <PLAYER NAME="Marjorie JACKSON"/>
    <PLAYER NAME="Mark CREAR"/>
    <PLAYER NAME="Mark MCKOY"/>
    <PLAYER NAME="Markus RYFFEL"/>
    <PLAYER NAME="Marlene MATHEWS-WILLARD"/>
    <PLAYER NAME="Marlies OELSNER-GÃ&#x96;HR"/>
    <PLAYER NAME="Marquis Franklin HORR"/>
    <PLAYER NAME="Marta ANTAL-RUDAS"/>
    <PLAYER NAME="Martin HAWKINS"/>
    <PLAYER NAME="Martin SHERIDAN"/>
    <PLAYER NAME="Martinus OSENDARP"/>
    <PLAYER NAME="Martti MARTTELIN"/>
    <PLAYER NAME="Mary ONYALI"/>
    <PLAYER NAME="Mary RAND"/>
    <PLAYER NAME="Maryam Yusuf JAMAL"/>
    <PLAYER NAME="Maryvonne DUPUREUR"/>
    <PLAYER NAME="Matej TOTH"/>
    <PLAYER NAME="Matt HEMINGWAY"/>
    <PLAYER NAME="Matt MCGRATH"/>
    <PLAYER NAME="Matthew BIRIR"/>
    <PLAYER NAME="Matthew CENTROWITZ"/>
    <PLAYER NAME="Matthew Mackenzie ROBINSON"/>
    <PLAYER NAME="Matti JÃ&#x84;RVINEN"/>
    <PLAYER NAME="Matti SIPPALA"/>
    <PLAYER NAME="Maurice GREENE"/>
    <PLAYER NAME="Maurice HERRIOTT"/>
    <PLAYER NAME="Maurizio DAMILANO"/>
    <PLAYER NAME="Maurren Higa MAGGI"/>
    <PLAYER NAME="Maxwell Warburn LONG"/>
    <PLAYER NAME="Mbulaeni MULAUDZI"/>
    <PLAYER NAME="Mebrahtom KEFLEZIGHI"/>
    <PLAYER NAME="Medhi BAALA"/>
    <PLAYER NAME="Mel PATTON"/>
    <PLAYER NAME="Melaine WALKER"/>
    <PLAYER NAME="Melina ROBERT-MICHON"/>
    <PLAYER NAME="Melissa MORRISON"/>
    <PLAYER NAME="Melvin SHEPPARD"/>
    <PLAYER NAME="Meredith COLKETT"/>
    <PLAYER NAME="Meredith GOURDINE"/>
    <PLAYER NAME="Merlene OTTEY"/>
    <PLAYER NAME="Merritt GIFFIN"/>
    <PLAYER NAME="Meseret DEFAR"/>
    <PLAYER NAME="Meyer PRINSTEIN"/>
    <PLAYER NAME="Micah KOGO"/>
    <PLAYER NAME="Michael BATES"/>
    <PLAYER NAME="Michael D'Andrea CARTER"/>
    <PLAYER NAME="Michael JOHNSON"/>
    <PLAYER NAME="Michael Lyle SHINE"/>
    <PLAYER NAME="Michael MARSH"/>
    <PLAYER NAME="Michael MCLEOD"/>
    <PLAYER NAME="Michael MUSYOKI"/>
    <PLAYER NAME="Michael TINSLEY"/>
    <PLAYER NAME="Michel JAZY"/>
    <PLAYER NAME="Michel THÃ&#x89;ATO"/>
    <PLAYER NAME="Michele BROWN"/>
    <PLAYER NAME="Micheline OSTERMEYER"/>
    <PLAYER NAME="Michelle CARTER"/>
    <PLAYER NAME="MichÃ¨le CHARDONNET"/>
    <PLAYER NAME="Miguel WHITE"/>
    <PLAYER NAME="Mihaela LOGHIN"/>
    <PLAYER NAME="Mihaela PENES"/>
    <PLAYER NAME="Mike BOIT"/>
    <PLAYER NAME="Mike CONLEY"/>
    <PLAYER NAME="Mike LARRABEE"/>
    <PLAYER NAME="Mike POWELL"/>
    <PLAYER NAME="Mike RYAN"/>
    <PLAYER NAME="Mike STULCE"/>
    <PLAYER NAME="Mikhail SHCHENNIKOV"/>
    <PLAYER NAME="Miklos NEMETH"/>
    <PLAYER NAME="Milcah Chemos CHEYWA"/>
    <PLAYER NAME="Mildred DIDRIKSON"/>
    <PLAYER NAME="Millard Frank Jr. HAMPTON"/>
    <PLAYER NAME="Millon WOLDE"/>
    <PLAYER NAME="Miltiadis GOUSKOS"/>
    <PLAYER NAME="Milton Gray CAMPBELL"/>
    <PLAYER NAME="Mirela DEMIREVA"/>
    <PLAYER NAME="Mirela MANIANI"/>
    <PLAYER NAME="Miruts YIFTER"/>
    <PLAYER NAME="Mitchell WATT"/>
    <PLAYER NAME="Mizuki NOGUCHI"/>
    <PLAYER NAME="Mohamed Ahmed SULAIMAN"/>
    <PLAYER NAME="Mohamed FARAH"/>
    <PLAYER NAME="Mohamed GAMMOUDI"/>
    <PLAYER NAME="Mohammed KEDIR"/>
    <PLAYER NAME="Monika ZEHRT"/>
    <PLAYER NAME="Mor KOVACS"/>
    <PLAYER NAME="Morgan TAYLOR"/>
    <PLAYER NAME="Morris KIRKSEY"/>
    <PLAYER NAME="Moses KIPTANUI"/>
    <PLAYER NAME="Murray HALBERG"/>
    <PLAYER NAME="Mutaz Essa BARSHIM"/>
    <PLAYER NAME="Nadezhda CHIZHOVA"/>
    <PLAYER NAME="Nadezhda KHNYKINA"/>
    <PLAYER NAME="Nadezhda OLIZARENKO"/>
    <PLAYER NAME="Nadine KLEINERT-SCHMITT"/>
    <PLAYER NAME="Nafissatou THIAM"/>
    <PLAYER NAME="Naftali TEMU"/>
    <PLAYER NAME="Naman KEITA"/>
    <PLAYER NAME="Nancy Jebet LAGAT"/>
    <PLAYER NAME="Naoko TAKAHASHI"/>
    <PLAYER NAME="Naoto TAJIMA"/>
    <PLAYER NAME="Natalia BOCHINA"/>
    <PLAYER NAME="Natalia SHIKOLENKO"/>
    <PLAYER NAME="Nataliya TOBIAS"/>
    <PLAYER NAME="Natallia DOBRYNSKA"/>
    <PLAYER NAME="Natalya ANTYUKH"/>
    <PLAYER NAME="Natalya CHISTYAKOVA"/>
    <PLAYER NAME="Natalya LEBEDEVA"/>
    <PLAYER NAME="Natalya SADOVA"/>
    <PLAYER NAME="Natalya SAZANOVICH"/>
    <PLAYER NAME="Natasha DANVERS"/>
    <PLAYER NAME="Nate CARTMELL"/>
    <PLAYER NAME="Nathan DEAKES"/>
    <PLAYER NAME="Nawal EL MOUTAWAKEL"/>
    <PLAYER NAME="Nelson EVORA"/>
    <PLAYER NAME="Nezha BIDOUANE"/>
    <PLAYER NAME="Nia ALI"/>
    <PLAYER NAME="Nicholas WILLIS"/>
    <PLAYER NAME="Nick HYSONG"/>
    <PLAYER NAME="Nick WINTER"/>
    <PLAYER NAME="Nicola VIZZONI"/>
    <PLAYER NAME="Nijel AMOS"/>
    <PLAYER NAME="Niki BAKOGIANNI"/>
    <PLAYER NAME="Nikolai KIROV"/>
    <PLAYER NAME="Nikolaos GEORGANTAS"/>
    <PLAYER NAME="Nikolay AVILOV"/>
    <PLAYER NAME="Nikolay SMAGA"/>
    <PLAYER NAME="Nikolay SOKOLOV"/>
    <PLAYER NAME="Nikolina CHTEREVA"/>
    <PLAYER NAME="Nils ENGDAHL"/>
    <PLAYER NAME="Nils SCHUMANN"/>
    <PLAYER NAME="Nina DUMBADZE"/>
    <PLAYER NAME="Nina ROMASHKOVA"/>
    <PLAYER NAME="Niole SABAITE"/>
    <PLAYER NAME="Nixon KIPROTICH"/>
    <PLAYER NAME="Noah Kiprono NGENYI"/>
    <PLAYER NAME="Noe HERNANDEZ"/>
    <PLAYER NAME="Noel FREEMAN"/>
    <PLAYER NAME="Norman HALLOWS"/>
    <PLAYER NAME="Norman PRITCHARD"/>
    <PLAYER NAME="Norman READ"/>
    <PLAYER NAME="Norman TABER"/>
    <PLAYER NAME="Noureddine MORCELI"/>
    <PLAYER NAME="Nouria MERAH-BENIDA"/>
    <PLAYER NAME="NÃ¡ndor DÃ&#x81;NI"/>
    <PLAYER NAME="Oana PANTELIMON"/>
    <PLAYER NAME="Obadele THOMPSON"/>
    <PLAYER NAME="Oleg Georgiyevich FEDOSEYEV"/>
    <PLAYER NAME="Oleksandr BAGACH"/>
    <PLAYER NAME="Oleksandr KRYKUN"/>
    <PLAYER NAME="Oleksiy KRYKUN"/>
    <PLAYER NAME="Olena ANTONOVA"/>
    <PLAYER NAME="Olena HOVOROVA"/>
    <PLAYER NAME="Olena KRASOVSKA"/>
    <PLAYER NAME="Olga BRYZGINA"/>
    <PLAYER NAME="Olga KANISKINA"/>
    <PLAYER NAME="Olga KUZENKOVA"/>
    <PLAYER NAME="Olga MINEEVA"/>
    <PLAYER NAME="Olga RYPAKOVA"/>
    <PLAYER NAME="Olga SALADUKHA"/>
    <PLAYER NAME="Olga SHISHIGINA"/>
    <PLAYER NAME="Olimpiada IVANOVA"/>
    <PLAYER NAME="Ollie MATSON"/>
    <PLAYER NAME="Omar MCLEOD"/>
    <PLAYER NAME="Orlando ORTEGA"/>
    <PLAYER NAME="Osleidys MENÃ&#x89;NDEZ"/>
    <PLAYER NAME="Otis DAVIS"/>
    <PLAYER NAME="Otis HARRIS"/>
    <PLAYER NAME="Otto NILSSON"/>
    <PLAYER NAME="Ove ANDERSEN"/>
    <PLAYER NAME="Paavo NURMI"/>
    <PLAYER NAME="Paavo YRJÃ&#x96;LÃ&#x84;"/>
    <PLAYER NAME="Pamela JELIMO"/>
    <PLAYER NAME="Panagiotis PARASKEVOPOULOS"/>
    <PLAYER NAME="Paola PIGNI-CACCHI"/>
    <PLAYER NAME="Parry O'BRIEN"/>
    <PLAYER NAME="Patricia GIRARD"/>
    <PLAYER NAME="Patrick FLYNN"/>
    <PLAYER NAME="Patrick LEAHY"/>
    <PLAYER NAME="Patrick MCDONALD"/>
    <PLAYER NAME="Patrick O'CALLAGHAN"/>
    <PLAYER NAME="Patrick SANG"/>
    <PLAYER NAME="Patrik SJÃ&#x96;BERG"/>
    <PLAYER NAME="Paul BITOK"/>
    <PLAYER NAME="Paul BONTEMPS"/>
    <PLAYER NAME="Paul DRAYTON"/>
    <PLAYER NAME="Paul Kipkemoi CHELIMO"/>
    <PLAYER NAME="Paul Kipngetich TANUI"/>
    <PLAYER NAME="Paul Kipsiele KOECH"/>
    <PLAYER NAME="Paul MARTIN"/>
    <PLAYER NAME="Paul TERGAT"/>
    <PLAYER NAME="Paul Vincent NIHILL"/>
    <PLAYER NAME="Paul WEINSTEIN"/>
    <PLAYER NAME="Paul WINTER"/>
    <PLAYER NAME="Paul-Heinz WELLMANN"/>
    <PLAYER NAME="Paula MOLLENHAUER"/>
    <PLAYER NAME="Pauli NEVALA"/>
    <PLAYER NAME="Pauline DAVIS"/>
    <PLAYER NAME="Pauline KONGA"/>
    <PLAYER NAME="Pekka VASALA"/>
    <PLAYER NAME="Percy BEARD"/>
    <PLAYER NAME="Percy HODGE"/>
    <PLAYER NAME="Percy WILLIAMS"/>
    <PLAYER NAME="Peter FRENKEL"/>
    <PLAYER NAME="Peter NORMAN"/>
    <PLAYER NAME="Peter PETROV"/>
    <PLAYER NAME="Peter RADFORD"/>
    <PLAYER NAME="Peter SNELL"/>
    <PLAYER NAME="Peter ZAREMBA"/>
    <PLAYER NAME="Philip BAKER"/>
    <PLAYER NAME="Philip EDWARDS"/>
    <PLAYER NAME="Phillips IDOWU"/>
    <PLAYER NAME="Pierre LEWDEN"/>
    <PLAYER NAME="Pietro MENNEA"/>
    <PLAYER NAME="Piotr MALACHOWSKI"/>
    <PLAYER NAME="Piotr POCHINCHUK"/>
    <PLAYER NAME="Primoz KOZMUS"/>
    <PLAYER NAME="Priscah JEPTOO"/>
    <PLAYER NAME="Priscilla LOPES-SCHLIEP"/>
    <PLAYER NAME="Pyotr BOLOTNIKOV"/>
    <PLAYER NAME="Quincy WATTS"/>
    <PLAYER NAME="Rachid EL BASIR"/>
    <PLAYER NAME="Raelene Ann BOYLE"/>
    <PLAYER NAME="Rafer JOHNSON"/>
    <PLAYER NAME="Ragnar Torsten LUNDBERG"/>
    <PLAYER NAME="Ralph BOSTON"/>
    <PLAYER NAME="Ralph CRAIG"/>
    <PLAYER NAME="Ralph DOUBELL"/>
    <PLAYER NAME="Ralph HILL"/>
    <PLAYER NAME="Ralph HILLS"/>
    <PLAYER NAME="Ralph MANN"/>
    <PLAYER NAME="Ralph METCALFE"/>
    <PLAYER NAME="Ralph ROSE"/>
    <PLAYER NAME="Randel Luvelle WILLIAMS"/>
    <PLAYER NAME="Randy BARNES"/>
    <PLAYER NAME="Randy MATSON"/>
    <PLAYER NAME="Raphael HOLZDEPPE"/>
    <PLAYER NAME="Raymond James BARBUTI"/>
    <PLAYER NAME="RaÃºl GONZÃ&#x81;LEZ"/>
    <PLAYER NAME="Reese HOFFA"/>
    <PLAYER NAME="Reggie WALKER"/>
    <PLAYER NAME="Rein AUN"/>
    <PLAYER NAME="Reinaldo GORNO"/>
    <PLAYER NAME="Renate GARISCH-CULMBERGER-BOY"/>
    <PLAYER NAME="Renate STECHER"/>
    <PLAYER NAME="Renaud LAVILLENIE"/>
    <PLAYER NAME="Reuben KOSGEI"/>
    <PLAYER NAME="Ria STALMAN"/>
    <PLAYER NAME="Richard CHELIMO"/>
    <PLAYER NAME="Richard COCHRAN"/>
    <PLAYER NAME="Richard Charles WOHLHUTER"/>
    <PLAYER NAME="Richard HOWARD"/>
    <PLAYER NAME="Richard Kipkemboi MATEELONG"/>
    <PLAYER NAME="Richard Leslie BYRD"/>
    <PLAYER NAME="Richard SHELDON"/>
    <PLAYER NAME="Richard THOMPSON"/>
    <PLAYER NAME="Rick MITCHELL"/>
    <PLAYER NAME="Rink BABKA"/>
    <PLAYER NAME="Rita JAHN"/>
    <PLAYER NAME="Robert CLOUGHEN"/>
    <PLAYER NAME="Robert GARRETT"/>
    <PLAYER NAME="Robert GRABARZ"/>
    <PLAYER NAME="Robert HARTING"/>
    <PLAYER NAME="Robert HEFFERNAN"/>
    <PLAYER NAME="Robert Hyatt CLARK"/>
    <PLAYER NAME="Robert KERR"/>
    <PLAYER NAME="Robert KORZENIOWSKI"/>
    <PLAYER NAME="Robert Keyser SCHUL"/>
    <PLAYER NAME="Robert MCMILLEN"/>
    <PLAYER NAME="Robert Morton Newburgh TISDALL"/>
    <PLAYER NAME="Robert SHAVLAKADZE"/>
    <PLAYER NAME="Robert STANGLAND"/>
    <PLAYER NAME="Robert TAYLOR"/>
    <PLAYER NAME="Robert VAN OSDEL"/>
    <PLAYER NAME="Robert ZMELÃ&#x8d;K"/>
    <PLAYER NAME="Roberta BRUNET"/>
    <PLAYER NAME="Roberto MOYA"/>
    <PLAYER NAME="Rod MILBURN"/>
    <PLAYER NAME="Rodney DIXON"/>
    <PLAYER NAME="Roger BLACK"/>
    <PLAYER NAME="Roger KINGDOM"/>
    <PLAYER NAME="Roger MOENS"/>
    <PLAYER NAME="Roland WIESER"/>
    <PLAYER NAME="Rolf DANNEBERG"/>
    <PLAYER NAME="Roman SCHURENKO"/>
    <PLAYER NAME="Roman SEBRLE"/>
    <PLAYER NAME="Romas UBARTAS"/>
    <PLAYER NAME="Romeo BERTINI"/>
    <PLAYER NAME="Romuald KLIM"/>
    <PLAYER NAME="Ron CLARKE"/>
    <PLAYER NAME="Ron DELANY"/>
    <PLAYER NAME="Ron FREEMAN"/>
    <PLAYER NAME="Ronald MORRIS"/>
    <PLAYER NAME="Ronald WEIGEL"/>
    <PLAYER NAME="Rosa MOTA"/>
    <PLAYER NAME="Rosemarie WITSCHAS-ACKERMANN"/>
    <PLAYER NAME="Roy Braxton COCHRAN"/>
    <PLAYER NAME="Rui SILVA"/>
    <PLAYER NAME="Rune LARSSON"/>
    <PLAYER NAME="Ruth BEITIA"/>
    <PLAYER NAME="Ruth FUCHS"/>
    <PLAYER NAME="Ruth JEBET"/>
    <PLAYER NAME="Ruth OSBURN"/>
    <PLAYER NAME="Ruth SVEDBERG"/>
    <PLAYER NAME="Ryan CROUSER"/>
    <PLAYER NAME="Ryszard KATUS"/>
    <PLAYER NAME="Sabine BRAUN"/>
    <PLAYER NAME="Sabine EVERTS"/>
    <PLAYER NAME="Sabine JOHN"/>
    <PLAYER NAME="Saida GUNBA"/>
    <PLAYER NAME="Salah HISSOU"/>
    <PLAYER NAME="Sally GUNNELL"/>
    <PLAYER NAME="Sally Jepkosgei KIPYEGO"/>
    <PLAYER NAME="Sally PEARSON"/>
    <PLAYER NAME="Salvatore MORALE"/>
    <PLAYER NAME="Sam GRADDY"/>
    <PLAYER NAME="Sam KENDRICKS"/>
    <PLAYER NAME="Samson KITUR"/>
    <PLAYER NAME="Samuel FERRIS"/>
    <PLAYER NAME="Samuel JONES"/>
    <PLAYER NAME="Samuel Kamau WANJIRU"/>
    <PLAYER NAME="Samuel MATETE"/>
    <PLAYER NAME="Sandi MORRIS"/>
    <PLAYER NAME="Sandra FARMER-PATRICK"/>
    <PLAYER NAME="Sandra PERKOVIC"/>
    <PLAYER NAME="Sandro BELLUCCI"/>
    <PLAYER NAME="Sanya RICHARDS-ROSS"/>
    <PLAYER NAME="Sara KOLAK"/>
    <PLAYER NAME="Sara SIMEONI"/>
    <PLAYER NAME="Sara Slott PETERSEN"/>
    <PLAYER NAME="Sarka KASPARKOVA"/>
    <PLAYER NAME="SaÃ¯d AOUITA"/>
    <PLAYER NAME="Schuyler ENCK"/>
    <PLAYER NAME="Sebastian COE"/>
    <PLAYER NAME="Semyon RZISHCHIN"/>
    <PLAYER NAME="Seppo RÃ&#x84;TY"/>
    <PLAYER NAME="Sergei ZHELANOV"/>
    <PLAYER NAME="Sergey KLYUGIN"/>
    <PLAYER NAME="Sergey LITVINOV"/>
    <PLAYER NAME="Sergey MAKAROV"/>
    <PLAYER NAME="Setymkul DZHUMANAZAROV"/>
    <PLAYER NAME="Shalane FLANAGAN"/>
    <PLAYER NAME="Shaunae MILLER"/>
    <PLAYER NAME="Shawn CRAWFORD"/>
    <PLAYER NAME="Sheena TOSTA"/>
    <PLAYER NAME="Sheila LERWILL"/>
    <PLAYER NAME="Shelly-Ann FRASER-PRYCE"/>
    <PLAYER NAME="Shenjie QIEYANG"/>
    <PLAYER NAME="Shericka JACKSON"/>
    <PLAYER NAME="Shericka WILLIAMS"/>
    <PLAYER NAME="Sherone SIMPSON"/>
    <PLAYER NAME="Shirley CAWLEY"/>
    <PLAYER NAME="Shirley STRICKLAND"/>
    <PLAYER NAME="Shirley STRONG"/>
    <PLAYER NAME="Shoryu NAN"/>
    <PLAYER NAME="Shuhei NISHIDA"/>
    <PLAYER NAME="Sidney ATKINSON"/>
    <PLAYER NAME="Sidney ROBINSON"/>
    <PLAYER NAME="Siegfried WENTZ"/>
    <PLAYER NAME="Sileshi SIHINE"/>
    <PLAYER NAME="Silke RENK"/>
    <PLAYER NAME="Silvia CHIVAS BARO"/>
    <PLAYER NAME="Silvio LEONARD SARRIA"/>
    <PLAYER NAME="Sim INESS"/>
    <PLAYER NAME="Simeon TORIBIO"/>
    <PLAYER NAME="Sofia ASSEFA"/>
    <PLAYER NAME="Sonia O'SULLIVAN"/>
    <PLAYER NAME="Sophie HITCHON"/>
    <PLAYER NAME="Sotirios VERSIS"/>
    <PLAYER NAME="Spyridon LOUIS"/>
    <PLAYER NAME="Stacy DRAGILA"/>
    <PLAYER NAME="Stanislawa WALASIEWICZ"/>
    <PLAYER NAME="Stanley Frank VICKERS"/>
    <PLAYER NAME="Stanley ROWLEY"/>
    <PLAYER NAME="Stefan HOLM"/>
    <PLAYER NAME="Stefano BALDINI"/>
    <PLAYER NAME="Steffi NERIUS"/>
    <PLAYER NAME="Stefka KOSTADINOVA"/>
    <PLAYER NAME="Sten PETTERSSON"/>
    <PLAYER NAME="Stephan FREIGANG"/>
    <PLAYER NAME="Stephanie BROWN TRAFTON"/>
    <PLAYER NAME="Stephanie GRAF"/>
    <PLAYER NAME="Stephen KIPKORIR"/>
    <PLAYER NAME="Stephen KIPROTICH"/>
    <PLAYER NAME="Steve ANDERSON"/>
    <PLAYER NAME="Steve BACKLEY"/>
    <PLAYER NAME="Steve CRAM"/>
    <PLAYER NAME="Steve HOOKER"/>
    <PLAYER NAME="Steve LEWIS"/>
    <PLAYER NAME="Steve OVETT"/>
    <PLAYER NAME="Steve SMITH"/>
    <PLAYER NAME="Suleiman NYAMBUI"/>
    <PLAYER NAME="Sulo BÃ&#x84;RLUND"/>
    <PLAYER NAME="Sunette VILJOEN"/>
    <PLAYER NAME="Susanthika JAYASINGHE"/>
    <PLAYER NAME="Sverre HANSEN"/>
    <PLAYER NAME="Svetlana FEOFANOVA"/>
    <PLAYER NAME="Svetlana KRIVELYOVA"/>
    <PLAYER NAME="Svetlana MASTERKOVA"/>
    <PLAYER NAME="Svetlana SHKOLINA"/>
    <PLAYER NAME="Sylvio CATOR"/>
    <PLAYER NAME="Szymon ZIOLKOWSKI"/>
    <PLAYER NAME="SÃ&#x83;Â¡ndor ROZSNYÃ&#x83;?I"/>
    <PLAYER NAME="Tadeusz RUT"/>
    <PLAYER NAME="Tadeusz SLUSARSKI"/>
    <PLAYER NAME="Taisiya CHENCHIK"/>
    <PLAYER NAME="Tamara PRESS"/>
    <PLAYER NAME="Tamirat TOLA"/>
    <PLAYER NAME="Tanya LAWRENCE"/>
    <PLAYER NAME="Taoufik MAKHLOUFI"/>
    <PLAYER NAME="Tapio KANTANEN"/>
    <PLAYER NAME="Tariku BEKELE"/>
    <PLAYER NAME="Tatiana ANISIMOVA"/>
    <PLAYER NAME="Tatiana GRIGORIEVA"/>
    <PLAYER NAME="Tatiana KAZANKINA"/>
    <PLAYER NAME="Tatiana KOLPAKOVA"/>
    <PLAYER NAME="Tatiana LESOVAIA"/>
    <PLAYER NAME="Tatiana PROVIDOKHINA"/>
    <PLAYER NAME="Tatiana SKACHKO"/>
    <PLAYER NAME="Tatyana CHERNOVA"/>
    <PLAYER NAME="Tatyana KOTOVA"/>
    <PLAYER NAME="Tatyana LEBEDEVA"/>
    <PLAYER NAME="Tatyana PETROVA ARKHIPOVA"/>
    <PLAYER NAME="Tatyana SHCHELKANOVA"/>
    <PLAYER NAME="Tatyana TOMASHOVA"/>
    <PLAYER NAME="Terence Lloyd JOHNSON"/>
    <PLAYER NAME="Tereza MARINOVA"/>
    <PLAYER NAME="Tero PITKAMAKI"/>
    <PLAYER NAME="Terrence TRAMMELL"/>
    <PLAYER NAME="Tesfaye TOLA"/>
    <PLAYER NAME="Tetyana TERESHCHUK"/>
    <PLAYER NAME="Thaddeus SHIDELER"/>
    <PLAYER NAME="Thane BAKER"/>
    <PLAYER NAME="Theresia KIESL"/>
    <PLAYER NAME="Thiago Braz DA SILVA"/>
    <PLAYER NAME="Thomas BURKE"/>
    <PLAYER NAME="Thomas COURTNEY"/>
    <PLAYER NAME="Thomas CURTIS"/>
    <PLAYER NAME="Thomas EVENSON"/>
    <PLAYER NAME="Thomas Francis FARRELL"/>
    <PLAYER NAME="Thomas Francis KIELY"/>
    <PLAYER NAME="Thomas HAMPSON"/>
    <PLAYER NAME="Thomas HICKS"/>
    <PLAYER NAME="Thomas HILL"/>
    <PLAYER NAME="Thomas JEFFERSON"/>
    <PLAYER NAME="Thomas John Henry RICHARDS"/>
    <PLAYER NAME="Thomas LIEB"/>
    <PLAYER NAME="Thomas MUNKELT"/>
    <PLAYER NAME="Thomas Pkemei LONGOSIWA"/>
    <PLAYER NAME="Thomas ROHLER"/>
    <PLAYER NAME="Thomas William GREEN"/>
    <PLAYER NAME="Tia HELLEBAUT"/>
    <PLAYER NAME="Tianfeng SI"/>
    <PLAYER NAME="Tianna BARTOLETTA"/>
    <PLAYER NAME="Tiki GELANA"/>
    <PLAYER NAME="Tilly FLEISCHER"/>
    <PLAYER NAME="Tim AHEARNE"/>
    <PLAYER NAME="Tim FORSYTH"/>
    <PLAYER NAME="Timothy KITUM"/>
    <PLAYER NAME="Timothy MACK"/>
    <PLAYER NAME="Tirunesh DIBABA"/>
    <PLAYER NAME="Toby STEVENSON"/>
    <PLAYER NAME="Toivo HYYTIÃ&#x84;INEN"/>
    <PLAYER NAME="Toivo LOUKOLA"/>
    <PLAYER NAME="Tomas WALSH"/>
    <PLAYER NAME="Tomasz MAJEWSKI"/>
    <PLAYER NAME="Tommie SMITH"/>
    <PLAYER NAME="TomÃ¡? DVORÃ&#x81;K"/>
    <PLAYER NAME="Tonique WILLIAMS-DARLING"/>
    <PLAYER NAME="Tonja BUFORD-BAILEY"/>
    <PLAYER NAME="Tony DEES"/>
    <PLAYER NAME="Tore SJÃ&#x96;STRAND"/>
    <PLAYER NAME="Tori BOWIE"/>
    <PLAYER NAME="Torsten VOSS"/>
    <PLAYER NAME="Trey HARDEE"/>
    <PLAYER NAME="Trine HATTESTAD"/>
    <PLAYER NAME="Truxtun HARE"/>
    <PLAYER NAME="Tsegay KEBEDE"/>
    <PLAYER NAME="Tsvetanka KHRISTOVA"/>
    <PLAYER NAME="Udo BEYER"/>
    <PLAYER NAME="Ugo FRIGERIO"/>
    <PLAYER NAME="Ulrike KLAPEZYNSKI-BRUNS"/>
    <PLAYER NAME="Ursula DONATH"/>
    <PLAYER NAME="Urszula KIELAN"/>
    <PLAYER NAME="Usain BOLT"/>
    <PLAYER NAME="Ute HOMMOLA"/>
    <PLAYER NAME="Uwe BEYER"/>
    <PLAYER NAME="Vadim DEVYATOVSKIY"/>
    <PLAYER NAME="Vadims VASILEVSKIS"/>
    <PLAYER NAME="Vala FLOSADÃ&#x93;TTIR"/>
    <PLAYER NAME="Valentin MASSANA"/>
    <PLAYER NAME="Valentina YEGOROVA"/>
    <PLAYER NAME="Valeri BRUMEL"/>
    <PLAYER NAME="Valeri PODLUZHNYI"/>
    <PLAYER NAME="Valeria BUFANU"/>
    <PLAYER NAME="Valerie ADAMS"/>
    <PLAYER NAME="Valerie BRISCO"/>
    <PLAYER NAME="Valerio ARRI"/>
    <PLAYER NAME="Valeriy BORCHIN"/>
    <PLAYER NAME="Valery BORZOV"/>
    <PLAYER NAME="Vanderlei DE LIMA"/>
    <PLAYER NAME="Vasili ARKHIPENKO"/>
    <PLAYER NAME="Vasili RUDENKOV"/>
    <PLAYER NAME="Vasiliy KAPTYUKH"/>
    <PLAYER NAME="Vasily KUZNETSOV"/>
    <PLAYER NAME="Vassilka STOEVA"/>
    <PLAYER NAME="VebjÃ¸rn RODAL"/>
    <PLAYER NAME="Veikko KARVONEN"/>
    <PLAYER NAME="Veniamin SOLDATENKO"/>
    <PLAYER NAME="Venuste NIYONGABO"/>
    <PLAYER NAME="Vera KOLASHNIKOVA-KREPKINA"/>
    <PLAYER NAME="Vera KOMISOVA"/>
    <PLAYER NAME="Vera POSPISILOVA-CECHLOVA"/>
    <PLAYER NAME="Veronica CAMPBELL-BROWN"/>
    <PLAYER NAME="Viktor KRAVCHENKO"/>
    <PLAYER NAME="Viktor MARKIN"/>
    <PLAYER NAME="Viktor RASHCHUPKIN"/>
    <PLAYER NAME="Viktor SANEYEV"/>
    <PLAYER NAME="Viktor TSYBULENKO"/>
    <PLAYER NAME="Vilho Aleksander NIITTYMAA"/>
    <PLAYER NAME="Ville PÃ&#x96;RHÃ&#x96;LÃ&#x84;"/>
    <PLAYER NAME="Ville RITOLA"/>
    <PLAYER NAME="Ville TUULOS"/>
    <PLAYER NAME="Vilmos VARJU"/>
    <PLAYER NAME="Vince MATTHEWS"/>
    <PLAYER NAME="Violeta SZEKELY"/>
    <PLAYER NAME="Virgilijus ALEKNA"/>
    <PLAYER NAME="Vita STYOPINA"/>
    <PLAYER NAME="Vitold KREYER"/>
    <PLAYER NAME="Vivian Jepkemoi CHERUIYOT"/>
    <PLAYER NAME="Vladimir ANDREYEV"/>
    <PLAYER NAME="Vladimir DUBROVSHCHIK"/>
    <PLAYER NAME="Vladimir GOLUBNICHY"/>
    <PLAYER NAME="Vladimir GORYAYEV"/>
    <PLAYER NAME="Vladimir KAZANTSEV"/>
    <PLAYER NAME="Vladimir KISELEV"/>
    <PLAYER NAME="Vladimir KUTS"/>
    <PLAYER NAME="Voitto HELLSTEN"/>
    <PLAYER NAME="Volker BECK"/>
    <PLAYER NAME="Volmari ISO-HOLLO"/>
    <PLAYER NAME="Voula PATOULIDOU"/>
    <PLAYER NAME="Vyacheslav IVANENKO"/>
    <PLAYER NAME="Vyacheslav LYKHO"/>
    <PLAYER NAME="Waldemar CIERPINSKI"/>
    <PLAYER NAME="Walt DAVIS"/>
    <PLAYER NAME="Walter DIX"/>
    <PLAYER NAME="Walter KRÃ&#x9c;GER"/>
    <PLAYER NAME="Walter RANGELEY"/>
    <PLAYER NAME="Walter TEWKSBURY"/>
    <PLAYER NAME="Warren (Rex) Jay CAWLEY"/>
    <PLAYER NAME="Warren WEIR"/>
    <PLAYER NAME="Wayde VAN NIEKERK"/>
    <PLAYER NAME="Wayne COLLETT"/>
    <PLAYER NAME="Wendell MOTTLEY"/>
    <PLAYER NAME="Wenxiu ZHANG"/>
    <PLAYER NAME="Werner LUEG"/>
    <PLAYER NAME="Wesley COE"/>
    <PLAYER NAME="Wilfred BUNGEI"/>
    <PLAYER NAME="Wilhelmina VON BREMEN"/>
    <PLAYER NAME="Will CLAYE"/>
    <PLAYER NAME="Willem SLIJKHUIS"/>
    <PLAYER NAME="Willi HOLDORF"/>
    <PLAYER NAME="William APPLEGARTH"/>
    <PLAYER NAME="William Arthur CARR"/>
    <PLAYER NAME="William CROTHERS"/>
    <PLAYER NAME="William De Hart HUBBARD"/>
    <PLAYER NAME="William HAPPENNY"/>
    <PLAYER NAME="William HOGENSON"/>
    <PLAYER NAME="William HOLLAND"/>
    <PLAYER NAME="William MUTWOL"/>
    <PLAYER NAME="William NIEDER"/>
    <PLAYER NAME="William Preston MILLER"/>
    <PLAYER NAME="William TANUI"/>
    <PLAYER NAME="William VERNER"/>
    <PLAYER NAME="William Waring MILLER"/>
    <PLAYER NAME="William Welles HOYT"/>
    <PLAYER NAME="Willie DAVENPORT"/>
    <PLAYER NAME="Willie MAY"/>
    <PLAYER NAME="Willy SCHÃ&#x84;RER"/>
    <PLAYER NAME="Wilma RUDOLPH"/>
    <PLAYER NAME="Wilson Boit KIPKETER"/>
    <PLAYER NAME="Wilson KIPKETER"/>
    <PLAYER NAME="Wilson KIPRUGUT"/>
    <PLAYER NAME="Wilson Kipsang KIPROTICH"/>
    <PLAYER NAME="Winthrop GRAHAM"/>
    <PLAYER NAME="Wladyslaw KOZAKIEWICZ"/>
    <PLAYER NAME="Wojciech NOWICKI"/>
    <PLAYER NAME="Wolfgang HANISCH"/>
    <PLAYER NAME="Wolfgang REINHARDT"/>
    <PLAYER NAME="Wolfgang SCHMIDT"/>
    <PLAYER NAME="Wolrad EBERLE"/>
    <PLAYER NAME="Wyndham HALSWELLE"/>
    <PLAYER NAME="Wyomia TYUS"/>
    <PLAYER NAME="Xiang LIU"/>
    <PLAYER NAME="Ximena RESTREPO"/>
    <PLAYER NAME="Xinmei SUI"/>
    <PLAYER NAME="Xiuzhi LU"/>
    <PLAYER NAME="Yanfeng LI"/>
    <PLAYER NAME="Yanina KAROLCHIK"/>
    <PLAYER NAME="Yanis LUSIS"/>
    <PLAYER NAME="Yarelys BARRIOS"/>
    <PLAYER NAME="Yarisley SILVA"/>
    <PLAYER NAME="Yaroslav RYBAKOV"/>
    <PLAYER NAME="Yasmani COPELLO"/>
    <PLAYER NAME="Yelena GORCHAKOVA"/>
    <PLAYER NAME="Yelena ISINBAEVA"/>
    <PLAYER NAME="Yelena PROKHOROVA"/>
    <PLAYER NAME="Yelena YELESINA"/>
    <PLAYER NAME="Yelizaveta BAGRYANTSEVA"/>
    <PLAYER NAME="Yevgeni ARZHANOV"/>
    <PLAYER NAME="Yevgeni GAVRILENKO"/>
    <PLAYER NAME="Yevgeni MASKINSKOV"/>
    <PLAYER NAME="Yevgeny Mikhaylovich IVCHENKO"/>
    <PLAYER NAME="Yipsi MORENO"/>
    <PLAYER NAME="Yoel GARCÃ&#x8d;A"/>
    <PLAYER NAME="Yoelvis QUESADA"/>
    <PLAYER NAME="Yohan BLAKE"/>
    <PLAYER NAME="Yordanka BLAGOEVA-DIMITROVA"/>
    <PLAYER NAME="Yordanka DONKOVA"/>
    <PLAYER NAME="Young-Cho HWANG"/>
    <PLAYER NAME="Yuko ARIMORI"/>
    <PLAYER NAME="Yulimar ROJAS"/>
    <PLAYER NAME="Yuliya NESTSIARENKA"/>
    <PLAYER NAME="Yumileidi CUMBA"/>
    <PLAYER NAME="Yunaika CRAWFORD"/>
    <PLAYER NAME="Yunxia QU"/>
    <PLAYER NAME="Yuri KUTSENKO"/>
    <PLAYER NAME="Yuri SEDYKH"/>
    <PLAYER NAME="Yuri TAMM"/>
    <PLAYER NAME="Yuriy BORZAKOVSKIY"/>
    <PLAYER NAME="Yury Nikolayevich LITUYEV"/>
    <PLAYER NAME="Yvette WILLIAMS"/>
    <PLAYER NAME="Zdzislaw KRZYSZKOWIAK"/>
    <PLAYER NAME="Zelin CAI"/>
    <PLAYER NAME="Zersenay TADESE"/>
    <PLAYER NAME="Zhen WANG"/>
    <PLAYER NAME="Zhihong HUANG"/>
    <PLAYER NAME="Zoltan KOVAGO"/>
    <PLAYER NAME="Zuzana HEJNOVA"/>
    <PLAYER NAME="Ã&#x83;â&#x80;&#x93;dÃ&#x83;Â¶n FÃ&#x83;â&#x80;&#x93;LDESSY"/>
    <PLAYER NAME="Ã&#x89;mile CHAMPION"/>
</PLAYERS>
```
**7. lekérdezés:**

A lekérdezés egy olyan XML dokumentumot állít elő, amely kilistázza, hogy melyik versenyző, hányszor
vett részt az olimpián.

Kapcsolódó [XML Séma](./xml+schema/7_feladat.xsd)

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
            <PLAYERS ALL="{count($names)}">
                {
                    for $game in $json?games?*
                        for $result in $game?results?*
                        group by $name := $result?name
                        let $count := fn:count($result)
                        order by $name
                        return <PLAYER NAME="{$name}" COUNT="{$count}"/>
                }
            </PLAYERS>
        }}
```
**Eredmény:**
```XML
<PLAYERS ALL="1681">
    <PLAYER NAME="" COUNT="230"/>
    <PLAYER NAME="Abdalaati IGUIDER" COUNT="1"/>
    <PLAYER NAME="Abderrahmane HAMMAD" COUNT="1"/>
    <PLAYER NAME="Abdesiem RHADI BEN ABDESSELEM" COUNT="1"/>
    <PLAYER NAME="Abdon PAMICH" COUNT="2"/>
    <PLAYER NAME="Abdoulaye SEYE" COUNT="1"/>
    <PLAYER NAME="Abebe BIKILA" COUNT="2"/>
    <PLAYER NAME="Abel KIRUI" COUNT="1"/>
    <PLAYER NAME="Abel KIVIAT" COUNT="1"/>
    <PLAYER NAME="Abel Kiprop MUTAI" COUNT="1"/>
    <PLAYER NAME="Adalberts BUBENKO" COUNT="1"/>
    <PLAYER NAME="Adam GUNN" COUNT="1"/>
    <PLAYER NAME="Adam NELSON" COUNT="2"/>
    <PLAYER NAME="Addis ABEBE" COUNT="1"/>
    <PLAYER NAME="Adhemar DA SILVA" COUNT="1"/>
    <PLAYER NAME="Adolfo CONSOLINI" COUNT="1"/>
    <PLAYER NAME="Aigars FADEJEVS" COUNT="1"/>
    <PLAYER NAME="Ainars KOVALS" COUNT="1"/>
    <PLAYER NAME="Aki JÃ&#x84;RVINEN" COUNT="2"/>
    <PLAYER NAME="Al BATES" COUNT="1"/>
    <PLAYER NAME="Al OERTER" COUNT="3"/>
    <PLAYER NAME="Alain MIMOUN" COUNT="4"/>
    <PLAYER NAME="Alajos SZOKOLYI" COUNT="1"/>
    <PLAYER NAME="Albert CORAY" COUNT="1"/>
    <PLAYER NAME="Albert GUTTERSON" COUNT="1"/>
    <PLAYER NAME="Albert HILL" COUNT="2"/>
    <PLAYER NAME="Albert TYLER" COUNT="1"/>
    <PLAYER NAME="Alberto COVA" COUNT="1"/>
    <PLAYER NAME="Alberto JUANTORENA" COUNT="2"/>
    <PLAYER NAME="Albin LERMUSIAUX" COUNT="1"/>
    <PLAYER NAME="Albin STENROOS" COUNT="2"/>
    <PLAYER NAME="Alejandro CASAÃ&#x91;AS" COUNT="2"/>
    <PLAYER NAME="Aleksander TAMMERT" COUNT="1"/>
    <PLAYER NAME="Aleksandr ANUFRIYEV" COUNT="1"/>
    <PLAYER NAME="Aleksandr BARYSHNIKOV" COUNT="1"/>
    <PLAYER NAME="Aleksandr MAKAROV" COUNT="1"/>
    <PLAYER NAME="Aleksandr PUCHKOV" COUNT="1"/>
    <PLAYER NAME="Aleksandra CHUDINA" COUNT="3"/>
    <PLAYER NAME="Aleksei SPIRIDONOV" COUNT="1"/>
    <PLAYER NAME="Aleksey VOYEVODIN" COUNT="1"/>
    <PLAYER NAME="Alessandro ANDREI" COUNT="1"/>
    <PLAYER NAME="Alessandro LAMBRUSCHINI" COUNT="1"/>
    <PLAYER NAME="Alex SCHWAZER" COUNT="1"/>
    <PLAYER NAME="Alex WILSON" COUNT="2"/>
    <PLAYER NAME="Alexander KLUMBERG-KOLMPERE" COUNT="1"/>
    <PLAYER NAME="Alexandre TUFFERI" COUNT="1"/>
    <PLAYER NAME="Alfred Carleten GILBERT" COUNT="1"/>
    <PLAYER NAME="Alfred DOMPERT" COUNT="1"/>
    <PLAYER NAME="Alfred Kirwa YEGO" COUNT="1"/>
    <PLAYER NAME="Alfred TYSOE" COUNT="1"/>
    <PLAYER NAME="Ali EZZINE" COUNT="1"/>
    <PLAYER NAME="Ali SAIDI-SIEF" COUNT="1"/>
    <PLAYER NAME="Alice BROWN" COUNT="1"/>
    <PLAYER NAME="Alice COACHMAN" COUNT="1"/>
    <PLAYER NAME="Allan LAWRENCE" COUNT="1"/>
    <PLAYER NAME="Allan WELLS" COUNT="2"/>
    <PLAYER NAME="Allen JOHNSON" COUNT="1"/>
    <PLAYER NAME="Allen WOODRING" COUNT="1"/>
    <PLAYER NAME="Allyson FELIX" COUNT="4"/>
    <PLAYER NAME="Alma RICHARDS" COUNT="1"/>
    <PLAYER NAME="Almaz AYANA" COUNT="2"/>
    <PLAYER NAME="Alonzo BABERS" COUNT="1"/>
    <PLAYER NAME="Alvah MEYER" COUNT="1"/>
    <PLAYER NAME="Alvin HARRISON" COUNT="1"/>
    <PLAYER NAME="Alvin KRAENZLEIN" COUNT="2"/>
    <PLAYER NAME="Amos BIWOTT" COUNT="1"/>
    <PLAYER NAME="Ana Fidelia QUIROT" COUNT="2"/>
    <PLAYER NAME="Ana GUEVARA" COUNT="1"/>
    <PLAYER NAME="Anastasia KELESIDOU" COUNT="2"/>
    <PLAYER NAME="Anatoli BONDARCHUK" COUNT="1"/>
    <PLAYER NAME="Anatoly MIKHAYLOV" COUNT="1"/>
    <PLAYER NAME="Anders GARDERUD" COUNT="1"/>
    <PLAYER NAME="Andre DE GRASSE" COUNT="2"/>
    <PLAYER NAME="Andreas THORKILDSEN" COUNT="2"/>
    <PLAYER NAME="Andrei KRAUCHANKA" COUNT="1"/>
    <PLAYER NAME="Andrei TIVONTCHIK" COUNT="1"/>
    <PLAYER NAME="Andrey ABDUVALIEV" COUNT="1"/>
    <PLAYER NAME="Andrey PERLOV" COUNT="1"/>
    <PLAYER NAME="Andrey SILNOV" COUNT="1"/>
    <PLAYER NAME="Andrzej BADENSKI" COUNT="1"/>
    <PLAYER NAME="Andy STANFIELD" COUNT="2"/>
    <PLAYER NAME="Angela NEMETH" COUNT="1"/>
    <PLAYER NAME="Angela VOIGT" COUNT="1"/>
    <PLAYER NAME="Angelo TAYLOR" COUNT="2"/>
    <PLAYER NAME="Anier GARCIA" COUNT="2"/>
    <PLAYER NAME="Anita MARTON" COUNT="1"/>
    <PLAYER NAME="Anita WLODARCZYK" COUNT="2"/>
    <PLAYER NAME="Anke BEHMER" COUNT="1"/>
    <PLAYER NAME="Ann Marise CHAMBERLAIN" COUNT="1"/>
    <PLAYER NAME="Ann PACKER" COUNT="2"/>
    <PLAYER NAME="Anna CHICHEROVA" COUNT="1"/>
    <PLAYER NAME="Anna ROGOWSKA" COUNT="1"/>
    <PLAYER NAME="Annegret RICHTER-IRRGANG" COUNT="2"/>
    <PLAYER NAME="Annelie EHRHARDT" COUNT="1"/>
    <PLAYER NAME="Antal KISS" COUNT="1"/>
    <PLAYER NAME="Antal RÃ&#x93;KA" COUNT="1"/>
    <PLAYER NAME="Antanas MIKENAS" COUNT="1"/>
    <PLAYER NAME="Antonio MCKAY" COUNT="1"/>
    <PLAYER NAME="Antonio PENALVER ASENSIO" COUNT="1"/>
    <PLAYER NAME="Antti RUUSKANEN" COUNT="1"/>
    <PLAYER NAME="AntÃ³nio LEITÃ&#x83;O" COUNT="1"/>
    <PLAYER NAME="Archibald Franklin WILLIAMS" COUNT="1"/>
    <PLAYER NAME="Archie HAHN" COUNT="2"/>
    <PLAYER NAME="Ardalion IGNATYEV" COUNT="1"/>
    <PLAYER NAME="Argentina MENIS" COUNT="1"/>
    <PLAYER NAME="Aries MERRITT" COUNT="1"/>
    <PLAYER NAME="Armas TAIPALE" COUNT="1"/>
    <PLAYER NAME="Armas TOIVONEN" COUNT="1"/>
    <PLAYER NAME="Armin HARY" COUNT="1"/>
    <PLAYER NAME="Arne HALSE" COUNT="1"/>
    <PLAYER NAME="Arnie ROBINSON" COUNT="1"/>
    <PLAYER NAME="Arnold JACKSON" COUNT="1"/>
    <PLAYER NAME="Arnoldo DEVONISH" COUNT="1"/>
    <PLAYER NAME="Arsi HARJU" COUNT="1"/>
    <PLAYER NAME="Arthur BARNARD" COUNT="1"/>
    <PLAYER NAME="Arthur BLAKE" COUNT="1"/>
    <PLAYER NAME="Arthur JONATH" COUNT="1"/>
    <PLAYER NAME="Arthur NEWTON" COUNT="2"/>
    <PLAYER NAME="Arthur PORRITT" COUNT="1"/>
    <PLAYER NAME="Arthur SCHWAB" COUNT="1"/>
    <PLAYER NAME="Arthur SHAW" COUNT="1"/>
    <PLAYER NAME="Arthur WINT" COUNT="3"/>
    <PLAYER NAME="Arto BRYGGARE" COUNT="1"/>
    <PLAYER NAME="Arto HÃ&#x84;RKÃ&#x96;NEN" COUNT="1"/>
    <PLAYER NAME="Artur PARTYKA" COUNT="2"/>
    <PLAYER NAME="Arvo ASKOLA" COUNT="1"/>
    <PLAYER NAME="Asbel Kipruto KIPROP" COUNT="1"/>
    <PLAYER NAME="Ashley SPENCER" COUNT="1"/>
    <PLAYER NAME="Ashton EATON" COUNT="2"/>
    <PLAYER NAME="Assefa MEZGEBU" COUNT="1"/>
    <PLAYER NAME="Astrid KUMBERNUSS" COUNT="2"/>
    <PLAYER NAME="Athanasia TSOUMELEKA" COUNT="1"/>
    <PLAYER NAME="Ato BOLDON" COUNT="4"/>
    <PLAYER NAME="Audrey PATTERSON" COUNT="1"/>
    <PLAYER NAME="Audrey WILLIAMSON" COUNT="1"/>
    <PLAYER NAME="Audun BOYSEN" COUNT="1"/>
    <PLAYER NAME="August DESCH" COUNT="1"/>
    <PLAYER NAME="Austra SKUJYTE" COUNT="1"/>
    <PLAYER NAME="BalÃ¡zs KISS" COUNT="1"/>
    <PLAYER NAME="Barbara FERRELL" COUNT="1"/>
    <PLAYER NAME="Barbora SPOTAKOVA" COUNT="3"/>
    <PLAYER NAME="Barney EWELL" COUNT="2"/>
    <PLAYER NAME="Barry MAGEE" COUNT="1"/>
    <PLAYER NAME="Basil HEATLEY" COUNT="1"/>
    <PLAYER NAME="Ben JIPCHO" COUNT="1"/>
    <PLAYER NAME="Ben JOHNSON" COUNT="1"/>
    <PLAYER NAME="Benita FITZGERALD-BROWN" COUNT="1"/>
    <PLAYER NAME="Benjamin Bangs EASTMAN" COUNT="1"/>
    <PLAYER NAME="Benjamin KOGO" COUNT="1"/>
    <PLAYER NAME="Bernard LAGAT" COUNT="2"/>
    <PLAYER NAME="Bernard WILLIAMS III" COUNT="1"/>
    <PLAYER NAME="Bernardo SEGURA" COUNT="1"/>
    <PLAYER NAME="Bernd KANNENBERG" COUNT="1"/>
    <PLAYER NAME="Bershawn JACKSON" COUNT="1"/>
    <PLAYER NAME="Bertha BROUWER" COUNT="1"/>
    <PLAYER NAME="Bertil ALBERTSSON" COUNT="1"/>
    <PLAYER NAME="Bertil OHLSON" COUNT="1"/>
    <PLAYER NAME="Bertil UGGLA" COUNT="1"/>
    <PLAYER NAME="Betty CUTHBERT" COUNT="3"/>
    <PLAYER NAME="Betty HEIDLER" COUNT="1"/>
    <PLAYER NAME="Beverly MCDONALD" COUNT="1"/>
    <PLAYER NAME="Bevil RUDD" COUNT="2"/>
    <PLAYER NAME="Bill DELLINGER" COUNT="1"/>
    <PLAYER NAME="Bill PORTER" COUNT="1"/>
    <PLAYER NAME="Bill TOOMEY" COUNT="1"/>
    <PLAYER NAME="Billy MILLS" COUNT="1"/>
    <PLAYER NAME="Bin DONG" COUNT="1"/>
    <PLAYER NAME="Birute KALEDIENE" COUNT="1"/>
    <PLAYER NAME="Bjorn OTTO" COUNT="1"/>
    <PLAYER NAME="Blaine LINDGREN" COUNT="1"/>
    <PLAYER NAME="Blanka VLASIC" COUNT="2"/>
    <PLAYER NAME="Blessing OKAGBARE" COUNT="1"/>
    <PLAYER NAME="Bo GUSTAFSSON" COUNT="1"/>
    <PLAYER NAME="Bob HAYES" COUNT="1"/>
    <PLAYER NAME="Bob MATHIAS" COUNT="2"/>
    <PLAYER NAME="Bob RICHARDS" COUNT="1"/>
    <PLAYER NAME="Bobby MORROW" COUNT="2"/>
    <PLAYER NAME="Bodo TÃ&#x9c;MMLER" COUNT="1"/>
    <PLAYER NAME="Bohdan BONDARENKO" COUNT="1"/>
    <PLAYER NAME="Bong Ju LEE" COUNT="1"/>
    <PLAYER NAME="Boniface MUCHERU" COUNT="1"/>
    <PLAYER NAME="BoughÃ¨ra EL OUAFI" COUNT="1"/>
    <PLAYER NAME="Brahim LAHLAFI" COUNT="1"/>
    <PLAYER NAME="Brenda JONES" COUNT="1"/>
    <PLAYER NAME="Brendan FOSTER" COUNT="1"/>
    <PLAYER NAME="Brian Lee DIEMER" COUNT="1"/>
    <PLAYER NAME="Brianna ROLLINS" COUNT="1"/>
    <PLAYER NAME="Brianne THEISEN EATON" COUNT="1"/>
    <PLAYER NAME="Brigetta BARRETT" COUNT="1"/>
    <PLAYER NAME="Brigita BUKOVEC" COUNT="1"/>
    <PLAYER NAME="Brigitte WUJAK" COUNT="1"/>
    <PLAYER NAME="Brimin Kiprop KIPRUTO" COUNT="2"/>
    <PLAYER NAME="Brittney REESE" COUNT="2"/>
    <PLAYER NAME="Bronislaw MALINOWSKI" COUNT="2"/>
    <PLAYER NAME="Bruce JENNER" COUNT="1"/>
    <PLAYER NAME="Bruno JUNK" COUNT="1"/>
    <PLAYER NAME="Bruno SÃ&#x96;DERSTRÃ&#x96;M" COUNT="1"/>
    <PLAYER NAME="Brutus HAMILTON" COUNT="1"/>
    <PLAYER NAME="Bryan CLAY" COUNT="2"/>
    <PLAYER NAME="Bud HOUSER" COUNT="2"/>
    <PLAYER NAME="BÃ¤rbel ECKERT-WÃ&#x96;CKEL" COUNT="2"/>
    <PLAYER NAME="Calvin BRICKER" COUNT="2"/>
    <PLAYER NAME="Calvin DAVIS" COUNT="1"/>
    <PLAYER NAME="Carl Albert ANDERSEN" COUNT="1"/>
    <PLAYER NAME="Carl KAUFMANN" COUNT="1"/>
    <PLAYER NAME="Carl LEWIS" COUNT="4"/>
    <PLAYER NAME="Carlos LOPES" COUNT="2"/>
    <PLAYER NAME="Carlos MERCENARIO" COUNT="1"/>
    <PLAYER NAME="Carmelita JETER" COUNT="2"/>
    <PLAYER NAME="Carolina KLUFT" COUNT="1"/>
    <PLAYER NAME="Caster SEMENYA" COUNT="2"/>
    <PLAYER NAME="Caterine IBARGUEN" COUNT="2"/>
    <PLAYER NAME="Catherine Laverne MCMILLAN" COUNT="1"/>
    <PLAYER NAME="Catherine NDEREBA" COUNT="2"/>
    <PLAYER NAME="Cathy FREEMAN" COUNT="2"/>
    <PLAYER NAME="Chandra CHEESEBOROUGH" COUNT="1"/>
    <PLAYER NAME="Charles AUSTIN" COUNT="1"/>
    <PLAYER NAME="Charles BACON" COUNT="1"/>
    <PLAYER NAME="Charles BENNETT" COUNT="1"/>
    <PLAYER NAME="Charles DVORAK" COUNT="1"/>
    <PLAYER NAME="Charles GMELIN" COUNT="1"/>
    <PLAYER NAME="Charles HEFFERON" COUNT="1"/>
    <PLAYER NAME="Charles Hewes Jr. MOORE" COUNT="1"/>
    <PLAYER NAME="Charles JACOBS" COUNT="1"/>
    <PLAYER NAME="Charles JENKINS" COUNT="1"/>
    <PLAYER NAME="Charles LOMBERG" COUNT="1"/>
    <PLAYER NAME="Charles PADDOCK" COUNT="3"/>
    <PLAYER NAME="Charles REIDPATH" COUNT="1"/>
    <PLAYER NAME="Charles SIMPKINS" COUNT="1"/>
    <PLAYER NAME="Charles SPEDDING" COUNT="1"/>
    <PLAYER NAME="Charlie GREENE" COUNT="1"/>
    <PLAYER NAME="Chioma AJUNWA" COUNT="1"/>
    <PLAYER NAME="Chris HUFFINS" COUNT="1"/>
    <PLAYER NAME="Christa STUBNICK" COUNT="2"/>
    <PLAYER NAME="Christian CANTWELL" COUNT="1"/>
    <PLAYER NAME="Christian OLSSON" COUNT="1"/>
    <PLAYER NAME="Christian SCHENK" COUNT="1"/>
    <PLAYER NAME="Christian TAYLOR" COUNT="2"/>
    <PLAYER NAME="Christian W. GITSHAM" COUNT="1"/>
    <PLAYER NAME="Christiane STOLL-WARTENBERG" COUNT="1"/>
    <PLAYER NAME="Christina BREHMER-LATHAN" COUNT="2"/>
    <PLAYER NAME="Christina OBERGFOLL" COUNT="2"/>
    <PLAYER NAME="Christine OHURUOGU" COUNT="2"/>
    <PLAYER NAME="Christoph HARTING" COUNT="1"/>
    <PLAYER NAME="Christoph HÃ&#x96;HNE" COUNT="1"/>
    <PLAYER NAME="Christophe LEMAITRE" COUNT="1"/>
    <PLAYER NAME="Christopher William BRASHER" COUNT="1"/>
    <PLAYER NAME="Chuan-Kwang YANG" COUNT="1"/>
    <PLAYER NAME="Chuhei NAMBU" COUNT="2"/>
    <PLAYER NAME="Chunxiu ZHOU" COUNT="1"/>
    <PLAYER NAME="Clarence CHILDS" COUNT="1"/>
    <PLAYER NAME="Clarence DEMAR" COUNT="1"/>
    <PLAYER NAME="Claudia LOSCH" COUNT="1"/>
    <PLAYER NAME="Clayton MURPHY" COUNT="1"/>
    <PLAYER NAME="Clifton Emmett CUSHMAN" COUNT="1"/>
    <PLAYER NAME="Clyde SCOTT" COUNT="1"/>
    <PLAYER NAME="Colette BESSON" COUNT="1"/>
    <PLAYER NAME="Conseslus KIPRUTO" COUNT="1"/>
    <PLAYER NAME="Constantina TOMESCU" COUNT="1"/>
    <PLAYER NAME="Cornelius LEAHY" COUNT="1"/>
    <PLAYER NAME="Cornelius WALSH" COUNT="1"/>
    <PLAYER NAME="Craig DIXON" COUNT="1"/>
    <PLAYER NAME="Cristina COJOCARU" COUNT="1"/>
    <PLAYER NAME="Cy YOUNG" COUNT="1"/>
    <PLAYER NAME="Dafne SCHIPPERS" COUNT="1"/>
    <PLAYER NAME="Dainis KULA" COUNT="1"/>
    <PLAYER NAME="Daley THOMPSON" COUNT="2"/>
    <PLAYER NAME="Dalilah MUHAMMAD" COUNT="1"/>
    <PLAYER NAME="Dallas LONG" COUNT="2"/>
    <PLAYER NAME="Damian WARNER" COUNT="1"/>
    <PLAYER NAME="Dan O'BRIEN" COUNT="1"/>
    <PLAYER NAME="Dana INGROVA-ZATOPKOVA" COUNT="2"/>
    <PLAYER NAME="Dane BIRD-SMITH" COUNT="1"/>
    <PLAYER NAME="Daniel BAUTISTA ROCHA" COUNT="1"/>
    <PLAYER NAME="Daniel FRANK" COUNT="1"/>
    <PLAYER NAME="Daniel JASINSKI" COUNT="1"/>
    <PLAYER NAME="Daniel KELLY" COUNT="1"/>
    <PLAYER NAME="Daniel KINSEY" COUNT="1"/>
    <PLAYER NAME="Daniel PLAZA" COUNT="1"/>
    <PLAYER NAME="Daniela COSTIAN" COUNT="1"/>
    <PLAYER NAME="Daniil Sergeyevich BURKENYA" COUNT="1"/>
    <PLAYER NAME="Danny HARRIS" COUNT="1"/>
    <PLAYER NAME="Danny MCFARLANE" COUNT="1"/>
    <PLAYER NAME="Daphne HASENJAGER" COUNT="1"/>
    <PLAYER NAME="Darren CAMPBELL" COUNT="1"/>
    <PLAYER NAME="Darrow Clarence HOOPER" COUNT="1"/>
    <PLAYER NAME="Dave JOHNSON" COUNT="1"/>
    <PLAYER NAME="Dave LAUT" COUNT="1"/>
    <PLAYER NAME="Dave SIME" COUNT="1"/>
    <PLAYER NAME="Dave STEEN" COUNT="1"/>
    <PLAYER NAME="David George BURGHLEY" COUNT="1"/>
    <PLAYER NAME="David HALL" COUNT="1"/>
    <PLAYER NAME="David HEMERY" COUNT="2"/>
    <PLAYER NAME="David James WOTTLE" COUNT="1"/>
    <PLAYER NAME="David Lawson WEILL" COUNT="1"/>
    <PLAYER NAME="David Lekuta RUDISHA" COUNT="2"/>
    <PLAYER NAME="David NEVILLE" COUNT="1"/>
    <PLAYER NAME="David OLIVER" COUNT="1"/>
    <PLAYER NAME="David OTTLEY" COUNT="1"/>
    <PLAYER NAME="David PAYNE" COUNT="1"/>
    <PLAYER NAME="David POWER" COUNT="1"/>
    <PLAYER NAME="David STORL" COUNT="1"/>
    <PLAYER NAME="Davis KAMOGA" COUNT="1"/>
    <PLAYER NAME="Dawn HARPER" COUNT="2"/>
    <PLAYER NAME="Dayron ROBLES" COUNT="1"/>
    <PLAYER NAME="Debbie FERGUSON-MCKENZIE" COUNT="1"/>
    <PLAYER NAME="DeeDee TROTTER" COUNT="1"/>
    <PLAYER NAME="Deena KASTOR" COUNT="1"/>
    <PLAYER NAME="Dejen GEBREMESKEL" COUNT="1"/>
    <PLAYER NAME="Delfo CABRERA" COUNT="1"/>
    <PLAYER NAME="Denia CABALLERO" COUNT="1"/>
    <PLAYER NAME="Denis HORGAN" COUNT="1"/>
    <PLAYER NAME="Denis KAPUSTIN" COUNT="1"/>
    <PLAYER NAME="Denis NIZHEGORODOV" COUNT="2"/>
    <PLAYER NAME="Denise LEWIS" COUNT="2"/>
    <PLAYER NAME="Dennis MITCHELL" COUNT="1"/>
    <PLAYER NAME="Deon Marie HEMMINGS" COUNT="2"/>
    <PLAYER NAME="Derartu TULU" COUNT="3"/>
    <PLAYER NAME="Derek DROUIN" COUNT="2"/>
    <PLAYER NAME="Derek IBBOTSON" COUNT="1"/>
    <PLAYER NAME="Derek JOHNSON" COUNT="1"/>
    <PLAYER NAME="Derrick ADKINS" COUNT="1"/>
    <PLAYER NAME="Derrick BREW" COUNT="1"/>
    <PLAYER NAME="Dick Theodorus QUAX" COUNT="1"/>
    <PLAYER NAME="Dieter BAUMANN" COUNT="1"/>
    <PLAYER NAME="Dieter LINDNER" COUNT="1"/>
    <PLAYER NAME="Dilshod NAZAROV" COUNT="1"/>
    <PLAYER NAME="Dimitri BASCOU" COUNT="1"/>
    <PLAYER NAME="Dimitrios GOLEMIS" COUNT="1"/>
    <PLAYER NAME="Ding CHEN" COUNT="1"/>
    <PLAYER NAME="Djabir SAID GUERNI" COUNT="1"/>
    <PLAYER NAME="Dmitriy KARPOV" COUNT="1"/>
    <PLAYER NAME="Doina MELINTE" COUNT="2"/>
    <PLAYER NAME="Don BRAGG" COUNT="1"/>
    <PLAYER NAME="Don LAZ" COUNT="1"/>
    <PLAYER NAME="Donald FINLAY" COUNT="2"/>
    <PLAYER NAME="Donald James THOMPSON" COUNT="1"/>
    <PLAYER NAME="Donald LIPPINCOTT" COUNT="2"/>
    <PLAYER NAME="Donald QUARRIE" COUNT="3"/>
    <PLAYER NAME="Donovan BAILEY" COUNT="1"/>
    <PLAYER NAME="Dorothy HALL" COUNT="1"/>
    <PLAYER NAME="Dorothy HYMAN" COUNT="2"/>
    <PLAYER NAME="Dorothy ODAM" COUNT="2"/>
    <PLAYER NAME="Dorothy SHIRLEY" COUNT="1"/>
    <PLAYER NAME="Douglas LOWE" COUNT="2"/>
    <PLAYER NAME="Douglas WAKIIHURI" COUNT="1"/>
    <PLAYER NAME="Duncan GILLIS" COUNT="1"/>
    <PLAYER NAME="Duncan MCNAUGHTON" COUNT="1"/>
    <PLAYER NAME="Duncan WHITE" COUNT="1"/>
    <PLAYER NAME="Dwayne Eugene EVANS" COUNT="1"/>
    <PLAYER NAME="Dwight PHILLIPS" COUNT="1"/>
    <PLAYER NAME="Dwight STONES" COUNT="1"/>
    <PLAYER NAME="Dylan ARMSTRONG" COUNT="1"/>
    <PLAYER NAME="Earl EBY" COUNT="1"/>
    <PLAYER NAME="Earl JONES" COUNT="1"/>
    <PLAYER NAME="Earl THOMSON" COUNT="1"/>
    <PLAYER NAME="Earlene BROWN" COUNT="1"/>
    <PLAYER NAME="Eddie SOUTHERN" COUNT="1"/>
    <PLAYER NAME="Eddie TOLAN" COUNT="2"/>
    <PLAYER NAME="Eddy OTTOZ" COUNT="1"/>
    <PLAYER NAME="Edera CORDIALE-GENTILE" COUNT="1"/>
    <PLAYER NAME="Edith MCGUIRE" COUNT="2"/>
    <PLAYER NAME="Edvard LARSEN" COUNT="1"/>
    <PLAYER NAME="Edvin WIDE" COUNT="4"/>
    <PLAYER NAME="Edward ARCHIBALD" COUNT="1"/>
    <PLAYER NAME="Edward Barton HAMM" COUNT="1"/>
    <PLAYER NAME="Edward COOK" COUNT="1"/>
    <PLAYER NAME="Edward LINDBERG" COUNT="1"/>
    <PLAYER NAME="Edward Lansing GORDON" COUNT="1"/>
    <PLAYER NAME="Edward Orval GOURDIN" COUNT="1"/>
    <PLAYER NAME="Edwin Cheruiyot SOI" COUNT="1"/>
    <PLAYER NAME="Edwin FLACK" COUNT="2"/>
    <PLAYER NAME="Edwin MOSES" COUNT="2"/>
    <PLAYER NAME="Edwin ROBERTS" COUNT="1"/>
    <PLAYER NAME="Eeles LANDSTRÃ&#x96;M" COUNT="1"/>
    <PLAYER NAME="Eero BERG" COUNT="1"/>
    <PLAYER NAME="Ehsan HADADI" COUNT="1"/>
    <PLAYER NAME="Eino PENTTILÃ&#x84;" COUNT="1"/>
    <PLAYER NAME="Eino PURJE" COUNT="1"/>
    <PLAYER NAME="Ejegayehu DIBABA" COUNT="1"/>
    <PLAYER NAME="Ekaterina POISTOGOVA" COUNT="1"/>
    <PLAYER NAME="Ekaterini STEFANIDI" COUNT="1"/>
    <PLAYER NAME="Ekaterini THANOU" COUNT="1"/>
    <PLAYER NAME="Elaine THOMPSON" COUNT="2"/>
    <PLAYER NAME="Elana MEYER" COUNT="1"/>
    <PLAYER NAME="Elena LASHMANOVA" COUNT="1"/>
    <PLAYER NAME="Elena SLESARENKO" COUNT="1"/>
    <PLAYER NAME="Elena SOKOLOVA" COUNT="1"/>
    <PLAYER NAME="Elfi ZINN" COUNT="1"/>
    <PLAYER NAME="Elfriede KAUN" COUNT="1"/>
    <PLAYER NAME="Elias KATZ" COUNT="1"/>
    <PLAYER NAME="Elisa RIGAUDO" COUNT="1"/>
    <PLAYER NAME="Eliud Kipchoge ROTICH" COUNT="3"/>
    <PLAYER NAME="Eliza MCCARTNEY" COUNT="1"/>
    <PLAYER NAME="Elizabeth ROBINSON" COUNT="1"/>
    <PLAYER NAME="Ellen BRAUMÃ&#x9c;LLER" COUNT="1"/>
    <PLAYER NAME="Ellen STROPAHL-STREIDT" COUNT="1"/>
    <PLAYER NAME="Ellen VAN LANGEN" COUNT="1"/>
    <PLAYER NAME="Ellery CLARK" COUNT="2"/>
    <PLAYER NAME="Ellina ZVEREVA" COUNT="2"/>
    <PLAYER NAME="Elvan ABEYLEGESSE" COUNT="2"/>
    <PLAYER NAME="Elvira OZOLINA" COUNT="1"/>
    <PLAYER NAME="Elzbieta KRZESINSKA" COUNT="1"/>
    <PLAYER NAME="Emerson NORTON" COUNT="1"/>
    <PLAYER NAME="Emiel PUTTEMANS" COUNT="1"/>
    <PLAYER NAME="Emil BREITKREUTZ" COUNT="1"/>
    <PLAYER NAME="Emil ZÃ&#x81;TOPEK" COUNT="5"/>
    <PLAYER NAME="Emilio LUNGHI" COUNT="1"/>
    <PLAYER NAME="Emma COBURN" COUNT="1"/>
    <PLAYER NAME="Emmanuel McDONALD BAILEY" COUNT="1"/>
    <PLAYER NAME="Enrique FIGUEROLA" COUNT="1"/>
    <PLAYER NAME="Eric BACKMAN" COUNT="1"/>
    <PLAYER NAME="Eric LEMMING" COUNT="2"/>
    <PLAYER NAME="Eric LIDDELL" COUNT="2"/>
    <PLAYER NAME="Eric SVENSSON" COUNT="1"/>
    <PLAYER NAME="Erick BARRONDO" COUNT="1"/>
    <PLAYER NAME="Erick WAINAINA" COUNT="2"/>
    <PLAYER NAME="Erik ALMLÃ&#x96;F" COUNT="1"/>
    <PLAYER NAME="Erik BYLÃ&#x89;HN" COUNT="1"/>
    <PLAYER NAME="Erik KYNARD" COUNT="1"/>
    <PLAYER NAME="Erki NOOL" COUNT="1"/>
    <PLAYER NAME="Erkka WILEN" COUNT="1"/>
    <PLAYER NAME="Ernest HARPER" COUNT="1"/>
    <PLAYER NAME="Ernesto AMBROSINI" COUNT="1"/>
    <PLAYER NAME="Ernesto CANTO" COUNT="1"/>
    <PLAYER NAME="Ernst FAST" COUNT="1"/>
    <PLAYER NAME="Ernst LARSEN" COUNT="1"/>
    <PLAYER NAME="Ernst SCHULTZ" COUNT="1"/>
    <PLAYER NAME="Ervin HALL" COUNT="1"/>
    <PLAYER NAME="Esfira DOLCHENKO-KRACHEVSKAYA" COUNT="1"/>
    <PLAYER NAME="Eshetu TURA" COUNT="1"/>
    <PLAYER NAME="Esref APAK" COUNT="1"/>
    <PLAYER NAME="Esther BRAND" COUNT="1"/>
    <PLAYER NAME="Ethel SMITH" COUNT="1"/>
    <PLAYER NAME="Etienne GAILLY" COUNT="1"/>
    <PLAYER NAME="Eugene OBERST" COUNT="1"/>
    <PLAYER NAME="Eunice JEPKORIR" COUNT="1"/>
    <PLAYER NAME="Eunice Jepkirui KIRWA" COUNT="1"/>
    <PLAYER NAME="Eva DAWES" COUNT="1"/>
    <PLAYER NAME="Eva JANKO-EGGER" COUNT="1"/>
    <PLAYER NAME="Evan JAGER" COUNT="1"/>
    <PLAYER NAME="Evangelos DAMASKOS" COUNT="1"/>
    <PLAYER NAME="Evelin SCHLAAK-JAHL" COUNT="1"/>
    <PLAYER NAME="Evelyn ASHFORD" COUNT="1"/>
    <PLAYER NAME="Evgeniy LUKYANENKO" COUNT="1"/>
    <PLAYER NAME="Ewa KLOBUKOWSKA" COUNT="1"/>
    <PLAYER NAME="Ezekiel KEMBOI" COUNT="2"/>
    <PLAYER NAME="Fabrizio DONATO" COUNT="1"/>
    <PLAYER NAME="Faina MELNIK" COUNT="1"/>
    <PLAYER NAME="Faith Chepngetich KIPYEGON" COUNT="1"/>
    <PLAYER NAME="Falilat OGUNKOYA" COUNT="1"/>
    <PLAYER NAME="Fani KHALKIA" COUNT="1"/>
    <PLAYER NAME="Fanny BLANKERS-KOEN" COUNT="2"/>
    <PLAYER NAME="Fanny ROSENFELD" COUNT="1"/>
    <PLAYER NAME="Fatuma ROBA" COUNT="1"/>
    <PLAYER NAME="Felix SANCHEZ" COUNT="2"/>
    <PLAYER NAME="Fermin CACHO RUIZ" COUNT="2"/>
    <PLAYER NAME="Fernanda RIBEIRO" COUNT="2"/>
    <PLAYER NAME="Feyisa LILESA" COUNT="1"/>
    <PLAYER NAME="Filbert BAYI" COUNT="1"/>
    <PLAYER NAME="Fiona MAY" COUNT="2"/>
    <PLAYER NAME="Fita BAYISSA" COUNT="1"/>
    <PLAYER NAME="Fita LOVIN" COUNT="1"/>
    <PLAYER NAME="Florence GRIFFITH JOYNER" COUNT="1"/>
    <PLAYER NAME="Florenta CRACIUNESCU" COUNT="1"/>
    <PLAYER NAME="Florian SCHWARTHOFF" COUNT="1"/>
    <PLAYER NAME="Floyd SIMMONS" COUNT="2"/>
    <PLAYER NAME="Forrest SMITHSON" COUNT="1"/>
    <PLAYER NAME="Forrest TOWNS" COUNT="1"/>
    <PLAYER NAME="Francine NIYONSABA" COUNT="1"/>
    <PLAYER NAME="Francis LANE" COUNT="1"/>
    <PLAYER NAME="Francis OBIKWELU" COUNT="1"/>
    <PLAYER NAME="Francisco Javier FERNANDEZ" COUNT="1"/>
    <PLAYER NAME="Francoise MBANGO ETONE" COUNT="2"/>
    <PLAYER NAME="Franjo MIHALIC" COUNT="1"/>
    <PLAYER NAME="Frank BAUMGARTL" COUNT="1"/>
    <PLAYER NAME="Frank BUSEMANN" COUNT="1"/>
    <PLAYER NAME="Frank CUHEL" COUNT="1"/>
    <PLAYER NAME="Frank Charles SHORTER" COUNT="2"/>
    <PLAYER NAME="Frank FREDERICKS" COUNT="4"/>
    <PLAYER NAME="Frank IRONS" COUNT="1"/>
    <PLAYER NAME="Frank JARVIS" COUNT="1"/>
    <PLAYER NAME="Frank LOOMIS" COUNT="1"/>
    <PLAYER NAME="Frank MURPHY" COUNT="1"/>
    <PLAYER NAME="Frank NELSON" COUNT="1"/>
    <PLAYER NAME="Frank PASCHEK" COUNT="1"/>
    <PLAYER NAME="Frank RUTHERFORD" COUNT="1"/>
    <PLAYER NAME="Frank SCHAFFER" COUNT="1"/>
    <PLAYER NAME="Frank WALLER" COUNT="2"/>
    <PLAYER NAME="Frank WARTENBERG" COUNT="1"/>
    <PLAYER NAME="Franti?ek DOUDA" COUNT="1"/>
    <PLAYER NAME="Frantz KRUGER" COUNT="1"/>
    <PLAYER NAME="Fred ENGELHARDT" COUNT="1"/>
    <PLAYER NAME="Fred HANSEN" COUNT="1"/>
    <PLAYER NAME="Fred ONYANCHA" COUNT="1"/>
    <PLAYER NAME="Fred TOOTELL" COUNT="1"/>
    <PLAYER NAME="Frederick KELLY" COUNT="1"/>
    <PLAYER NAME="Frederick MOLONEY" COUNT="1"/>
    <PLAYER NAME="Frederick MURRAY" COUNT="1"/>
    <PLAYER NAME="Frederick SCHULE" COUNT="1"/>
    <PLAYER NAME="Frederick Vaughn NEWHOUSE" COUNT="1"/>
    <PLAYER NAME="Fritz Erik ELMSÃ&#x83;?TER" COUNT="1"/>
    <PLAYER NAME="Fritz HOFMANN" COUNT="1"/>
    <PLAYER NAME="Fritz POLLARD" COUNT="1"/>
    <PLAYER NAME="Gabriel TIACOH" COUNT="1"/>
    <PLAYER NAME="Gabriela SZABO" COUNT="3"/>
    <PLAYER NAME="Gabriella DORIO" COUNT="1"/>
    <PLAYER NAME="Gael MARTIN" COUNT="1"/>
    <PLAYER NAME="Gail DEVERS" COUNT="2"/>
    <PLAYER NAME="Galen RUPP" COUNT="2"/>
    <PLAYER NAME="Galina ASTAFEI" COUNT="1"/>
    <PLAYER NAME="Galina ZYBINA" COUNT="2"/>
    <PLAYER NAME="Gamze BULUT" COUNT="1"/>
    <PLAYER NAME="Garfield MACDONALD" COUNT="1"/>
    <PLAYER NAME="Garrett SERVISS" COUNT="1"/>
    <PLAYER NAME="Gary OAKES" COUNT="1"/>
    <PLAYER NAME="Gaston GODEL" COUNT="1"/>
    <PLAYER NAME="Gaston REIFF" COUNT="1"/>
    <PLAYER NAME="Gaston ROELANTS" COUNT="1"/>
    <PLAYER NAME="Gaston STROBINO" COUNT="1"/>
    <PLAYER NAME="Gelindo BORDIN" COUNT="1"/>
    <PLAYER NAME="Genzebe DIBABA" COUNT="1"/>
    <PLAYER NAME="Georg ABERG" COUNT="2"/>
    <PLAYER NAME="Georg LAMMERS" COUNT="1"/>
    <PLAYER NAME="George HORINE" COUNT="1"/>
    <PLAYER NAME="George HUTSON" COUNT="1"/>
    <PLAYER NAME="George JEFFERSON" COUNT="1"/>
    <PLAYER NAME="George KERR" COUNT="1"/>
    <PLAYER NAME="George ORTON" COUNT="2"/>
    <PLAYER NAME="George POAGE" COUNT="1"/>
    <PLAYER NAME="George RHODEN" COUNT="1"/>
    <PLAYER NAME="George SALING" COUNT="1"/>
    <PLAYER NAME="George SIMPSON" COUNT="1"/>
    <PLAYER NAME="George YOUNG" COUNT="1"/>
    <PLAYER NAME="Georges ANDRE" COUNT="1"/>
    <PLAYER NAME="Georgios PAPASIDERIS" COUNT="1"/>
    <PLAYER NAME="Gerard NIJBOER" COUNT="1"/>
    <PLAYER NAME="Gerd KANTER" COUNT="2"/>
    <PLAYER NAME="Gerd WESSIG" COUNT="1"/>
    <PLAYER NAME="Gergely KULCSÃ&#x81;R" COUNT="2"/>
    <PLAYER NAME="Gerhard HENNIGE" COUNT="1"/>
    <PLAYER NAME="Gerhard STÃ&#x96;CK" COUNT="1"/>
    <PLAYER NAME="Germaine MASON" COUNT="1"/>
    <PLAYER NAME="Gete WAMI" COUNT="3"/>
    <PLAYER NAME="Gezahegne ABERA" COUNT="1"/>
    <PLAYER NAME="Ghada SHOUAA" COUNT="1"/>
    <PLAYER NAME="Gheorghe MEGELEA" COUNT="1"/>
    <PLAYER NAME="Giovanni DE BENEDICTIS" COUNT="1"/>
    <PLAYER NAME="Gisela MAUERMAYER" COUNT="1"/>
    <PLAYER NAME="Giuseppe DORDONI" COUNT="1"/>
    <PLAYER NAME="Giuseppe GIBILISCO" COUNT="1"/>
    <PLAYER NAME="Giuseppina LEONE" COUNT="1"/>
    <PLAYER NAME="Glenn CUNNINGHAM" COUNT="1"/>
    <PLAYER NAME="Glenn DAVIS" COUNT="2"/>
    <PLAYER NAME="Glenn GRAHAM" COUNT="1"/>
    <PLAYER NAME="Glenn HARDIN" COUNT="2"/>
    <PLAYER NAME="Glenn HARTRANFT" COUNT="1"/>
    <PLAYER NAME="Glenn MORRIS" COUNT="1"/>
    <PLAYER NAME="Gloria ALOZIE" COUNT="1"/>
    <PLAYER NAME="Glynis NUNN" COUNT="1"/>
    <PLAYER NAME="Godfrey BROWN" COUNT="1"/>
    <PLAYER NAME="Godfrey Khotso MOKOENA" COUNT="1"/>
    <PLAYER NAME="Gordon PIRIE" COUNT="1"/>
    <PLAYER NAME="Gote Ernst HAGSTROM" COUNT="1"/>
    <PLAYER NAME="Grantley GOULDING" COUNT="1"/>
    <PLAYER NAME="Greg FOSTER" COUNT="1"/>
    <PLAYER NAME="Greg HAUGHTON" COUNT="1"/>
    <PLAYER NAME="Greg JOY" COUNT="1"/>
    <PLAYER NAME="Greg RUTHERFORD" COUNT="2"/>
    <PLAYER NAME="Grete ANDERSEN" COUNT="1"/>
    <PLAYER NAME="Guido KRATSCHMER" COUNT="1"/>
    <PLAYER NAME="Guillaume LEBLANC" COUNT="1"/>
    <PLAYER NAME="Gulnara SAMITOVA" COUNT="1"/>
    <PLAYER NAME="Gunhild HOFFMEISTER" COUNT="3"/>
    <PLAYER NAME="Gunnar HÃ&#x96;CKERT" COUNT="1"/>
    <PLAYER NAME="Gunnar LINDSTRÃ&#x96;M" COUNT="1"/>
    <PLAYER NAME="Gustaf JANSSON" COUNT="1"/>
    <PLAYER NAME="Gustav LINDBLOM" COUNT="1"/>
    <PLAYER NAME="Guy BUTLER" COUNT="2"/>
    <PLAYER NAME="Guy DRUT" COUNT="2"/>
    <PLAYER NAME="Gwen TORRENCE" COUNT="2"/>
    <PLAYER NAME="Gyula KELLNER" COUNT="1"/>
    <PLAYER NAME="Gyula ZSIVÃ&#x93;TZKY" COUNT="2"/>
    <PLAYER NAME="GÃ¶sta HOLMER" COUNT="1"/>
    <PLAYER NAME="Habiba GHRIBI" COUNT="1"/>
    <PLAYER NAME="Hadi Soua An AL SOMAILY" COUNT="1"/>
    <PLAYER NAME="Hagos GEBRHIWET" COUNT="1"/>
    <PLAYER NAME="Haile GEBRSELASSIE" COUNT="2"/>
    <PLAYER NAME="Halina KONOPACKA" COUNT="1"/>
    <PLAYER NAME="Hannes KOLEHMAINEN" COUNT="3"/>
    <PLAYER NAME="Hanns BRAUN" COUNT="2"/>
    <PLAYER NAME="Hannu Juhani SIITONEN" COUNT="1"/>
    <PLAYER NAME="Hans GRODOTZKI" COUNT="2"/>
    <PLAYER NAME="Hans LIESCHE" COUNT="1"/>
    <PLAYER NAME="Hans REIMANN" COUNT="2"/>
    <PLAYER NAME="Hans WOELLKE" COUNT="1"/>
    <PLAYER NAME="Hans-Joachim WALDE" COUNT="2"/>
    <PLAYER NAME="Hansle PARCHMENT" COUNT="1"/>
    <PLAYER NAME="Harald NORPOTH" COUNT="1"/>
    <PLAYER NAME="Harald SCHMID" COUNT="1"/>
    <PLAYER NAME="Harlow ROTHERT" COUNT="1"/>
    <PLAYER NAME="Harold ABRAHAMS" COUNT="1"/>
    <PLAYER NAME="Harold BARRON" COUNT="1"/>
    <PLAYER NAME="Harold OSBORN" COUNT="2"/>
    <PLAYER NAME="Harold WHITLOCK" COUNT="1"/>
    <PLAYER NAME="Harold WILSON" COUNT="1"/>
    <PLAYER NAME="Harri LARVA" COUNT="1"/>
    <PLAYER NAME="Harrison DILLARD" COUNT="2"/>
    <PLAYER NAME="Harry EDWARD" COUNT="2"/>
    <PLAYER NAME="Harry HILLMAN" COUNT="3"/>
    <PLAYER NAME="Harry JEROME" COUNT="1"/>
    <PLAYER NAME="Harry PORTER" COUNT="1"/>
    <PLAYER NAME="Harry Stoddard BABCOCK" COUNT="1"/>
    <PLAYER NAME="Hartwig GAUDER" COUNT="2"/>
    <PLAYER NAME="Hasely CRAWFORD" COUNT="1"/>
    <PLAYER NAME="Hasna BENHASSI" COUNT="2"/>
    <PLAYER NAME="Hassiba BOULMERKA" COUNT="1"/>
    <PLAYER NAME="Hayes JONES" COUNT="2"/>
    <PLAYER NAME="Hector HOGAN" COUNT="1"/>
    <PLAYER NAME="Heike DRECHSLER" COUNT="2"/>
    <PLAYER NAME="Heike HENKEL" COUNT="1"/>
    <PLAYER NAME="Heinz ULZHEIMER" COUNT="1"/>
    <PLAYER NAME="Helen STEPHENS" COUNT="1"/>
    <PLAYER NAME="Helena FIBINGEROVÃ&#x81;" COUNT="1"/>
    <PLAYER NAME="Helge LÃ&#x96;VLAND" COUNT="1"/>
    <PLAYER NAME="Heli RANTANEN" COUNT="1"/>
    <PLAYER NAME="Hellen Onsando OBIRI" COUNT="1"/>
    <PLAYER NAME="Helmut KÃ&#x96;RNIG" COUNT="1"/>
    <PLAYER NAME="Henri DELOGE" COUNT="1"/>
    <PLAYER NAME="Henri LABORDE" COUNT="1"/>
    <PLAYER NAME="Henri TAUZIN" COUNT="1"/>
    <PLAYER NAME="Henry CARR" COUNT="1"/>
    <PLAYER NAME="Henry ERIKSSON" COUNT="1"/>
    <PLAYER NAME="Henry JONSSON-KÃ&#x84;LARNE" COUNT="1"/>
    <PLAYER NAME="Henry STALLARD" COUNT="1"/>
    <PLAYER NAME="Herb ELLIOTT" COUNT="1"/>
    <PLAYER NAME="Herbert JAMISON" COUNT="1"/>
    <PLAYER NAME="Herbert MCKENLEY" COUNT="3"/>
    <PLAYER NAME="Herbert SCHADE" COUNT="1"/>
    <PLAYER NAME="Herma BAUMA" COUNT="1"/>
    <PLAYER NAME="Herman GROMAN" COUNT="1"/>
    <PLAYER NAME="Herman Ronald FRAZIER" COUNT="1"/>
    <PLAYER NAME="Hermann ENGELHARD" COUNT="1"/>
    <PLAYER NAME="Hestrie CLOETE" COUNT="2"/>
    <PLAYER NAME="Hezekiel SEPENG" COUNT="1"/>
    <PLAYER NAME="Hicham EL GUERROUJ" COUNT="3"/>
    <PLAYER NAME="Hilda STRIKE" COUNT="1"/>
    <PLAYER NAME="Hildegard FALCK" COUNT="1"/>
    <PLAYER NAME="Hildrun CLAUS" COUNT="1"/>
    <PLAYER NAME="Hirooki ARAI" COUNT="1"/>
    <PLAYER NAME="Hollis CONWAY" COUNT="1"/>
    <PLAYER NAME="Hong LIU" COUNT="1"/>
    <PLAYER NAME="Horace ASHENFELTER" COUNT="1"/>
    <PLAYER NAME="Horatio FITCH" COUNT="1"/>
    <PLAYER NAME="Howard VALENTINE" COUNT="1"/>
    <PLAYER NAME="Hrysopiyi DEVETZI" COUNT="1"/>
    <PLAYER NAME="Hugo WIESLANDER" COUNT="1"/>
    <PLAYER NAME="Huina XING" COUNT="1"/>
    <PLAYER NAME="Hussein AHMED SALAH" COUNT="1"/>
    <PLAYER NAME="Hyleas FOUNTAIN" COUNT="1"/>
    <PLAYER NAME="Hyvin Kiyeng JEPKEMOI" COUNT="1"/>
    <PLAYER NAME="Ian STEWART" COUNT="1"/>
    <PLAYER NAME="Ibolya CSÃ&#x81;K" COUNT="1"/>
    <PLAYER NAME="Ibrahim CAMEJO" COUNT="1"/>
    <PLAYER NAME="Ignace HEINRICH" COUNT="1"/>
    <PLAYER NAME="Igor ASTAPKOVICH" COUNT="2"/>
    <PLAYER NAME="Igor NIKULIN" COUNT="1"/>
    <PLAYER NAME="Igor TER-OVANESYAN" COUNT="2"/>
    <PLAYER NAME="Igor TRANDENKOV" COUNT="2"/>
    <PLAYER NAME="Ileana SILAI" COUNT="1"/>
    <PLAYER NAME="Ilke WYLUDDA" COUNT="1"/>
    <PLAYER NAME="Ilmari SALMINEN" COUNT="1"/>
    <PLAYER NAME="Ilona SCHOKNECHT-SLUPIANEK" COUNT="1"/>
    <PLAYER NAME="Ilya MARKOV" COUNT="1"/>
    <PLAYER NAME="Imre NÃ&#x89;METH" COUNT="1"/>
    <PLAYER NAME="Imrich BUGÃ&#x81;R" COUNT="1"/>
    <PLAYER NAME="Inessa KRAVETS" COUNT="2"/>
    <PLAYER NAME="Inga GENTZEL" COUNT="1"/>
    <PLAYER NAME="Inge HELTEN" COUNT="1"/>
    <PLAYER NAME="Ingrid AUERSWALD-LANGE" COUNT="1"/>
    <PLAYER NAME="Ingrid LOTZ" COUNT="1"/>
    <PLAYER NAME="Ingvar PETTERSSON" COUNT="1"/>
    <PLAYER NAME="Inha BABAKOVA" COUNT="1"/>
    <PLAYER NAME="Inna LASOVSKAYA" COUNT="1"/>
    <PLAYER NAME="Ioannis PERSAKIS" COUNT="1"/>
    <PLAYER NAME="Ioannis THEODOROPOULOS" COUNT="1"/>
    <PLAYER NAME="Iolanda BALAS" COUNT="2"/>
    <PLAYER NAME="Ionela TIRLEA" COUNT="1"/>
    <PLAYER NAME="Ira DAVENPORT" COUNT="1"/>
    <PLAYER NAME="Irena KIRSZENSTEIN" COUNT="6"/>
    <PLAYER NAME="Irina BELOVA" COUNT="1"/>
    <PLAYER NAME="Irina KHUDOROZHKINA" COUNT="1"/>
    <PLAYER NAME="Irina PRIVALOVA" COUNT="2"/>
    <PLAYER NAME="Irina SIMAGINA" COUNT="1"/>
    <PLAYER NAME="Irvin ROBERSON" COUNT="1"/>
    <PLAYER NAME="Irving BAXTER" COUNT="2"/>
    <PLAYER NAME="Irving SALADINO" COUNT="1"/>
    <PLAYER NAME="Iryna LISHCHYNSKA" COUNT="1"/>
    <PLAYER NAME="Iryna YATCHENKO" COUNT="1"/>
    <PLAYER NAME="Isabella OCHICHI" COUNT="1"/>
    <PLAYER NAME="Ismail Ahmed ISMAIL" COUNT="1"/>
    <PLAYER NAME="IstvÃ¡n RÃ&#x93;ZSAVÃ&#x96;LGYI" COUNT="1"/>
    <PLAYER NAME="IstvÃ¡n SOMODI" COUNT="1"/>
    <PLAYER NAME="Ivan BELYAEV" COUNT="1"/>
    <PLAYER NAME="Ivan PEDROSO" COUNT="1"/>
    <PLAYER NAME="Ivan RILEY" COUNT="1"/>
    <PLAYER NAME="Ivan TSIKHAN" COUNT="2"/>
    <PLAYER NAME="Ivan UKHOV" COUNT="1"/>
    <PLAYER NAME="Ivana SPANOVIC" COUNT="1"/>
    <PLAYER NAME="Ivanka KHRISTOVA" COUNT="2"/>
    <PLAYER NAME="Ivano BRUGNETTI" COUNT="1"/>
    <PLAYER NAME="Ivo VAN DAMME" COUNT="2"/>
    <PLAYER NAME="Jaak UUDMÃ&#x84;E" COUNT="1"/>
    <PLAYER NAME="Jacek WSZOLA" COUNT="2"/>
    <PLAYER NAME="Jack DAVIS" COUNT="2"/>
    <PLAYER NAME="Jack LONDON" COUNT="1"/>
    <PLAYER NAME="Jack PARKER" COUNT="1"/>
    <PLAYER NAME="Jack PIERCE" COUNT="1"/>
    <PLAYER NAME="Jackie JOYNER" COUNT="5"/>
    <PLAYER NAME="Jackson SCHOLZ" COUNT="2"/>
    <PLAYER NAME="Jacqueline MAZEAS" COUNT="1"/>
    <PLAYER NAME="Jacqueline TODTEN" COUNT="1"/>
    <PLAYER NAME="Jadwiga WAJS" COUNT="2"/>
    <PLAYER NAME="Jai TAURIMA" COUNT="1"/>
    <PLAYER NAME="James BALL" COUNT="1"/>
    <PLAYER NAME="James BECKFORD" COUNT="1"/>
    <PLAYER NAME="James BROOKER" COUNT="1"/>
    <PLAYER NAME="James CONNOLLY" COUNT="4"/>
    <PLAYER NAME="James DILLION" COUNT="1"/>
    <PLAYER NAME="James DUNCAN" COUNT="1"/>
    <PLAYER NAME="James Edwin MEREDITH" COUNT="1"/>
    <PLAYER NAME="James Ellis LU VALLE" COUNT="1"/>
    <PLAYER NAME="James FUCHS" COUNT="1"/>
    <PLAYER NAME="James GATHERS" COUNT="1"/>
    <PLAYER NAME="James LIGHTBODY" COUNT="3"/>
    <PLAYER NAME="James WENDELL" COUNT="1"/>
    <PLAYER NAME="James WILSON" COUNT="1"/>
    <PLAYER NAME="Jan Å½ELEZNÃ&#x9d;" COUNT="3"/>
    <PLAYER NAME="Janay DELOACH" COUNT="1"/>
    <PLAYER NAME="Jane SAVILLE" COUNT="1"/>
    <PLAYER NAME="Janeene VICKERS" COUNT="1"/>
    <PLAYER NAME="Janeth Jepkosgei BUSIENEI" COUNT="1"/>
    <PLAYER NAME="Janis DALINS" COUNT="1"/>
    <PLAYER NAME="Janusz KUSOCINSKI" COUNT="1"/>
    <PLAYER NAME="Jaouad GHARIB" COUNT="1"/>
    <PLAYER NAME="Jared TALLENT" COUNT="4"/>
    <PLAYER NAME="Jarmila KRATOHVILOVA" COUNT="1"/>
    <PLAYER NAME="Jaroslav BABA" COUNT="1"/>
    <PLAYER NAME="Jaroslawa JÃ&#x93;ZWIAKOWSKA" COUNT="1"/>
    <PLAYER NAME="Jason RICHARDSON" COUNT="1"/>
    <PLAYER NAME="Javier CULSON" COUNT="1"/>
    <PLAYER NAME="Javier GARCÃ&#x8d;A" COUNT="1"/>
    <PLAYER NAME="Javier SOTOMAYOR" COUNT="2"/>
    <PLAYER NAME="Jean BOUIN" COUNT="1"/>
    <PLAYER NAME="Jean CHASTANIE" COUNT="1"/>
    <PLAYER NAME="Jean GALFIONE" COUNT="1"/>
    <PLAYER NAME="Jean SHILEY" COUNT="1"/>
    <PLAYER NAME="Jeff HENDERSON" COUNT="1"/>
    <PLAYER NAME="Jefferson PEREZ" COUNT="2"/>
    <PLAYER NAME="Jemima Jelagat SUMGONG" COUNT="1"/>
    <PLAYER NAME="Jennifer LAMY" COUNT="1"/>
    <PLAYER NAME="Jennifer SIMPSON" COUNT="1"/>
    <PLAYER NAME="Jennifer SUHR" COUNT="2"/>
    <PLAYER NAME="Jeremy WARINER" COUNT="2"/>
    <PLAYER NAME="Jerome BIFFLE" COUNT="1"/>
    <PLAYER NAME="Jesse OWENS" COUNT="3"/>
    <PLAYER NAME="Jessica ENNIS HILL" COUNT="2"/>
    <PLAYER NAME="Jim BAUSCH" COUNT="1"/>
    <PLAYER NAME="Jim DOEHRING" COUNT="1"/>
    <PLAYER NAME="Jim HINES" COUNT="1"/>
    <PLAYER NAME="Jim RYUN" COUNT="1"/>
    <PLAYER NAME="Jim THORPE" COUNT="1"/>
    <PLAYER NAME="Joachim Broechner OLSEN" COUNT="1"/>
    <PLAYER NAME="Joachim BÃ&#x9c;CHNER" COUNT="1"/>
    <PLAYER NAME="Joan BENOIT" COUNT="1"/>
    <PLAYER NAME="Joan Lino MARTINEZ" COUNT="1"/>
    <PLAYER NAME="Joanet QUINTERO" COUNT="1"/>
    <PLAYER NAME="Joanna HAYES" COUNT="1"/>
    <PLAYER NAME="Joaquim CRUZ" COUNT="1"/>
    <PLAYER NAME="Joe GREENE" COUNT="2"/>
    <PLAYER NAME="Joe KOVACS" COUNT="1"/>
    <PLAYER NAME="Joel SANCHEZ GUERRERO" COUNT="1"/>
    <PLAYER NAME="Joel SHANKLE" COUNT="1"/>
    <PLAYER NAME="Johanna LÃ&#x9c;TTGE" COUNT="1"/>
    <PLAYER NAME="Johanna SCHALLER-KLIER" COUNT="2"/>
    <PLAYER NAME="John AKII-BUA" COUNT="1"/>
    <PLAYER NAME="John ANDERSON" COUNT="1"/>
    <PLAYER NAME="John BRAY" COUNT="1"/>
    <PLAYER NAME="John CARLOS" COUNT="1"/>
    <PLAYER NAME="John COLLIER" COUNT="1"/>
    <PLAYER NAME="John COOPER" COUNT="1"/>
    <PLAYER NAME="John CORNES" COUNT="1"/>
    <PLAYER NAME="John CREGAN" COUNT="1"/>
    <PLAYER NAME="John DALY" COUNT="1"/>
    <PLAYER NAME="John DAVIES" COUNT="1"/>
    <PLAYER NAME="John DEWITT" COUNT="1"/>
    <PLAYER NAME="John DISLEY" COUNT="1"/>
    <PLAYER NAME="John FLANAGAN" COUNT="3"/>
    <PLAYER NAME="John GARRELLS" COUNT="2"/>
    <PLAYER NAME="John GODINA" COUNT="2"/>
    <PLAYER NAME="John George WALKER" COUNT="1"/>
    <PLAYER NAME="John HAYES" COUNT="1"/>
    <PLAYER NAME="John Kenneth DOHERTY" COUNT="1"/>
    <PLAYER NAME="John LANDY" COUNT="1"/>
    <PLAYER NAME="John LJUNGGREN" COUNT="3"/>
    <PLAYER NAME="John LOARING" COUNT="1"/>
    <PLAYER NAME="John LOVELOCK" COUNT="1"/>
    <PLAYER NAME="John MCLEAN" COUNT="1"/>
    <PLAYER NAME="John MOFFITT" COUNT="1"/>
    <PLAYER NAME="John Macfarlane HOLLAND" COUNT="1"/>
    <PLAYER NAME="John NORTON" COUNT="1"/>
    <PLAYER NAME="John POWELL" COUNT="2"/>
    <PLAYER NAME="John RAMBO" COUNT="1"/>
    <PLAYER NAME="John RECTOR" COUNT="1"/>
    <PLAYER NAME="John SHERWOOD" COUNT="1"/>
    <PLAYER NAME="John THOMAS" COUNT="2"/>
    <PLAYER NAME="John TREACY" COUNT="1"/>
    <PLAYER NAME="John WOODRUFF" COUNT="1"/>
    <PLAYER NAME="Johnny GRAY" COUNT="1"/>
    <PLAYER NAME="Jolan KLEIBER-KONTSEK" COUNT="1"/>
    <PLAYER NAME="Jolanda CEPLAK" COUNT="1"/>
    <PLAYER NAME="Jonathan EDWARDS" COUNT="2"/>
    <PLAYER NAME="Jonni MYYRÃ&#x84;" COUNT="1"/>
    <PLAYER NAME="Jorge LLOPART" COUNT="1"/>
    <PLAYER NAME="Jose TELLES DA CONCEICAO" COUNT="1"/>
    <PLAYER NAME="Josef DOLEZAL" COUNT="1"/>
    <PLAYER NAME="Josef ODLOZIL" COUNT="1"/>
    <PLAYER NAME="Joseph BARTHEL" COUNT="1"/>
    <PLAYER NAME="Joseph FORSHAW" COUNT="1"/>
    <PLAYER NAME="Joseph GUILLEMOT" COUNT="2"/>
    <PLAYER NAME="Joseph KETER" COUNT="1"/>
    <PLAYER NAME="Joseph MAHMOUD" COUNT="1"/>
    <PLAYER NAME="Joseph MCCLUSKEY" COUNT="1"/>
    <PLAYER NAME="Josh CULBREATH" COUNT="1"/>
    <PLAYER NAME="Josia THUGWANE" COUNT="1"/>
    <PLAYER NAME="Josiah MCCRACKEN" COUNT="2"/>
    <PLAYER NAME="JosÃ© Manuel ABASCAL" COUNT="1"/>
    <PLAYER NAME="JosÃ© PEDRAZA" COUNT="1"/>
    <PLAYER NAME="Joyce CHEPCHUMBA" COUNT="1"/>
    <PLAYER NAME="Jozef PRIBILINEC" COUNT="1"/>
    <PLAYER NAME="Jozef SCHMIDT" COUNT="2"/>
    <PLAYER NAME="JoÃ£o Carlos DE OLIVEIRA" COUNT="1"/>
    <PLAYER NAME="Juan Carlos ZABALA" COUNT="1"/>
    <PLAYER NAME="Judi BROWN" COUNT="1"/>
    <PLAYER NAME="Judith Florence AMOORE-POLLOCK" COUNT="1"/>
    <PLAYER NAME="Juho Julius SAARISTO" COUNT="1"/>
    <PLAYER NAME="Jules LADOUMEGUE" COUNT="1"/>
    <PLAYER NAME="Juliet CUTHBERT" COUNT="2"/>
    <PLAYER NAME="Julius KORIR" COUNT="1"/>
    <PLAYER NAME="Julius SANG" COUNT="1"/>
    <PLAYER NAME="Julius YEGO" COUNT="1"/>
    <PLAYER NAME="Junxia WANG" COUNT="2"/>
    <PLAYER NAME="Justin GATLIN" COUNT="4"/>
    <PLAYER NAME="Jutta HEINE" COUNT="1"/>
    <PLAYER NAME="Jutta KIRST" COUNT="1"/>
    <PLAYER NAME="JÃ³zsef CSERMÃ&#x81;K" COUNT="1"/>
    <PLAYER NAME="JÃ³zsef KOVÃ&#x81;CS" COUNT="1"/>
    <PLAYER NAME="JÃ¶rg FREIMUTH" COUNT="1"/>
    <PLAYER NAME="JÃ¼rgen HINGSEN" COUNT="1"/>
    <PLAYER NAME="JÃ¼rgen SCHULT" COUNT="1"/>
    <PLAYER NAME="JÃ¼rgen STRAUB" COUNT="1"/>
    <PLAYER NAME="JÃ¼ri LOSSMANN" COUNT="1"/>
    <PLAYER NAME="Kaarlo Jalmari TUOMINEN" COUNT="1"/>
    <PLAYER NAME="Kaarlo MAANINKA" COUNT="2"/>
    <PLAYER NAME="Kaisa PARVIAINEN" COUNT="1"/>
    <PLAYER NAME="Kajsa BERGQVIST" COUNT="1"/>
    <PLAYER NAME="Kamila SKOLIMOWSKA" COUNT="1"/>
    <PLAYER NAME="Karel LISMONT" COUNT="2"/>
    <PLAYER NAME="Karen FORKEL" COUNT="1"/>
    <PLAYER NAME="Karin RICHERT-BALZER" COUNT="1"/>
    <PLAYER NAME="Karl STORCH" COUNT="1"/>
    <PLAYER NAME="Karl-Friedrich HAAS" COUNT="1"/>
    <PLAYER NAME="Karoline &#34;Lina&#34; RADKE" COUNT="1"/>
    <PLAYER NAME="Katharine MERRY" COUNT="1"/>
    <PLAYER NAME="Kathleen HAMMOND" COUNT="1"/>
    <PLAYER NAME="Kathrin NEIMKE" COUNT="1"/>
    <PLAYER NAME="Kathryn Joan SCHMIDT" COUNT="2"/>
    <PLAYER NAME="Kathryn SMALLWOOD-COOK" COUNT="1"/>
    <PLAYER NAME="Katrin DÃ&#x96;RRE" COUNT="1"/>
    <PLAYER NAME="Kazimierz ZIMNY" COUNT="1"/>
    <PLAYER NAME="Kellie WELLS" COUNT="1"/>
    <PLAYER NAME="Kelly HOLMES" COUNT="3"/>
    <PLAYER NAME="Kelly SOTHERTON" COUNT="1"/>
    <PLAYER NAME="Kenenisa BEKELE" COUNT="4"/>
    <PLAYER NAME="Kenji KIMIHARA" COUNT="1"/>
    <PLAYER NAME="Kenkichi OSHIMA" COUNT="1"/>
    <PLAYER NAME="Kennedy Kane MCARTHUR" COUNT="1"/>
    <PLAYER NAME="Kenneth Joseph MATTHEWS" COUNT="1"/>
    <PLAYER NAME="Kenneth WIESNER" COUNT="1"/>
    <PLAYER NAME="Kenny HARRISON" COUNT="1"/>
    <PLAYER NAME="Kenth ELDEBRINK" COUNT="1"/>
    <PLAYER NAME="Kerron CLEMENT" COUNT="2"/>
    <PLAYER NAME="Kerron STEWART" COUNT="2"/>
    <PLAYER NAME="Keshorn WALCOTT" COUNT="2"/>
    <PLAYER NAME="Kevin MAYER" COUNT="1"/>
    <PLAYER NAME="Kevin YOUNG" COUNT="1"/>
    <PLAYER NAME="Khalid BOULAMI" COUNT="1"/>
    <PLAYER NAME="Khalid SKAH" COUNT="1"/>
    <PLAYER NAME="Kharilaos VASILAKOS" COUNT="1"/>
    <PLAYER NAME="Kim BATTEN" COUNT="1"/>
    <PLAYER NAME="Kim GALLAGHER" COUNT="1"/>
    <PLAYER NAME="Kim TURNER" COUNT="1"/>
    <PLAYER NAME="Kinue HITOMI" COUNT="1"/>
    <PLAYER NAME="Kip KEINO" COUNT="4"/>
    <PLAYER NAME="Kirani JAMES" COUNT="2"/>
    <PLAYER NAME="Kirk BAPTISTE" COUNT="1"/>
    <PLAYER NAME="Kirsten MÃ&#x9c;NCHOW" COUNT="1"/>
    <PLAYER NAME="Kitei SON" COUNT="1"/>
    <PLAYER NAME="Kjersti PLAETZER" COUNT="2"/>
    <PLAYER NAME="Klaus LEHNERTZ" COUNT="1"/>
    <PLAYER NAME="Klaus RICHTZENHAIN" COUNT="1"/>
    <PLAYER NAME="Klaus-Peter HILDENBRAND" COUNT="1"/>
    <PLAYER NAME="Klavdiya TOCHENOVA" COUNT="1"/>
    <PLAYER NAME="Koichi MORISHITA" COUNT="1"/>
    <PLAYER NAME="Koji MUROFUSHI" COUNT="2"/>
    <PLAYER NAME="Kokichi TSUBURAYA" COUNT="1"/>
    <PLAYER NAME="Konstantin VOLKOV" COUNT="1"/>
    <PLAYER NAME="Kostas KENTERIS" COUNT="1"/>
    <PLAYER NAME="Kriss AKABUSI" COUNT="1"/>
    <PLAYER NAME="Kristi CASTLIN" COUNT="1"/>
    <PLAYER NAME="Krisztian PARS" COUNT="1"/>
    <PLAYER NAME="Kurt BENDLIN" COUNT="1"/>
    <PLAYER NAME="KÃ¤the KRAUSS" COUNT="1"/>
    <PLAYER NAME="LaVonna MARTIN" COUNT="1"/>
    <PLAYER NAME="Lacey HEARN" COUNT="1"/>
    <PLAYER NAME="Lajos GÃ&#x96;NCZY" COUNT="1"/>
    <PLAYER NAME="Lalonde GORDON" COUNT="1"/>
    <PLAYER NAME="Lambert REDD" COUNT="1"/>
    <PLAYER NAME="Lance Earl DEAL" COUNT="1"/>
    <PLAYER NAME="Larisa PELESHENKO" COUNT="1"/>
    <PLAYER NAME="Larry BLACK" COUNT="1"/>
    <PLAYER NAME="Larry JAMES" COUNT="1"/>
    <PLAYER NAME="Larry YOUNG" COUNT="2"/>
    <PLAYER NAME="Lars RIEDEL" COUNT="2"/>
    <PLAYER NAME="Lashawn MERRITT" COUNT="2"/>
    <PLAYER NAME="Lashinda DEMUS" COUNT="1"/>
    <PLAYER NAME="Lasse VIREN" COUNT="4"/>
    <PLAYER NAME="Lauri LEHTINEN" COUNT="2"/>
    <PLAYER NAME="Lauri VIRTANEN" COUNT="2"/>
    <PLAYER NAME="Lauryn WILLIAMS" COUNT="1"/>
    <PLAYER NAME="Lawrence E. Joseph FEUERBACH" COUNT="1"/>
    <PLAYER NAME="Lawrence JOHNSON" COUNT="1"/>
    <PLAYER NAME="Lawrence SHIELDS" COUNT="1"/>
    <PLAYER NAME="Lawrence WHITNEY" COUNT="1"/>
    <PLAYER NAME="Lee BARNES" COUNT="1"/>
    <PLAYER NAME="Lee CALHOUN" COUNT="2"/>
    <PLAYER NAME="Lee EVANS" COUNT="1"/>
    <PLAYER NAME="Leevan SANDS" COUNT="1"/>
    <PLAYER NAME="Lennart STRAND" COUNT="1"/>
    <PLAYER NAME="Lennox MILLER" COUNT="2"/>
    <PLAYER NAME="Leo SEXTON" COUNT="1"/>
    <PLAYER NAME="Leonard Francis TREMEER" COUNT="1"/>
    <PLAYER NAME="Leonel MANZANO" COUNT="1"/>
    <PLAYER NAME="Leonel SUAREZ" COUNT="2"/>
    <PLAYER NAME="Leonid LITVINENKO" COUNT="1"/>
    <PLAYER NAME="Leonid SHCHERBAKOV" COUNT="1"/>
    <PLAYER NAME="Leonid SPIRIN" COUNT="1"/>
    <PLAYER NAME="Leroy BROWN" COUNT="1"/>
    <PLAYER NAME="Leroy SAMSE" COUNT="1"/>
    <PLAYER NAME="Lesley ASHBURNER" COUNT="1"/>
    <PLAYER NAME="Leslie DENIZ" COUNT="1"/>
    <PLAYER NAME="Lester Nelson CARNEY" COUNT="1"/>
    <PLAYER NAME="Lewis SHELDON" COUNT="1"/>
    <PLAYER NAME="Lewis TEWANIMA" COUNT="1"/>
    <PLAYER NAME="Lia MANOLIU" COUNT="3"/>
    <PLAYER NAME="Lidia ALFEEVA" COUNT="1"/>
    <PLAYER NAME="Lidia SIMON" COUNT="1"/>
    <PLAYER NAME="Liesel WESTERMANN" COUNT="1"/>
    <PLAYER NAME="Lijiao GONG" COUNT="1"/>
    <PLAYER NAME="Liliya NURUTDINOVA" COUNT="1"/>
    <PLAYER NAME="Lilli SCHWARZKOPF" COUNT="1"/>
    <PLAYER NAME="Lillian BOARD" COUNT="1"/>
    <PLAYER NAME="Lillian COPELAND" COUNT="2"/>
    <PLAYER NAME="Lily CARLSTEDT" COUNT="1"/>
    <PLAYER NAME="Linda STAHL" COUNT="1"/>
    <PLAYER NAME="Lindy REMIGINO" COUNT="1"/>
    <PLAYER NAME="Linford CHRISTIE" COUNT="1"/>
    <PLAYER NAME="Liping WANG" COUNT="2"/>
    <PLAYER NAME="Lisa ONDIEKI" COUNT="1"/>
    <PLAYER NAME="Livio BERRUTI" COUNT="1"/>
    <PLAYER NAME="Llewellyn HERBERT" COUNT="1"/>
    <PLAYER NAME="Lloyd LABEACH" COUNT="2"/>
    <PLAYER NAME="Lorraine FENTON" COUNT="1"/>
    <PLAYER NAME="Lorraine MOLLER" COUNT="1"/>
    <PLAYER NAME="Lothar MILDE" COUNT="1"/>
    <PLAYER NAME="Louis WILKINS" COUNT="1"/>
    <PLAYER NAME="Louise MCPAUL" COUNT="1"/>
    <PLAYER NAME="Lucyna LANGER" COUNT="1"/>
    <PLAYER NAME="Ludmila ENGQUIST" COUNT="1"/>
    <PLAYER NAME="LudvÃ­k DANEK" COUNT="2"/>
    <PLAYER NAME="Luguelin SANTOS" COUNT="1"/>
    <PLAYER NAME="Luigi BECCALI" COUNT="2"/>
    <PLAYER NAME="Luis BRUNETTO" COUNT="1"/>
    <PLAYER NAME="Luis DELIS" COUNT="1"/>
    <PLAYER NAME="Luise KRÃ&#x9c;GER" COUNT="1"/>
    <PLAYER NAME="Lutz DOMBROWSKI" COUNT="1"/>
    <PLAYER NAME="Luvo MANYONGA" COUNT="1"/>
    <PLAYER NAME="Luz LONG" COUNT="1"/>
    <PLAYER NAME="Lynn DAVIES" COUNT="1"/>
    <PLAYER NAME="Lynn JENNINGS" COUNT="1"/>
    <PLAYER NAME="Lyudmila BRAGINA" COUNT="1"/>
    <PLAYER NAME="Lyudmila KONDRATYEVA" COUNT="1"/>
    <PLAYER NAME="Lyudmila ROGACHOVA" COUNT="1"/>
    <PLAYER NAME="Lyudmila SHEVTSOVA" COUNT="1"/>
    <PLAYER NAME="Mac WILKINS" COUNT="2"/>
    <PLAYER NAME="Madeline MANNING-JACKSON" COUNT="1"/>
    <PLAYER NAME="Mahiedine MEKHISSI" COUNT="1"/>
    <PLAYER NAME="Mahiedine MEKHISSI-BENABBAD" COUNT="2"/>
    <PLAYER NAME="Maksim TARASOV" COUNT="2"/>
    <PLAYER NAME="Mal WHITFIELD" COUNT="3"/>
    <PLAYER NAME="Malcolm NOKES" COUNT="1"/>
    <PLAYER NAME="Malcolm SPENCE" COUNT="1"/>
    <PLAYER NAME="Mamo WOLDE" COUNT="3"/>
    <PLAYER NAME="Manuel MARTINEZ" COUNT="1"/>
    <PLAYER NAME="Manuel PLAZA" COUNT="1"/>
    <PLAYER NAME="Manuela MONTEBRUN" COUNT="1"/>
    <PLAYER NAME="Marc WRIGHT" COUNT="1"/>
    <PLAYER NAME="Marcel HANSENNE" COUNT="1"/>
    <PLAYER NAME="Mare DIBABA" COUNT="1"/>
    <PLAYER NAME="Margaret Nyairera WAMBUI" COUNT="1"/>
    <PLAYER NAME="Margitta DROESE-PUFE" COUNT="1"/>
    <PLAYER NAME="Margitta HELMBOLD-GUMMEL" COUNT="2"/>
    <PLAYER NAME="Maria CIONCAN" COUNT="1"/>
    <PLAYER NAME="Maria COLON" COUNT="1"/>
    <PLAYER NAME="Maria GOMMERS" COUNT="1"/>
    <PLAYER NAME="Maria Guadalupe GONZALEZ" COUNT="1"/>
    <PLAYER NAME="Maria KWASNIEWSKA" COUNT="1"/>
    <PLAYER NAME="Maria MUTOLA" COUNT="2"/>
    <PLAYER NAME="Maria VASCO" COUNT="1"/>
    <PLAYER NAME="Maria VERGOVA-PETKOVA" COUNT="1"/>
    <PLAYER NAME="Marian OPREA" COUNT="1"/>
    <PLAYER NAME="Marianne WERNER" COUNT="1"/>
    <PLAYER NAME="Maricica PUICA" COUNT="1"/>
    <PLAYER NAME="Marie-JosÃ© PÃ&#x89;REC" COUNT="3"/>
    <PLAYER NAME="Marilyn BLACK" COUNT="1"/>
    <PLAYER NAME="Mario LANZI" COUNT="1"/>
    <PLAYER NAME="Marion BECKER-STEINER" COUNT="1"/>
    <PLAYER NAME="Marita KOCH" COUNT="1"/>
    <PLAYER NAME="Marita LANGE" COUNT="1"/>
    <PLAYER NAME="Maritza MARTEN" COUNT="1"/>
    <PLAYER NAME="Mariya SAVINOVA" COUNT="1"/>
    <PLAYER NAME="Marjorie JACKSON" COUNT="2"/>
    <PLAYER NAME="Mark CREAR" COUNT="2"/>
    <PLAYER NAME="Mark MCKOY" COUNT="1"/>
    <PLAYER NAME="Markus RYFFEL" COUNT="1"/>
    <PLAYER NAME="Marlene MATHEWS-WILLARD" COUNT="2"/>
    <PLAYER NAME="Marlies OELSNER-GÃ&#x96;HR" COUNT="1"/>
    <PLAYER NAME="Marquis Franklin HORR" COUNT="1"/>
    <PLAYER NAME="Marta ANTAL-RUDAS" COUNT="1"/>
    <PLAYER NAME="Martin HAWKINS" COUNT="1"/>
    <PLAYER NAME="Martin SHERIDAN" COUNT="2"/>
    <PLAYER NAME="Martinus OSENDARP" COUNT="2"/>
    <PLAYER NAME="Martti MARTTELIN" COUNT="1"/>
    <PLAYER NAME="Mary ONYALI" COUNT="1"/>
    <PLAYER NAME="Mary RAND" COUNT="1"/>
    <PLAYER NAME="Maryam Yusuf JAMAL" COUNT="1"/>
    <PLAYER NAME="Maryvonne DUPUREUR" COUNT="1"/>
    <PLAYER NAME="Matej TOTH" COUNT="1"/>
    <PLAYER NAME="Matt HEMINGWAY" COUNT="1"/>
    <PLAYER NAME="Matt MCGRATH" COUNT="3"/>
    <PLAYER NAME="Matthew BIRIR" COUNT="1"/>
    <PLAYER NAME="Matthew CENTROWITZ" COUNT="1"/>
    <PLAYER NAME="Matthew Mackenzie ROBINSON" COUNT="1"/>
    <PLAYER NAME="Matti JÃ&#x84;RVINEN" COUNT="1"/>
    <PLAYER NAME="Matti SIPPALA" COUNT="1"/>
    <PLAYER NAME="Maurice GREENE" COUNT="2"/>
    <PLAYER NAME="Maurice HERRIOTT" COUNT="1"/>
    <PLAYER NAME="Maurizio DAMILANO" COUNT="3"/>
    <PLAYER NAME="Maurren Higa MAGGI" COUNT="1"/>
    <PLAYER NAME="Maxwell Warburn LONG" COUNT="1"/>
    <PLAYER NAME="Mbulaeni MULAUDZI" COUNT="1"/>
    <PLAYER NAME="Mebrahtom KEFLEZIGHI" COUNT="1"/>
    <PLAYER NAME="Medhi BAALA" COUNT="1"/>
    <PLAYER NAME="Mel PATTON" COUNT="1"/>
    <PLAYER NAME="Melaine WALKER" COUNT="1"/>
    <PLAYER NAME="Melina ROBERT-MICHON" COUNT="1"/>
    <PLAYER NAME="Melissa MORRISON" COUNT="2"/>
    <PLAYER NAME="Melvin SHEPPARD" COUNT="3"/>
    <PLAYER NAME="Meredith COLKETT" COUNT="1"/>
    <PLAYER NAME="Meredith GOURDINE" COUNT="1"/>
    <PLAYER NAME="Merlene OTTEY" COUNT="7"/>
    <PLAYER NAME="Merritt GIFFIN" COUNT="1"/>
    <PLAYER NAME="Meseret DEFAR" COUNT="3"/>
    <PLAYER NAME="Meyer PRINSTEIN" COUNT="4"/>
    <PLAYER NAME="Micah KOGO" COUNT="1"/>
    <PLAYER NAME="Michael BATES" COUNT="1"/>
    <PLAYER NAME="Michael D'Andrea CARTER" COUNT="1"/>
    <PLAYER NAME="Michael JOHNSON" COUNT="3"/>
    <PLAYER NAME="Michael Lyle SHINE" COUNT="1"/>
    <PLAYER NAME="Michael MARSH" COUNT="1"/>
    <PLAYER NAME="Michael MCLEOD" COUNT="1"/>
    <PLAYER NAME="Michael MUSYOKI" COUNT="1"/>
    <PLAYER NAME="Michael TINSLEY" COUNT="1"/>
    <PLAYER NAME="Michel JAZY" COUNT="1"/>
    <PLAYER NAME="Michel THÃ&#x89;ATO" COUNT="1"/>
    <PLAYER NAME="Michele BROWN" COUNT="1"/>
    <PLAYER NAME="Micheline OSTERMEYER" COUNT="2"/>
    <PLAYER NAME="Michelle CARTER" COUNT="1"/>
    <PLAYER NAME="MichÃ¨le CHARDONNET" COUNT="1"/>
    <PLAYER NAME="Miguel WHITE" COUNT="1"/>
    <PLAYER NAME="Mihaela LOGHIN" COUNT="1"/>
    <PLAYER NAME="Mihaela PENES" COUNT="2"/>
    <PLAYER NAME="Mike BOIT" COUNT="1"/>
    <PLAYER NAME="Mike CONLEY" COUNT="1"/>
    <PLAYER NAME="Mike LARRABEE" COUNT="1"/>
    <PLAYER NAME="Mike POWELL" COUNT="1"/>
    <PLAYER NAME="Mike RYAN" COUNT="1"/>
    <PLAYER NAME="Mike STULCE" COUNT="1"/>
    <PLAYER NAME="Mikhail SHCHENNIKOV" COUNT="1"/>
    <PLAYER NAME="Miklos NEMETH" COUNT="1"/>
    <PLAYER NAME="Milcah Chemos CHEYWA" COUNT="1"/>
    <PLAYER NAME="Mildred DIDRIKSON" COUNT="2"/>
    <PLAYER NAME="Millard Frank Jr. HAMPTON" COUNT="1"/>
    <PLAYER NAME="Millon WOLDE" COUNT="1"/>
    <PLAYER NAME="Miltiadis GOUSKOS" COUNT="1"/>
    <PLAYER NAME="Milton Gray CAMPBELL" COUNT="2"/>
    <PLAYER NAME="Mirela DEMIREVA" COUNT="1"/>
    <PLAYER NAME="Mirela MANIANI" COUNT="2"/>
    <PLAYER NAME="Miruts YIFTER" COUNT="3"/>
    <PLAYER NAME="Mitchell WATT" COUNT="1"/>
    <PLAYER NAME="Mizuki NOGUCHI" COUNT="1"/>
    <PLAYER NAME="Mohamed Ahmed SULAIMAN" COUNT="1"/>
    <PLAYER NAME="Mohamed FARAH" COUNT="4"/>
    <PLAYER NAME="Mohamed GAMMOUDI" COUNT="4"/>
    <PLAYER NAME="Mohammed KEDIR" COUNT="1"/>
    <PLAYER NAME="Monika ZEHRT" COUNT="1"/>
    <PLAYER NAME="Mor KOVACS" COUNT="1"/>
    <PLAYER NAME="Morgan TAYLOR" COUNT="3"/>
    <PLAYER NAME="Morris KIRKSEY" COUNT="1"/>
    <PLAYER NAME="Moses KIPTANUI" COUNT="1"/>
    <PLAYER NAME="Murray HALBERG" COUNT="1"/>
    <PLAYER NAME="Mutaz Essa BARSHIM" COUNT="2"/>
    <PLAYER NAME="Nadezhda CHIZHOVA" COUNT="3"/>
    <PLAYER NAME="Nadezhda KHNYKINA" COUNT="1"/>
    <PLAYER NAME="Nadezhda OLIZARENKO" COUNT="2"/>
    <PLAYER NAME="Nadine KLEINERT-SCHMITT" COUNT="1"/>
    <PLAYER NAME="Nafissatou THIAM" COUNT="1"/>
    <PLAYER NAME="Naftali TEMU" COUNT="2"/>
    <PLAYER NAME="Naman KEITA" COUNT="1"/>
    <PLAYER NAME="Nancy Jebet LAGAT" COUNT="1"/>
    <PLAYER NAME="Naoko TAKAHASHI" COUNT="1"/>
    <PLAYER NAME="Naoto TAJIMA" COUNT="1"/>
    <PLAYER NAME="Natalia BOCHINA" COUNT="1"/>
    <PLAYER NAME="Natalia SHIKOLENKO" COUNT="1"/>
    <PLAYER NAME="Nataliya TOBIAS" COUNT="1"/>
    <PLAYER NAME="Natallia DOBRYNSKA" COUNT="1"/>
    <PLAYER NAME="Natalya ANTYUKH" COUNT="2"/>
    <PLAYER NAME="Natalya CHISTYAKOVA" COUNT="1"/>
    <PLAYER NAME="Natalya LEBEDEVA" COUNT="1"/>
    <PLAYER NAME="Natalya SADOVA" COUNT="2"/>
    <PLAYER NAME="Natalya SAZANOVICH" COUNT="2"/>
    <PLAYER NAME="Natasha DANVERS" COUNT="1"/>
    <PLAYER NAME="Nate CARTMELL" COUNT="3"/>
    <PLAYER NAME="Nathan DEAKES" COUNT="1"/>
    <PLAYER NAME="Nawal EL MOUTAWAKEL" COUNT="1"/>
    <PLAYER NAME="Nelson EVORA" COUNT="1"/>
    <PLAYER NAME="Nezha BIDOUANE" COUNT="1"/>
    <PLAYER NAME="Nia ALI" COUNT="1"/>
    <PLAYER NAME="Nicholas WILLIS" COUNT="2"/>
    <PLAYER NAME="Nick HYSONG" COUNT="1"/>
    <PLAYER NAME="Nick WINTER" COUNT="1"/>
    <PLAYER NAME="Nicola VIZZONI" COUNT="1"/>
    <PLAYER NAME="Nijel AMOS" COUNT="1"/>
    <PLAYER NAME="Niki BAKOGIANNI" COUNT="1"/>
    <PLAYER NAME="Nikolai KIROV" COUNT="1"/>
    <PLAYER NAME="Nikolaos GEORGANTAS" COUNT="1"/>
    <PLAYER NAME="Nikolay AVILOV" COUNT="2"/>
    <PLAYER NAME="Nikolay SMAGA" COUNT="1"/>
    <PLAYER NAME="Nikolay SOKOLOV" COUNT="1"/>
    <PLAYER NAME="Nikolina CHTEREVA" COUNT="1"/>
    <PLAYER NAME="Nils ENGDAHL" COUNT="1"/>
    <PLAYER NAME="Nils SCHUMANN" COUNT="1"/>
    <PLAYER NAME="Nina DUMBADZE" COUNT="1"/>
    <PLAYER NAME="Nina ROMASHKOVA" COUNT="2"/>
    <PLAYER NAME="Niole SABAITE" COUNT="1"/>
    <PLAYER NAME="Nixon KIPROTICH" COUNT="1"/>
    <PLAYER NAME="Noah Kiprono NGENYI" COUNT="1"/>
    <PLAYER NAME="Noe HERNANDEZ" COUNT="1"/>
    <PLAYER NAME="Noel FREEMAN" COUNT="1"/>
    <PLAYER NAME="Norman HALLOWS" COUNT="1"/>
    <PLAYER NAME="Norman PRITCHARD" COUNT="1"/>
    <PLAYER NAME="Norman READ" COUNT="1"/>
    <PLAYER NAME="Norman TABER" COUNT="1"/>
    <PLAYER NAME="Noureddine MORCELI" COUNT="1"/>
    <PLAYER NAME="Nouria MERAH-BENIDA" COUNT="1"/>
    <PLAYER NAME="NÃ¡ndor DÃ&#x81;NI" COUNT="1"/>
    <PLAYER NAME="Oana PANTELIMON" COUNT="1"/>
    <PLAYER NAME="Obadele THOMPSON" COUNT="1"/>
    <PLAYER NAME="Oleg Georgiyevich FEDOSEYEV" COUNT="1"/>
    <PLAYER NAME="Oleksandr BAGACH" COUNT="1"/>
    <PLAYER NAME="Oleksandr KRYKUN" COUNT="1"/>
    <PLAYER NAME="Oleksiy KRYKUN" COUNT="1"/>
    <PLAYER NAME="Olena ANTONOVA" COUNT="1"/>
    <PLAYER NAME="Olena HOVOROVA" COUNT="1"/>
    <PLAYER NAME="Olena KRASOVSKA" COUNT="1"/>
    <PLAYER NAME="Olga BRYZGINA" COUNT="1"/>
    <PLAYER NAME="Olga KANISKINA" COUNT="1"/>
    <PLAYER NAME="Olga KUZENKOVA" COUNT="2"/>
    <PLAYER NAME="Olga MINEEVA" COUNT="1"/>
    <PLAYER NAME="Olga RYPAKOVA" COUNT="2"/>
    <PLAYER NAME="Olga SALADUKHA" COUNT="1"/>
    <PLAYER NAME="Olga SHISHIGINA" COUNT="1"/>
    <PLAYER NAME="Olimpiada IVANOVA" COUNT="1"/>
    <PLAYER NAME="Ollie MATSON" COUNT="1"/>
    <PLAYER NAME="Omar MCLEOD" COUNT="1"/>
    <PLAYER NAME="Orlando ORTEGA" COUNT="1"/>
    <PLAYER NAME="Osleidys MENÃ&#x89;NDEZ" COUNT="2"/>
    <PLAYER NAME="Otis DAVIS" COUNT="1"/>
    <PLAYER NAME="Otis HARRIS" COUNT="1"/>
    <PLAYER NAME="Otto NILSSON" COUNT="1"/>
    <PLAYER NAME="Ove ANDERSEN" COUNT="1"/>
    <PLAYER NAME="Paavo NURMI" COUNT="7"/>
    <PLAYER NAME="Paavo YRJÃ&#x96;LÃ&#x84;" COUNT="1"/>
    <PLAYER NAME="Pamela JELIMO" COUNT="1"/>
    <PLAYER NAME="Panagiotis PARASKEVOPOULOS" COUNT="1"/>
    <PLAYER NAME="Paola PIGNI-CACCHI" COUNT="1"/>
    <PLAYER NAME="Parry O'BRIEN" COUNT="2"/>
    <PLAYER NAME="Patricia GIRARD" COUNT="1"/>
    <PLAYER NAME="Patrick FLYNN" COUNT="1"/>
    <PLAYER NAME="Patrick LEAHY" COUNT="2"/>
    <PLAYER NAME="Patrick MCDONALD" COUNT="1"/>
    <PLAYER NAME="Patrick O'CALLAGHAN" COUNT="1"/>
    <PLAYER NAME="Patrick SANG" COUNT="1"/>
    <PLAYER NAME="Patrik SJÃ&#x96;BERG" COUNT="1"/>
    <PLAYER NAME="Paul BITOK" COUNT="2"/>
    <PLAYER NAME="Paul BONTEMPS" COUNT="1"/>
    <PLAYER NAME="Paul DRAYTON" COUNT="1"/>
    <PLAYER NAME="Paul Kipkemoi CHELIMO" COUNT="1"/>
    <PLAYER NAME="Paul Kipngetich TANUI" COUNT="1"/>
    <PLAYER NAME="Paul Kipsiele KOECH" COUNT="1"/>
    <PLAYER NAME="Paul MARTIN" COUNT="1"/>
    <PLAYER NAME="Paul TERGAT" COUNT="2"/>
    <PLAYER NAME="Paul Vincent NIHILL" COUNT="1"/>
    <PLAYER NAME="Paul WEINSTEIN" COUNT="1"/>
    <PLAYER NAME="Paul WINTER" COUNT="1"/>
    <PLAYER NAME="Paul-Heinz WELLMANN" COUNT="1"/>
    <PLAYER NAME="Paula MOLLENHAUER" COUNT="1"/>
    <PLAYER NAME="Pauli NEVALA" COUNT="1"/>
    <PLAYER NAME="Pauline DAVIS" COUNT="1"/>
    <PLAYER NAME="Pauline KONGA" COUNT="1"/>
    <PLAYER NAME="Pekka VASALA" COUNT="1"/>
    <PLAYER NAME="Percy BEARD" COUNT="1"/>
    <PLAYER NAME="Percy HODGE" COUNT="1"/>
    <PLAYER NAME="Percy WILLIAMS" COUNT="2"/>
    <PLAYER NAME="Peter FRENKEL" COUNT="2"/>
    <PLAYER NAME="Peter NORMAN" COUNT="1"/>
    <PLAYER NAME="Peter PETROV" COUNT="1"/>
    <PLAYER NAME="Peter RADFORD" COUNT="1"/>
    <PLAYER NAME="Peter SNELL" COUNT="3"/>
    <PLAYER NAME="Peter ZAREMBA" COUNT="1"/>
    <PLAYER NAME="Philip BAKER" COUNT="1"/>
    <PLAYER NAME="Philip EDWARDS" COUNT="3"/>
    <PLAYER NAME="Phillips IDOWU" COUNT="1"/>
    <PLAYER NAME="Pierre LEWDEN" COUNT="1"/>
    <PLAYER NAME="Pietro MENNEA" COUNT="2"/>
    <PLAYER NAME="Piotr MALACHOWSKI" COUNT="2"/>
    <PLAYER NAME="Piotr POCHINCHUK" COUNT="1"/>
    <PLAYER NAME="Primoz KOZMUS" COUNT="2"/>
    <PLAYER NAME="Priscah JEPTOO" COUNT="1"/>
    <PLAYER NAME="Priscilla LOPES-SCHLIEP" COUNT="1"/>
    <PLAYER NAME="Pyotr BOLOTNIKOV" COUNT="1"/>
    <PLAYER NAME="Quincy WATTS" COUNT="1"/>
    <PLAYER NAME="Rachid EL BASIR" COUNT="1"/>
    <PLAYER NAME="Raelene Ann BOYLE" COUNT="3"/>
    <PLAYER NAME="Rafer JOHNSON" COUNT="2"/>
    <PLAYER NAME="Ragnar Torsten LUNDBERG" COUNT="1"/>
    <PLAYER NAME="Ralph BOSTON" COUNT="2"/>
    <PLAYER NAME="Ralph CRAIG" COUNT="2"/>
    <PLAYER NAME="Ralph DOUBELL" COUNT="1"/>
    <PLAYER NAME="Ralph HILL" COUNT="1"/>
    <PLAYER NAME="Ralph HILLS" COUNT="1"/>
    <PLAYER NAME="Ralph MANN" COUNT="1"/>
    <PLAYER NAME="Ralph METCALFE" COUNT="3"/>
    <PLAYER NAME="Ralph ROSE" COUNT="5"/>
    <PLAYER NAME="Randel Luvelle WILLIAMS" COUNT="1"/>
    <PLAYER NAME="Randy BARNES" COUNT="1"/>
    <PLAYER NAME="Randy MATSON" COUNT="1"/>
    <PLAYER NAME="Raphael HOLZDEPPE" COUNT="1"/>
    <PLAYER NAME="Raymond James BARBUTI" COUNT="1"/>
    <PLAYER NAME="RaÃºl GONZÃ&#x81;LEZ" COUNT="2"/>
    <PLAYER NAME="Reese HOFFA" COUNT="1"/>
    <PLAYER NAME="Reggie WALKER" COUNT="1"/>
    <PLAYER NAME="Rein AUN" COUNT="1"/>
    <PLAYER NAME="Reinaldo GORNO" COUNT="1"/>
    <PLAYER NAME="Renate GARISCH-CULMBERGER-BOY" COUNT="1"/>
    <PLAYER NAME="Renate STECHER" COUNT="4"/>
    <PLAYER NAME="Renaud LAVILLENIE" COUNT="2"/>
    <PLAYER NAME="Reuben KOSGEI" COUNT="1"/>
    <PLAYER NAME="Ria STALMAN" COUNT="1"/>
    <PLAYER NAME="Richard CHELIMO" COUNT="1"/>
    <PLAYER NAME="Richard COCHRAN" COUNT="1"/>
    <PLAYER NAME="Richard Charles WOHLHUTER" COUNT="1"/>
    <PLAYER NAME="Richard HOWARD" COUNT="1"/>
    <PLAYER NAME="Richard Kipkemboi MATEELONG" COUNT="1"/>
    <PLAYER NAME="Richard Leslie BYRD" COUNT="1"/>
    <PLAYER NAME="Richard SHELDON" COUNT="1"/>
    <PLAYER NAME="Richard THOMPSON" COUNT="1"/>
    <PLAYER NAME="Rick MITCHELL" COUNT="1"/>
    <PLAYER NAME="Rink BABKA" COUNT="1"/>
    <PLAYER NAME="Rita JAHN" COUNT="1"/>
    <PLAYER NAME="Robert CLOUGHEN" COUNT="1"/>
    <PLAYER NAME="Robert GARRETT" COUNT="5"/>
    <PLAYER NAME="Robert GRABARZ" COUNT="1"/>
    <PLAYER NAME="Robert HARTING" COUNT="1"/>
    <PLAYER NAME="Robert HEFFERNAN" COUNT="1"/>
    <PLAYER NAME="Robert Hyatt CLARK" COUNT="1"/>
    <PLAYER NAME="Robert KERR" COUNT="2"/>
    <PLAYER NAME="Robert KORZENIOWSKI" COUNT="4"/>
    <PLAYER NAME="Robert Keyser SCHUL" COUNT="1"/>
    <PLAYER NAME="Robert MCMILLEN" COUNT="1"/>
    <PLAYER NAME="Robert Morton Newburgh TISDALL" COUNT="1"/>
    <PLAYER NAME="Robert SHAVLAKADZE" COUNT="1"/>
    <PLAYER NAME="Robert STANGLAND" COUNT="2"/>
    <PLAYER NAME="Robert TAYLOR" COUNT="1"/>
    <PLAYER NAME="Robert VAN OSDEL" COUNT="1"/>
    <PLAYER NAME="Robert ZMELÃ&#x8d;K" COUNT="1"/>
    <PLAYER NAME="Roberta BRUNET" COUNT="1"/>
    <PLAYER NAME="Roberto MOYA" COUNT="1"/>
    <PLAYER NAME="Rod MILBURN" COUNT="1"/>
    <PLAYER NAME="Rodney DIXON" COUNT="1"/>
    <PLAYER NAME="Roger BLACK" COUNT="1"/>
    <PLAYER NAME="Roger KINGDOM" COUNT="1"/>
    <PLAYER NAME="Roger MOENS" COUNT="1"/>
    <PLAYER NAME="Roland WIESER" COUNT="1"/>
    <PLAYER NAME="Rolf DANNEBERG" COUNT="1"/>
    <PLAYER NAME="Roman SCHURENKO" COUNT="1"/>
    <PLAYER NAME="Roman SEBRLE" COUNT="2"/>
    <PLAYER NAME="Romas UBARTAS" COUNT="1"/>
    <PLAYER NAME="Romeo BERTINI" COUNT="1"/>
    <PLAYER NAME="Romuald KLIM" COUNT="1"/>
    <PLAYER NAME="Ron CLARKE" COUNT="1"/>
    <PLAYER NAME="Ron DELANY" COUNT="1"/>
    <PLAYER NAME="Ron FREEMAN" COUNT="1"/>
    <PLAYER NAME="Ronald MORRIS" COUNT="1"/>
    <PLAYER NAME="Ronald WEIGEL" COUNT="3"/>
    <PLAYER NAME="Rosa MOTA" COUNT="2"/>
    <PLAYER NAME="Rosemarie WITSCHAS-ACKERMANN" COUNT="1"/>
    <PLAYER NAME="Roy Braxton COCHRAN" COUNT="1"/>
    <PLAYER NAME="Rui SILVA" COUNT="1"/>
    <PLAYER NAME="Rune LARSSON" COUNT="1"/>
    <PLAYER NAME="Ruth BEITIA" COUNT="1"/>
    <PLAYER NAME="Ruth FUCHS" COUNT="2"/>
    <PLAYER NAME="Ruth JEBET" COUNT="1"/>
    <PLAYER NAME="Ruth OSBURN" COUNT="1"/>
    <PLAYER NAME="Ruth SVEDBERG" COUNT="1"/>
    <PLAYER NAME="Ryan CROUSER" COUNT="1"/>
    <PLAYER NAME="Ryszard KATUS" COUNT="1"/>
    <PLAYER NAME="Sabine BRAUN" COUNT="1"/>
    <PLAYER NAME="Sabine EVERTS" COUNT="1"/>
    <PLAYER NAME="Sabine JOHN" COUNT="1"/>
    <PLAYER NAME="Saida GUNBA" COUNT="1"/>
    <PLAYER NAME="Salah HISSOU" COUNT="1"/>
    <PLAYER NAME="Sally GUNNELL" COUNT="1"/>
    <PLAYER NAME="Sally Jepkosgei KIPYEGO" COUNT="1"/>
    <PLAYER NAME="Sally PEARSON" COUNT="2"/>
    <PLAYER NAME="Salvatore MORALE" COUNT="1"/>
    <PLAYER NAME="Sam GRADDY" COUNT="1"/>
    <PLAYER NAME="Sam KENDRICKS" COUNT="1"/>
    <PLAYER NAME="Samson KITUR" COUNT="1"/>
    <PLAYER NAME="Samuel FERRIS" COUNT="1"/>
    <PLAYER NAME="Samuel JONES" COUNT="1"/>
    <PLAYER NAME="Samuel Kamau WANJIRU" COUNT="1"/>
    <PLAYER NAME="Samuel MATETE" COUNT="1"/>
    <PLAYER NAME="Sandi MORRIS" COUNT="1"/>
    <PLAYER NAME="Sandra FARMER-PATRICK" COUNT="1"/>
    <PLAYER NAME="Sandra PERKOVIC" COUNT="2"/>
    <PLAYER NAME="Sandro BELLUCCI" COUNT="1"/>
    <PLAYER NAME="Sanya RICHARDS-ROSS" COUNT="2"/>
    <PLAYER NAME="Sara KOLAK" COUNT="1"/>
    <PLAYER NAME="Sara SIMEONI" COUNT="2"/>
    <PLAYER NAME="Sara Slott PETERSEN" COUNT="1"/>
    <PLAYER NAME="Sarka KASPARKOVA" COUNT="1"/>
    <PLAYER NAME="SaÃ¯d AOUITA" COUNT="1"/>
    <PLAYER NAME="Schuyler ENCK" COUNT="1"/>
    <PLAYER NAME="Sebastian COE" COUNT="4"/>
    <PLAYER NAME="Semyon RZISHCHIN" COUNT="1"/>
    <PLAYER NAME="Seppo RÃ&#x84;TY" COUNT="2"/>
    <PLAYER NAME="Sergei ZHELANOV" COUNT="1"/>
    <PLAYER NAME="Sergey KLYUGIN" COUNT="1"/>
    <PLAYER NAME="Sergey LITVINOV" COUNT="1"/>
    <PLAYER NAME="Sergey MAKAROV" COUNT="2"/>
    <PLAYER NAME="Setymkul DZHUMANAZAROV" COUNT="1"/>
    <PLAYER NAME="Shalane FLANAGAN" COUNT="1"/>
    <PLAYER NAME="Shaunae MILLER" COUNT="1"/>
    <PLAYER NAME="Shawn CRAWFORD" COUNT="2"/>
    <PLAYER NAME="Sheena TOSTA" COUNT="1"/>
    <PLAYER NAME="Sheila LERWILL" COUNT="1"/>
    <PLAYER NAME="Shelly-Ann FRASER-PRYCE" COUNT="4"/>
    <PLAYER NAME="Shenjie QIEYANG" COUNT="1"/>
    <PLAYER NAME="Shericka JACKSON" COUNT="1"/>
    <PLAYER NAME="Shericka WILLIAMS" COUNT="1"/>
    <PLAYER NAME="Sherone SIMPSON" COUNT="1"/>
    <PLAYER NAME="Shirley CAWLEY" COUNT="1"/>
    <PLAYER NAME="Shirley STRICKLAND" COUNT="2"/>
    <PLAYER NAME="Shirley STRONG" COUNT="1"/>
    <PLAYER NAME="Shoryu NAN" COUNT="1"/>
    <PLAYER NAME="Shuhei NISHIDA" COUNT="1"/>
    <PLAYER NAME="Sidney ATKINSON" COUNT="2"/>
    <PLAYER NAME="Sidney ROBINSON" COUNT="1"/>
    <PLAYER NAME="Siegfried WENTZ" COUNT="1"/>
    <PLAYER NAME="Sileshi SIHINE" COUNT="2"/>
    <PLAYER NAME="Silke RENK" COUNT="1"/>
    <PLAYER NAME="Silvia CHIVAS BARO" COUNT="1"/>
    <PLAYER NAME="Silvio LEONARD SARRIA" COUNT="1"/>
    <PLAYER NAME="Sim INESS" COUNT="1"/>
    <PLAYER NAME="Simeon TORIBIO" COUNT="1"/>
    <PLAYER NAME="Sofia ASSEFA" COUNT="1"/>
    <PLAYER NAME="Sonia O'SULLIVAN" COUNT="1"/>
    <PLAYER NAME="Sophie HITCHON" COUNT="1"/>
    <PLAYER NAME="Sotirios VERSIS" COUNT="1"/>
    <PLAYER NAME="Spyridon LOUIS" COUNT="1"/>
    <PLAYER NAME="Stacy DRAGILA" COUNT="1"/>
    <PLAYER NAME="Stanislawa WALASIEWICZ" COUNT="2"/>
    <PLAYER NAME="Stanley Frank VICKERS" COUNT="1"/>
    <PLAYER NAME="Stanley ROWLEY" COUNT="2"/>
    <PLAYER NAME="Stefan HOLM" COUNT="1"/>
    <PLAYER NAME="Stefano BALDINI" COUNT="1"/>
    <PLAYER NAME="Steffi NERIUS" COUNT="1"/>
    <PLAYER NAME="Stefka KOSTADINOVA" COUNT="1"/>
    <PLAYER NAME="Sten PETTERSSON" COUNT="1"/>
    <PLAYER NAME="Stephan FREIGANG" COUNT="1"/>
    <PLAYER NAME="Stephanie BROWN TRAFTON" COUNT="1"/>
    <PLAYER NAME="Stephanie GRAF" COUNT="1"/>
    <PLAYER NAME="Stephen KIPKORIR" COUNT="1"/>
    <PLAYER NAME="Stephen KIPROTICH" COUNT="1"/>
    <PLAYER NAME="Steve ANDERSON" COUNT="1"/>
    <PLAYER NAME="Steve BACKLEY" COUNT="3"/>
    <PLAYER NAME="Steve CRAM" COUNT="1"/>
    <PLAYER NAME="Steve HOOKER" COUNT="1"/>
    <PLAYER NAME="Steve LEWIS" COUNT="1"/>
    <PLAYER NAME="Steve OVETT" COUNT="2"/>
    <PLAYER NAME="Steve SMITH" COUNT="1"/>
    <PLAYER NAME="Suleiman NYAMBUI" COUNT="1"/>
    <PLAYER NAME="Sulo BÃ&#x84;RLUND" COUNT="1"/>
    <PLAYER NAME="Sunette VILJOEN" COUNT="1"/>
    <PLAYER NAME="Susanthika JAYASINGHE" COUNT="1"/>
    <PLAYER NAME="Sverre HANSEN" COUNT="1"/>
    <PLAYER NAME="Svetlana FEOFANOVA" COUNT="2"/>
    <PLAYER NAME="Svetlana KRIVELYOVA" COUNT="1"/>
    <PLAYER NAME="Svetlana MASTERKOVA" COUNT="2"/>
    <PLAYER NAME="Svetlana SHKOLINA" COUNT="1"/>
    <PLAYER NAME="Sylvio CATOR" COUNT="1"/>
    <PLAYER NAME="Szymon ZIOLKOWSKI" COUNT="1"/>
    <PLAYER NAME="SÃ&#x83;Â¡ndor ROZSNYÃ&#x83;?I" COUNT="1"/>
    <PLAYER NAME="Tadeusz RUT" COUNT="1"/>
    <PLAYER NAME="Tadeusz SLUSARSKI" COUNT="1"/>
    <PLAYER NAME="Taisiya CHENCHIK" COUNT="1"/>
    <PLAYER NAME="Tamara PRESS" COUNT="4"/>
    <PLAYER NAME="Tamirat TOLA" COUNT="1"/>
    <PLAYER NAME="Tanya LAWRENCE" COUNT="1"/>
    <PLAYER NAME="Taoufik MAKHLOUFI" COUNT="3"/>
    <PLAYER NAME="Tapio KANTANEN" COUNT="1"/>
    <PLAYER NAME="Tariku BEKELE" COUNT="1"/>
    <PLAYER NAME="Tatiana ANISIMOVA" COUNT="1"/>
    <PLAYER NAME="Tatiana GRIGORIEVA" COUNT="1"/>
    <PLAYER NAME="Tatiana KAZANKINA" COUNT="3"/>
    <PLAYER NAME="Tatiana KOLPAKOVA" COUNT="1"/>
    <PLAYER NAME="Tatiana LESOVAIA" COUNT="1"/>
    <PLAYER NAME="Tatiana PROVIDOKHINA" COUNT="1"/>
    <PLAYER NAME="Tatiana SKACHKO" COUNT="1"/>
    <PLAYER NAME="Tatyana CHERNOVA" COUNT="2"/>
    <PLAYER NAME="Tatyana KOTOVA" COUNT="2"/>
    <PLAYER NAME="Tatyana LEBEDEVA" COUNT="3"/>
    <PLAYER NAME="Tatyana PETROVA ARKHIPOVA" COUNT="1"/>
    <PLAYER NAME="Tatyana SHCHELKANOVA" COUNT="1"/>
    <PLAYER NAME="Tatyana TOMASHOVA" COUNT="1"/>
    <PLAYER NAME="Terence Lloyd JOHNSON" COUNT="1"/>
    <PLAYER NAME="Tereza MARINOVA" COUNT="1"/>
    <PLAYER NAME="Tero PITKAMAKI" COUNT="1"/>
    <PLAYER NAME="Terrence TRAMMELL" COUNT="2"/>
    <PLAYER NAME="Tesfaye TOLA" COUNT="1"/>
    <PLAYER NAME="Tetyana TERESHCHUK" COUNT="1"/>
    <PLAYER NAME="Thaddeus SHIDELER" COUNT="1"/>
    <PLAYER NAME="Thane BAKER" COUNT="3"/>
    <PLAYER NAME="Theresia KIESL" COUNT="1"/>
    <PLAYER NAME="Thiago Braz DA SILVA" COUNT="1"/>
    <PLAYER NAME="Thomas BURKE" COUNT="2"/>
    <PLAYER NAME="Thomas COURTNEY" COUNT="1"/>
    <PLAYER NAME="Thomas CURTIS" COUNT="1"/>
    <PLAYER NAME="Thomas EVENSON" COUNT="1"/>
    <PLAYER NAME="Thomas Francis FARRELL" COUNT="1"/>
    <PLAYER NAME="Thomas Francis KIELY" COUNT="1"/>
    <PLAYER NAME="Thomas HAMPSON" COUNT="1"/>
    <PLAYER NAME="Thomas HICKS" COUNT="1"/>
    <PLAYER NAME="Thomas HILL" COUNT="1"/>
    <PLAYER NAME="Thomas JEFFERSON" COUNT="1"/>
    <PLAYER NAME="Thomas John Henry RICHARDS" COUNT="1"/>
    <PLAYER NAME="Thomas LIEB" COUNT="1"/>
    <PLAYER NAME="Thomas MUNKELT" COUNT="1"/>
    <PLAYER NAME="Thomas Pkemei LONGOSIWA" COUNT="1"/>
    <PLAYER NAME="Thomas ROHLER" COUNT="1"/>
    <PLAYER NAME="Thomas William GREEN" COUNT="1"/>
    <PLAYER NAME="Tia HELLEBAUT" COUNT="1"/>
    <PLAYER NAME="Tianfeng SI" COUNT="1"/>
    <PLAYER NAME="Tianna BARTOLETTA" COUNT="1"/>
    <PLAYER NAME="Tiki GELANA" COUNT="1"/>
    <PLAYER NAME="Tilly FLEISCHER" COUNT="2"/>
    <PLAYER NAME="Tim AHEARNE" COUNT="1"/>
    <PLAYER NAME="Tim FORSYTH" COUNT="1"/>
    <PLAYER NAME="Timothy KITUM" COUNT="1"/>
    <PLAYER NAME="Timothy MACK" COUNT="1"/>
    <PLAYER NAME="Tirunesh DIBABA" COUNT="6"/>
    <PLAYER NAME="Toby STEVENSON" COUNT="1"/>
    <PLAYER NAME="Toivo HYYTIÃ&#x84;INEN" COUNT="1"/>
    <PLAYER NAME="Toivo LOUKOLA" COUNT="1"/>
    <PLAYER NAME="Tomas WALSH" COUNT="1"/>
    <PLAYER NAME="Tomasz MAJEWSKI" COUNT="2"/>
    <PLAYER NAME="Tommie SMITH" COUNT="1"/>
    <PLAYER NAME="TomÃ¡? DVORÃ&#x81;K" COUNT="1"/>
    <PLAYER NAME="Tonique WILLIAMS-DARLING" COUNT="1"/>
    <PLAYER NAME="Tonja BUFORD-BAILEY" COUNT="1"/>
    <PLAYER NAME="Tony DEES" COUNT="1"/>
    <PLAYER NAME="Tore SJÃ&#x96;STRAND" COUNT="1"/>
    <PLAYER NAME="Tori BOWIE" COUNT="2"/>
    <PLAYER NAME="Torsten VOSS" COUNT="1"/>
    <PLAYER NAME="Trey HARDEE" COUNT="1"/>
    <PLAYER NAME="Trine HATTESTAD" COUNT="2"/>
    <PLAYER NAME="Truxtun HARE" COUNT="2"/>
    <PLAYER NAME="Tsegay KEBEDE" COUNT="1"/>
    <PLAYER NAME="Tsvetanka KHRISTOVA" COUNT="1"/>
    <PLAYER NAME="Udo BEYER" COUNT="1"/>
    <PLAYER NAME="Ugo FRIGERIO" COUNT="1"/>
    <PLAYER NAME="Ulrike KLAPEZYNSKI-BRUNS" COUNT="1"/>
    <PLAYER NAME="Ursula DONATH" COUNT="1"/>
    <PLAYER NAME="Urszula KIELAN" COUNT="1"/>
    <PLAYER NAME="Usain BOLT" COUNT="6"/>
    <PLAYER NAME="Ute HOMMOLA" COUNT="1"/>
    <PLAYER NAME="Uwe BEYER" COUNT="1"/>
    <PLAYER NAME="Vadim DEVYATOVSKIY" COUNT="1"/>
    <PLAYER NAME="Vadims VASILEVSKIS" COUNT="1"/>
    <PLAYER NAME="Vala FLOSADÃ&#x93;TTIR" COUNT="1"/>
    <PLAYER NAME="Valentin MASSANA" COUNT="1"/>
    <PLAYER NAME="Valentina YEGOROVA" COUNT="2"/>
    <PLAYER NAME="Valeri BRUMEL" COUNT="2"/>
    <PLAYER NAME="Valeri PODLUZHNYI" COUNT="1"/>
    <PLAYER NAME="Valeria BUFANU" COUNT="1"/>
    <PLAYER NAME="Valerie ADAMS" COUNT="3"/>
    <PLAYER NAME="Valerie BRISCO" COUNT="2"/>
    <PLAYER NAME="Valerio ARRI" COUNT="1"/>
    <PLAYER NAME="Valeriy BORCHIN" COUNT="1"/>
    <PLAYER NAME="Valery BORZOV" COUNT="3"/>
    <PLAYER NAME="Vanderlei DE LIMA" COUNT="1"/>
    <PLAYER NAME="Vasili ARKHIPENKO" COUNT="1"/>
    <PLAYER NAME="Vasili RUDENKOV" COUNT="1"/>
    <PLAYER NAME="Vasiliy KAPTYUKH" COUNT="1"/>
    <PLAYER NAME="Vasily KUZNETSOV" COUNT="2"/>
    <PLAYER NAME="Vassilka STOEVA" COUNT="1"/>
    <PLAYER NAME="VebjÃ¸rn RODAL" COUNT="1"/>
    <PLAYER NAME="Veikko KARVONEN" COUNT="1"/>
    <PLAYER NAME="Veniamin SOLDATENKO" COUNT="1"/>
    <PLAYER NAME="Venuste NIYONGABO" COUNT="1"/>
    <PLAYER NAME="Vera KOLASHNIKOVA-KREPKINA" COUNT="1"/>
    <PLAYER NAME="Vera KOMISOVA" COUNT="1"/>
    <PLAYER NAME="Vera POSPISILOVA-CECHLOVA" COUNT="1"/>
    <PLAYER NAME="Veronica CAMPBELL-BROWN" COUNT="4"/>
    <PLAYER NAME="Viktor KRAVCHENKO" COUNT="1"/>
    <PLAYER NAME="Viktor MARKIN" COUNT="1"/>
    <PLAYER NAME="Viktor RASHCHUPKIN" COUNT="1"/>
    <PLAYER NAME="Viktor SANEYEV" COUNT="1"/>
    <PLAYER NAME="Viktor TSYBULENKO" COUNT="1"/>
    <PLAYER NAME="Vilho Aleksander NIITTYMAA" COUNT="1"/>
    <PLAYER NAME="Ville PÃ&#x96;RHÃ&#x96;LÃ&#x84;" COUNT="1"/>
    <PLAYER NAME="Ville RITOLA" COUNT="5"/>
    <PLAYER NAME="Ville TUULOS" COUNT="1"/>
    <PLAYER NAME="Vilmos VARJU" COUNT="1"/>
    <PLAYER NAME="Vince MATTHEWS" COUNT="1"/>
    <PLAYER NAME="Violeta SZEKELY" COUNT="1"/>
    <PLAYER NAME="Virgilijus ALEKNA" COUNT="3"/>
    <PLAYER NAME="Vita STYOPINA" COUNT="1"/>
    <PLAYER NAME="Vitold KREYER" COUNT="1"/>
    <PLAYER NAME="Vivian Jepkemoi CHERUIYOT" COUNT="4"/>
    <PLAYER NAME="Vladimir ANDREYEV" COUNT="1"/>
    <PLAYER NAME="Vladimir DUBROVSHCHIK" COUNT="1"/>
    <PLAYER NAME="Vladimir GOLUBNICHY" COUNT="4"/>
    <PLAYER NAME="Vladimir GORYAYEV" COUNT="1"/>
    <PLAYER NAME="Vladimir KAZANTSEV" COUNT="1"/>
    <PLAYER NAME="Vladimir KISELEV" COUNT="1"/>
    <PLAYER NAME="Vladimir KUTS" COUNT="2"/>
    <PLAYER NAME="Voitto HELLSTEN" COUNT="1"/>
    <PLAYER NAME="Volker BECK" COUNT="1"/>
    <PLAYER NAME="Volmari ISO-HOLLO" COUNT="4"/>
    <PLAYER NAME="Voula PATOULIDOU" COUNT="1"/>
    <PLAYER NAME="Vyacheslav IVANENKO" COUNT="1"/>
    <PLAYER NAME="Vyacheslav LYKHO" COUNT="1"/>
    <PLAYER NAME="Waldemar CIERPINSKI" COUNT="2"/>
    <PLAYER NAME="Walt DAVIS" COUNT="1"/>
    <PLAYER NAME="Walter DIX" COUNT="2"/>
    <PLAYER NAME="Walter KRÃ&#x9c;GER" COUNT="1"/>
    <PLAYER NAME="Walter RANGELEY" COUNT="1"/>
    <PLAYER NAME="Walter TEWKSBURY" COUNT="3"/>
    <PLAYER NAME="Warren (Rex) Jay CAWLEY" COUNT="1"/>
    <PLAYER NAME="Warren WEIR" COUNT="1"/>
    <PLAYER NAME="Wayde VAN NIEKERK" COUNT="1"/>
    <PLAYER NAME="Wayne COLLETT" COUNT="1"/>
    <PLAYER NAME="Wendell MOTTLEY" COUNT="1"/>
    <PLAYER NAME="Wenxiu ZHANG" COUNT="2"/>
    <PLAYER NAME="Werner LUEG" COUNT="1"/>
    <PLAYER NAME="Wesley COE" COUNT="1"/>
    <PLAYER NAME="Wilfred BUNGEI" COUNT="1"/>
    <PLAYER NAME="Wilhelmina VON BREMEN" COUNT="1"/>
    <PLAYER NAME="Will CLAYE" COUNT="3"/>
    <PLAYER NAME="Willem SLIJKHUIS" COUNT="2"/>
    <PLAYER NAME="Willi HOLDORF" COUNT="1"/>
    <PLAYER NAME="William APPLEGARTH" COUNT="1"/>
    <PLAYER NAME="William Arthur CARR" COUNT="1"/>
    <PLAYER NAME="William CROTHERS" COUNT="1"/>
    <PLAYER NAME="William De Hart HUBBARD" COUNT="1"/>
    <PLAYER NAME="William HAPPENNY" COUNT="1"/>
    <PLAYER NAME="William HOGENSON" COUNT="2"/>
    <PLAYER NAME="William HOLLAND" COUNT="1"/>
    <PLAYER NAME="William MUTWOL" COUNT="1"/>
    <PLAYER NAME="William NIEDER" COUNT="1"/>
    <PLAYER NAME="William Preston MILLER" COUNT="1"/>
    <PLAYER NAME="William TANUI" COUNT="1"/>
    <PLAYER NAME="William VERNER" COUNT="1"/>
    <PLAYER NAME="William Waring MILLER" COUNT="1"/>
    <PLAYER NAME="William Welles HOYT" COUNT="1"/>
    <PLAYER NAME="Willie DAVENPORT" COUNT="2"/>
    <PLAYER NAME="Willie MAY" COUNT="1"/>
    <PLAYER NAME="Willy SCHÃ&#x84;RER" COUNT="1"/>
    <PLAYER NAME="Wilma RUDOLPH" COUNT="2"/>
    <PLAYER NAME="Wilson Boit KIPKETER" COUNT="1"/>
    <PLAYER NAME="Wilson KIPKETER" COUNT="2"/>
    <PLAYER NAME="Wilson KIPRUGUT" COUNT="2"/>
    <PLAYER NAME="Wilson Kipsang KIPROTICH" COUNT="1"/>
    <PLAYER NAME="Winthrop GRAHAM" COUNT="1"/>
    <PLAYER NAME="Wladyslaw KOZAKIEWICZ" COUNT="1"/>
    <PLAYER NAME="Wojciech NOWICKI" COUNT="1"/>
    <PLAYER NAME="Wolfgang HANISCH" COUNT="1"/>
    <PLAYER NAME="Wolfgang REINHARDT" COUNT="1"/>
    <PLAYER NAME="Wolfgang SCHMIDT" COUNT="1"/>
    <PLAYER NAME="Wolrad EBERLE" COUNT="1"/>
    <PLAYER NAME="Wyndham HALSWELLE" COUNT="1"/>
    <PLAYER NAME="Wyomia TYUS" COUNT="2"/>
    <PLAYER NAME="Xiang LIU" COUNT="1"/>
    <PLAYER NAME="Ximena RESTREPO" COUNT="1"/>
    <PLAYER NAME="Xinmei SUI" COUNT="1"/>
    <PLAYER NAME="Xiuzhi LU" COUNT="1"/>
    <PLAYER NAME="Yanfeng LI" COUNT="1"/>
    <PLAYER NAME="Yanina KAROLCHIK" COUNT="1"/>
    <PLAYER NAME="Yanis LUSIS" COUNT="1"/>
    <PLAYER NAME="Yarelys BARRIOS" COUNT="1"/>
    <PLAYER NAME="Yarisley SILVA" COUNT="1"/>
    <PLAYER NAME="Yaroslav RYBAKOV" COUNT="1"/>
    <PLAYER NAME="Yasmani COPELLO" COUNT="1"/>
    <PLAYER NAME="Yelena GORCHAKOVA" COUNT="2"/>
    <PLAYER NAME="Yelena ISINBAEVA" COUNT="3"/>
    <PLAYER NAME="Yelena PROKHOROVA" COUNT="1"/>
    <PLAYER NAME="Yelena YELESINA" COUNT="1"/>
    <PLAYER NAME="Yelizaveta BAGRYANTSEVA" COUNT="1"/>
    <PLAYER NAME="Yevgeni ARZHANOV" COUNT="1"/>
    <PLAYER NAME="Yevgeni GAVRILENKO" COUNT="1"/>
    <PLAYER NAME="Yevgeni MASKINSKOV" COUNT="1"/>
    <PLAYER NAME="Yevgeny Mikhaylovich IVCHENKO" COUNT="1"/>
    <PLAYER NAME="Yipsi MORENO" COUNT="2"/>
    <PLAYER NAME="Yoel GARCÃ&#x8d;A" COUNT="1"/>
    <PLAYER NAME="Yoelvis QUESADA" COUNT="1"/>
    <PLAYER NAME="Yohan BLAKE" COUNT="2"/>
    <PLAYER NAME="Yordanka BLAGOEVA-DIMITROVA" COUNT="1"/>
    <PLAYER NAME="Yordanka DONKOVA" COUNT="1"/>
    <PLAYER NAME="Young-Cho HWANG" COUNT="1"/>
    <PLAYER NAME="Yuko ARIMORI" COUNT="2"/>
    <PLAYER NAME="Yulimar ROJAS" COUNT="1"/>
    <PLAYER NAME="Yuliya NESTSIARENKA" COUNT="1"/>
    <PLAYER NAME="Yumileidi CUMBA" COUNT="1"/>
    <PLAYER NAME="Yunaika CRAWFORD" COUNT="1"/>
    <PLAYER NAME="Yunxia QU" COUNT="1"/>
    <PLAYER NAME="Yuri KUTSENKO" COUNT="1"/>
    <PLAYER NAME="Yuri SEDYKH" COUNT="2"/>
    <PLAYER NAME="Yuri TAMM" COUNT="1"/>
    <PLAYER NAME="Yuriy BORZAKOVSKIY" COUNT="1"/>
    <PLAYER NAME="Yury Nikolayevich LITUYEV" COUNT="1"/>
    <PLAYER NAME="Yvette WILLIAMS" COUNT="1"/>
    <PLAYER NAME="Zdzislaw KRZYSZKOWIAK" COUNT="1"/>
    <PLAYER NAME="Zelin CAI" COUNT="1"/>
    <PLAYER NAME="Zersenay TADESE" COUNT="1"/>
    <PLAYER NAME="Zhen WANG" COUNT="2"/>
    <PLAYER NAME="Zhihong HUANG" COUNT="1"/>
    <PLAYER NAME="Zoltan KOVAGO" COUNT="1"/>
    <PLAYER NAME="Zuzana HEJNOVA" COUNT="1"/>
    <PLAYER NAME="Ã&#x83;â&#x80;&#x93;dÃ&#x83;Â¶n FÃ&#x83;â&#x80;&#x93;LDESSY" COUNT="1"/>
    <PLAYER NAME="Ã&#x89;mile CHAMPION" COUNT="1"/>
</PLAYERS>
```
**8. lekérdezés:**

A lekérdezés egy olyan XML dokumentumot állít elő, amely visszaadja a női versenyszámok nevét, illetve a versenyszám aranyérmesének adatait, olimpiánként.

Kapcsolódó [XML Séma](./xml+schema/8_feladat.xsd)

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
            <EVENTS ALL="{fn:count($events)}">
                {
                    for $item in $items
                    where fn:contains($item?name, "Women")
                    return <EVENT NAME="{$item?name}">
                    { 
                      for $game in $item?games?*
                      return <GAME YEAR="{$game?year}" LOCATION="{$game?location}">
                        { 
                            for $result in $game?results?*
                            where $result?medal eq "G"
                            return <PLAYER NAME="{$result?name}" RESULT="{$result?result}" NATIONALITY="{$result?nationality}"/>
                        }
                        </GAME>
                    }
                    </EVENT>
                }
            </EVENTS>
        }}
```
**Eredmény:**
```xml
<EVENTS ALL="47">
    <EVENT NAME="10000M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Almaz AYANA" RESULT="29:17.45" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Tirunesh DIBABA" RESULT="29:54.66" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Derartu TULU" RESULT="30:17.49" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Derartu TULU" RESULT="31:06.02" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Tirunesh DIBABA" RESULT="30:20.75" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Huina XING" RESULT="30:24.36" NATIONALITY="CHN"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Fernanda RIBEIRO" RESULT="31:01.63" NATIONALITY="POR"/>
        </GAME>
    </EVENT>
    <EVENT NAME="100M Hurdles Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Brianna ROLLINS" RESULT="12.48" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Dawn HARPER" RESULT="12.54,+0.1" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Olga SHISHIGINA" RESULT="12.65" NATIONALITY="KAZ"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Voula PATOULIDOU" RESULT="12.64" NATIONALITY="GRE"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Benita FITZGERALD-BROWN" RESULT="12.84" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Johanna SCHALLER-KLIER" RESULT="12.77" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Sally PEARSON" RESULT="12.35" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Joanna HAYES" RESULT="12.37" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Ludmila ENGQUIST" RESULT="12.58" NATIONALITY="SWE"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Vera KOMISOVA" RESULT="12.56" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Annelie EHRHARDT" RESULT="12.59" NATIONALITY="GDR"/>
        </GAME>
    </EVENT>
    <EVENT NAME="100M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Elaine THOMPSON" RESULT="10.71" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Shelly-Ann FRASER-PRYCE" RESULT="10.78" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney"/>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Gail DEVERS" RESULT="10.82" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Evelyn ASHFORD" RESULT="10.97" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Annegret RICHTER-IRRGANG" RESULT="11.08" NATIONALITY="FRG"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Wyomia TYUS" RESULT="11" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Wilma RUDOLPH" RESULT="11" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Marjorie JACKSON" RESULT="11.5" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="1936" LOCATION="Berlin">
            <PLAYER NAME="Helen STEPHENS" RESULT="11.5" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1928" LOCATION="Amsterdam">
            <PLAYER NAME="Elizabeth ROBINSON" RESULT="12.2" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Shelly-Ann FRASER-PRYCE" RESULT="10.75" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Yuliya NESTSIARENKA" RESULT="10.93" NATIONALITY="BLR"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Gail DEVERS" RESULT="10.94" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Lyudmila KONDRATYEVA" RESULT="11.06" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Renate STECHER" RESULT="11.07" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Wyomia TYUS" RESULT="11.4" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1956" LOCATION="Melbourne / Stockholm">
            <PLAYER NAME="Betty CUTHBERT" RESULT="11.5" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="1948" LOCATION="London">
            <PLAYER NAME="Fanny BLANKERS-KOEN" RESULT="11.9" NATIONALITY="NED"/>
        </GAME>
        <GAME YEAR="1932" LOCATION="Los Angeles">
            <PLAYER NAME="Stanislawa WALASIEWICZ" RESULT="11.9" NATIONALITY="POL"/>
        </GAME>
    </EVENT>
    <EVENT NAME="1500M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Faith Chepngetich KIPYEGON"
                    RESULT="4:08.92"
                    NATIONALITY="KEN"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Nancy Jebet LAGAT" RESULT="4:00.23" NATIONALITY="KEN"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Nouria MERAH-BENIDA" RESULT="04:05.10" NATIONALITY="ALG"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Hassiba BOULMERKA" RESULT="3:55.30" NATIONALITY="ALG"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Gabriella DORIO" RESULT="4:03.25" NATIONALITY="ITA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Tatiana KAZANKINA" RESULT="4:05.48" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London"/>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Kelly HOLMES" RESULT="3:57.90" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Svetlana MASTERKOVA" RESULT="4:00.83" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Tatiana KAZANKINA" RESULT="3:56.6" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Lyudmila BRAGINA" RESULT="4:01.38" NATIONALITY="URS"/>
        </GAME>
    </EVENT>
    <EVENT NAME="200M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Elaine THOMPSON" RESULT="21.78" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Veronica CAMPBELL-BROWN"
                    RESULT="21.74,+0.6"
                    NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Pauline DAVIS" RESULT="22.27" NATIONALITY="BAH"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Gwen TORRENCE" RESULT="21.81" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Valerie BRISCO" RESULT="21.81" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="BÃ¤rbel ECKERT-WÃ&#x96;CKEL" RESULT="22.37" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Irena KIRSZENSTEIN" RESULT="22.5" NATIONALITY="POL"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Wilma RUDOLPH" RESULT="24" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Marjorie JACKSON" RESULT="23.7" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Allyson FELIX" RESULT="21.88" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Veronica CAMPBELL-BROWN" RESULT="22.05" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Marie-JosÃ© PÃ&#x89;REC" RESULT="22.12" NATIONALITY="FRA"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="BÃ¤rbel ECKERT-WÃ&#x96;CKEL" RESULT="22.03" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Renate STECHER" RESULT="22.4" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Edith MCGUIRE" RESULT="23" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1956" LOCATION="Melbourne / Stockholm">
            <PLAYER NAME="Betty CUTHBERT" RESULT="23.4" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="1948" LOCATION="London">
            <PLAYER NAME="Fanny BLANKERS-KOEN" RESULT="24.4" NATIONALITY="NED"/>
        </GAME>
    </EVENT>
    <EVENT NAME="20Km Race Walk Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Hong LIU" RESULT="1:28:35" NATIONALITY="CHN"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Olga KANISKINA" RESULT="1h26:31" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Liping WANG" RESULT="01h29:05" NATIONALITY="CHN"/>
            <PLAYER NAME="Liping WANG" RESULT="01h29:05" NATIONALITY="CHN"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Elena LASHMANOVA" RESULT="1:25:02" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Athanasia TSOUMELEKA" RESULT="1h29:12" NATIONALITY="GRE"/>
        </GAME>
    </EVENT>
    <EVENT NAME="3000M Steeplechase Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Ruth JEBET" RESULT="8:59.75" NATIONALITY="BRN"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Gulnara SAMITOVA" RESULT="8:58.81" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Habiba GHRIBI" RESULT="9:08.37" NATIONALITY="TUN"/>
        </GAME>
    </EVENT>
    <EVENT NAME="400M Hurdles Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Dalilah MUHAMMAD" RESULT="53.13" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Melaine WALKER" RESULT="52.64" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Irina PRIVALOVA" RESULT="53.02" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Sally GUNNELL" RESULT="53.23" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Nawal EL MOUTAWAKEL" RESULT="54.61" NATIONALITY="MAR"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Natalya ANTYUKH" RESULT="52.7" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Fani KHALKIA" RESULT="52.82" NATIONALITY="GRE"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Deon Marie HEMMINGS" RESULT="52.82" NATIONALITY="JAM"/>
        </GAME>
    </EVENT>
    <EVENT NAME="400M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Shaunae MILLER" RESULT="49.44" NATIONALITY="BAH"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Christine OHURUOGU" RESULT="49.62" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Cathy FREEMAN" RESULT="49.11" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Marie-JosÃ© PÃ&#x89;REC" RESULT="48.83" NATIONALITY="FRA"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Valerie BRISCO" RESULT="48.83" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Irena KIRSZENSTEIN" RESULT="49.29" NATIONALITY="POL"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Colette BESSON" RESULT="52" NATIONALITY="FRA"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Sanya RICHARDS-ROSS" RESULT="49.55" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Tonique WILLIAMS-DARLING" RESULT="49.41" NATIONALITY="BAH"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Marie-JosÃ© PÃ&#x89;REC" RESULT="48.25" NATIONALITY="FRA"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Marita KOCH" RESULT="48.88" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Monika ZEHRT" RESULT="51.08" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Betty CUTHBERT" RESULT="52" NATIONALITY="AUS"/>
        </GAME>
    </EVENT>
    <EVENT NAME="4X100M Relay Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="" RESULT="41.01" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="" RESULT="42.54" NATIONALITY="BEL"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="" RESULT="41.95" NATIONALITY="BAH"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="" RESULT="42.11" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="" RESULT="41.65" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="" RESULT="42.55" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="" RESULT="42.8" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="" RESULT="44.5" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="" RESULT="45.9" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1936" LOCATION="Berlin">
            <PLAYER NAME="" RESULT="46.9" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1928" LOCATION="Amsterdam">
            <PLAYER NAME="" RESULT="48.4" NATIONALITY="CAN"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="" RESULT="40.82" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="" RESULT="41.73" NATIONALITY="JAM"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="" RESULT="41.95" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="" RESULT="41.6" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="" RESULT="42.81" NATIONALITY="FRG"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="" RESULT="43.6" NATIONALITY="POL"/>
        </GAME>
        <GAME YEAR="1956" LOCATION="Melbourne / Stockholm">
            <PLAYER NAME="" RESULT="44.5" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="1948" LOCATION="London">
            <PLAYER NAME="" RESULT="47.5" NATIONALITY="NED"/>
        </GAME>
        <GAME YEAR="1932" LOCATION="Los Angeles">
            <PLAYER NAME="" RESULT="47" NATIONALITY="USA"/>
        </GAME>
    </EVENT>
    <EVENT NAME="4X400M Relay Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="" RESULT="" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="" RESULT="3:18.54" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="" RESULT="03:22.62" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="" RESULT="3:20.20" NATIONALITY="EUN"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="" RESULT="3:18.29" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="" RESULT="3:19.23" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="" RESULT="3:16.87" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="" RESULT="3:19.01" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="" RESULT="3:20.91" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="" RESULT="3:20.2" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="" RESULT="3:23.0" NATIONALITY="GDR"/>
        </GAME>
    </EVENT>
    <EVENT NAME="5000M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Vivian Jepkemoi CHERUIYOT"
                    RESULT="14:26.17"
                    NATIONALITY="KEN"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Tirunesh DIBABA" RESULT="15:41.40" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Gabriela SZABO" RESULT="14:40.79" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Meseret DEFAR" RESULT="15:04.25" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Meseret DEFAR" RESULT="14:45.65" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Junxia WANG" RESULT="14:59.88" NATIONALITY="CHN"/>
        </GAME>
    </EVENT>
    <EVENT NAME="800M Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Caster SEMENYA" RESULT="1:55.28" NATIONALITY="RSA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Pamela JELIMO" RESULT="1:54.87" NATIONALITY="KEN"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Maria MUTOLA" RESULT="01:56.15" NATIONALITY="MOZ"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Ellen VAN LANGEN" RESULT="1:55.54" NATIONALITY="NED"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Doina MELINTE" RESULT="1:57.60" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Tatiana KAZANKINA" RESULT="1:54.94" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Madeline MANNING-JACKSON" RESULT="2:00.9" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Lyudmila SHEVTSOVA" RESULT="2:04.3" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Mariya SAVINOVA" RESULT="1:56.19" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Kelly HOLMES" RESULT="1:56.38" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Svetlana MASTERKOVA" RESULT="1:57.73" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Nadezhda OLIZARENKO" RESULT="1:53.5" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Hildegard FALCK" RESULT="1:58.55" NATIONALITY="FRG"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Ann PACKER" RESULT="2:01.1" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="1928" LOCATION="Amsterdam">
            <PLAYER NAME="Karoline &#34;Lina&#34; RADKE" RESULT="2:16.8" NATIONALITY="GER"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Discus Throw Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Sandra PERKOVIC" RESULT="69.21" NATIONALITY="CRO"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Stephanie BROWN TRAFTON" RESULT="64.74" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Ellina ZVEREVA" RESULT="68.4" NATIONALITY="BLR"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Maritza MARTEN" RESULT="70.06" NATIONALITY="CUB"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Ria STALMAN" RESULT="65.36" NATIONALITY="NED"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Lia MANOLIU" RESULT="58.28" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Nina ROMASHKOVA" RESULT="55.1" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Nina ROMASHKOVA" RESULT="51.42" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1936" LOCATION="Berlin">
            <PLAYER NAME="Gisela MAUERMAYER" RESULT="47.63" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1928" LOCATION="Amsterdam">
            <PLAYER NAME="Halina KONOPACKA" RESULT="39.62" NATIONALITY="POL"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Sandra PERKOVIC" RESULT="69.11" NATIONALITY="CRO"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Natalya SADOVA" RESULT="67.02" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Ilke WYLUDDA" RESULT="69.66" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Evelin SCHLAAK-JAHL" RESULT="69.96" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Faina MELNIK" RESULT="66.62" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Tamara PRESS" RESULT="57.27" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1948" LOCATION="London">
            <PLAYER NAME="Micheline OSTERMEYER" RESULT="41.92" NATIONALITY="FRA"/>
        </GAME>
        <GAME YEAR="1932" LOCATION="Los Angeles">
            <PLAYER NAME="Lillian COPELAND" RESULT="40.58" NATIONALITY="USA"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Hammer Throw Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Anita WLODARCZYK" RESULT="82.29" NATIONALITY="POL"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Yipsi MORENO" RESULT="75.2" NATIONALITY="CUB"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Kamila SKOLIMOWSKA" RESULT="71.16" NATIONALITY="POL"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London"/>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Olga KUZENKOVA" RESULT="75.02" NATIONALITY="RUS"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Heptathlon Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Nafissatou THIAM" RESULT="6810" NATIONALITY="BEL"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Natallia DOBRYNSKA" RESULT="6733" NATIONALITY="UKR"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Denise LEWIS" RESULT="6584" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Jackie JOYNER" RESULT="7044 P." NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Glynis NUNN" RESULT="6390" NATIONALITY="AUS"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Jessica ENNIS HILL" RESULT="6955" NATIONALITY="GBR"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Carolina KLUFT" RESULT="6952" NATIONALITY="SWE"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Ghada SHOUAA" RESULT="6780" NATIONALITY="SYR"/>
        </GAME>
        <GAME YEAR="1988" LOCATION="Seoul">
            <PLAYER NAME="Jackie JOYNER" RESULT="7291 P." NATIONALITY="USA"/>
        </GAME>
    </EVENT>
    <EVENT NAME="High Jump Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Ruth BEITIA" RESULT="" NATIONALITY="ESP"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Tia HELLEBAUT" RESULT="2.05" NATIONALITY="BEL"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Yelena YELESINA" RESULT="2.01" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Heike HENKEL" RESULT="2.02" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Rosemarie WITSCHAS-ACKERMANN" RESULT="1.93" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Iolanda BALAS" RESULT="1.85" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Esther BRAND" RESULT="1.67" NATIONALITY="RSA"/>
        </GAME>
        <GAME YEAR="1936" LOCATION="Berlin">
            <PLAYER NAME="Ibolya CSÃ&#x81;K" RESULT="1.6" NATIONALITY="HUN"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Anna CHICHEROVA" RESULT="2.05" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Elena SLESARENKO" RESULT="2.06" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Stefka KOSTADINOVA" RESULT="2.05" NATIONALITY="BUL"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Sara SIMEONI" RESULT="1.97" NATIONALITY="ITA"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Iolanda BALAS" RESULT="1.9" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="1948" LOCATION="London">
            <PLAYER NAME="Alice COACHMAN" RESULT="1.68" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="1932" LOCATION="Los Angeles">
            <PLAYER NAME="Jean SHILEY" RESULT="1.65" NATIONALITY="USA"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Javelin Throw Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Sara KOLAK" RESULT="66.18" NATIONALITY="CRO"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Barbora SPOTAKOVA" RESULT="71.42" NATIONALITY="CZE"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Trine HATTESTAD" RESULT="68.91" NATIONALITY="NOR"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Silke RENK" RESULT="68.34" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Ruth FUCHS" RESULT="65.94" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Angela NEMETH" RESULT="60.36" NATIONALITY="HUN"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Elvira OZOLINA" RESULT="55.98" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Dana INGROVA-ZATOPKOVA" RESULT="50.47" NATIONALITY="TCH"/>
        </GAME>
        <GAME YEAR="1936" LOCATION="Berlin">
            <PLAYER NAME="Tilly FLEISCHER" RESULT="45.18" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Barbora SPOTAKOVA" RESULT="69.55" NATIONALITY="CZE"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Osleidys MENÃ&#x89;NDEZ" RESULT="71.53" NATIONALITY="CUB"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Heli RANTANEN" RESULT="67.94" NATIONALITY="FIN"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Maria COLON" RESULT="68.4" NATIONALITY="CUB"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Ruth FUCHS" RESULT="63.88" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Mihaela PENES" RESULT="60.54" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="1948" LOCATION="London">
            <PLAYER NAME="Herma BAUMA" RESULT="45.57" NATIONALITY="AUT"/>
        </GAME>
        <GAME YEAR="1932" LOCATION="Los Angeles">
            <PLAYER NAME="Mildred DIDRIKSON" RESULT="43.68" NATIONALITY="USA"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Long Jump Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Tianna BARTOLETTA" RESULT="7.17" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Maurren Higa MAGGI" RESULT="7.04" NATIONALITY="BRA"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Heike DRECHSLER" RESULT="6.99" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Heike DRECHSLER" RESULT="7.14" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Angela VOIGT" RESULT="6.72" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Vera KOLASHNIKOVA-KREPKINA" RESULT="6.37" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Yvette WILLIAMS" RESULT="6.24" NATIONALITY="NZL"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Brittney REESE" RESULT="7.12" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Tatyana LEBEDEVA" RESULT="7.07" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Chioma AJUNWA" RESULT="7.12" NATIONALITY="NGR"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Tatiana KOLPAKOVA" RESULT="7.06" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Mary RAND" RESULT="6.76" NATIONALITY="GBR"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Marathon Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Jemima Jelagat SUMGONG" RESULT="2:24:04" NATIONALITY="KEN"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Constantina TOMESCU" RESULT="2h26:44" NATIONALITY="ROU"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Naoko TAKAHASHI" RESULT="02h23:14" NATIONALITY="JPN"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Valentina YEGOROVA" RESULT="2:32:41" NATIONALITY="EUN"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Joan BENOIT" RESULT="2:24:52" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Tiki GELANA" RESULT="2:23:07" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Mizuki NOGUCHI" RESULT="2h26:20" NATIONALITY="JPN"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Fatuma ROBA" RESULT="2:26:05" NATIONALITY="ETH"/>
        </GAME>
        <GAME YEAR="1988" LOCATION="Seoul">
            <PLAYER NAME="Rosa MOTA" RESULT="2:25:40" NATIONALITY="POR"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Pole Vault Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Ekaterini STEFANIDI" RESULT="4.85" NATIONALITY="GRE"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Yelena ISINBAEVA" RESULT="5.05" NATIONALITY="RUS"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Stacy DRAGILA" RESULT="4.6" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Jennifer SUHR" RESULT="4.75" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Yelena ISINBAEVA" RESULT="4.91" NATIONALITY="RUS"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Shot Put Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Michelle CARTER" RESULT="20.63" NATIONALITY="USA"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Valerie ADAMS" RESULT="20.56" NATIONALITY="NZL"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Yanina KAROLCHIK" RESULT="20.56" NATIONALITY="BLR"/>
        </GAME>
        <GAME YEAR="1992" LOCATION="Barcelona">
            <PLAYER NAME="Svetlana KRIVELYOVA" RESULT="21.06" NATIONALITY="EUN"/>
        </GAME>
        <GAME YEAR="1984" LOCATION="Los Angeles">
            <PLAYER NAME="Claudia LOSCH" RESULT="20.48" NATIONALITY="FRG"/>
        </GAME>
        <GAME YEAR="1976" LOCATION="Montreal">
            <PLAYER NAME="Ivanka KHRISTOVA" RESULT="21.16" NATIONALITY="BUL"/>
        </GAME>
        <GAME YEAR="1968" LOCATION="Mexico">
            <PLAYER NAME="Margitta HELMBOLD-GUMMEL" RESULT="19.61" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1960" LOCATION="Rome">
            <PLAYER NAME="Tamara PRESS" RESULT="17.32" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1952" LOCATION="Helsinki">
            <PLAYER NAME="Galina ZYBINA" RESULT="15.28" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Valerie ADAMS" RESULT="20.7" NATIONALITY="NZL"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Yumileidi CUMBA" RESULT="19.59" NATIONALITY="CUB"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Astrid KUMBERNUSS" RESULT="20.56" NATIONALITY="GER"/>
        </GAME>
        <GAME YEAR="1980" LOCATION="Moscow">
            <PLAYER NAME="Ilona SCHOKNECHT-SLUPIANEK" RESULT="22.41" NATIONALITY="GDR"/>
        </GAME>
        <GAME YEAR="1972" LOCATION="Munich">
            <PLAYER NAME="Nadezhda CHIZHOVA" RESULT="21.03" NATIONALITY="URS"/>
        </GAME>
        <GAME YEAR="1964" LOCATION="Tokyo">
            <PLAYER NAME="Tamara PRESS" RESULT="18.14" NATIONALITY="URS"/>
        </GAME>
    </EVENT>
    <EVENT NAME="Triple Jump Women">
        <GAME YEAR="2016" LOCATION="Rio">
            <PLAYER NAME="Caterine IBARGUEN" RESULT="15.17" NATIONALITY="COL"/>
        </GAME>
        <GAME YEAR="2008" LOCATION="Beijing">
            <PLAYER NAME="Francoise MBANGO ETONE" RESULT="15.39" NATIONALITY="CMR"/>
        </GAME>
        <GAME YEAR="2000" LOCATION="Sydney">
            <PLAYER NAME="Tereza MARINOVA" RESULT="15.2" NATIONALITY="BUL"/>
        </GAME>
        <GAME YEAR="2012" LOCATION="London">
            <PLAYER NAME="Olga RYPAKOVA" RESULT="14.98" NATIONALITY="KAZ"/>
        </GAME>
        <GAME YEAR="2004" LOCATION="Athens">
            <PLAYER NAME="Francoise MBANGO ETONE" RESULT="15.3" NATIONALITY="CMR"/>
        </GAME>
        <GAME YEAR="1996" LOCATION="Atlanta">
            <PLAYER NAME="Inessa KRAVETS" RESULT="15.33" NATIONALITY="UKR"/>
        </GAME>
    </EVENT>
</EVENTS>
```
**9. lekérdezés:**

A lekérdezés egy olyan XML dokumentumot állít elő, amely visszaadja, hogy Usain Bolt melyik olimpián szerepelt és milyen eredménnyel.

Kapcsolódó [XML Séma](./xml+schema/9_feladat.xsd)

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
                    <COUNT ALL="{fn:count($result_of_games)}">
                        {
                            for $game in $data_of_games
                            return <GAME LOCATION="{$game?location}" YEAR="{$game?year}">
                            {
                                for $result in $game?results?*
                                where $result?name eq "Usain BOLT"
                                return <RESULT NAME="{$result?name}" RESULT="{$result?result}" MEDAL="{$result?medal}"/>
                            }
                            </GAME>   
                        }
                    </COUNT>
                    }
               </USAIN>
        }}
```
**Eredmény:**
```xml
<USAIN>
    <COUNT ALL="6">
        <GAME LOCATION="Rio" YEAR="2016">
            <RESULT NAME="Usain BOLT" RESULT="9.81" MEDAL="G"/>
        </GAME>
        <GAME LOCATION="Beijing" YEAR="2008">
            <RESULT NAME="Usain BOLT" RESULT="9.69" MEDAL="G"/>
        </GAME>
        <GAME LOCATION="London" YEAR="2012">
            <RESULT NAME="Usain BOLT" RESULT="9.63" MEDAL="G"/>
        </GAME>
        <GAME LOCATION="Rio" YEAR="2016">
            <RESULT NAME="Usain BOLT" RESULT="19.78" MEDAL="G"/>
        </GAME>
        <GAME LOCATION="Beijing" YEAR="2008">
            <RESULT NAME="Usain BOLT" RESULT="19.30,-0.9" MEDAL="G"/>
        </GAME>
        <GAME LOCATION="London" YEAR="2012">
            <RESULT NAME="Usain BOLT" RESULT="19.32" MEDAL="G"/>
        </GAME>
    </COUNT>
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
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="text-gray-700 font-medium antialiased">
        <div class="container mx-auto">
            <table class="min-w-full mb-20 bg-white drop-shadow-2xl">
        	   <br></br>
                <h1 class="text-5xl font-serif italic text-violet-500 text-center">London</h1>
                <thead class="bg-violet-500 text-white font-normal">
                	<br></br>
                    <tr>
                        <th class="py-3 pl-3 text-xl text-left font-mono rounded-tl-xl">Évszám</th>
                        <th class="py-3 text-xl text-left font-mono">Név</th>
                        <th class="py-3 text-xl text-left font-mono">Nemzetiség</th>
                        <th class="py-3 text-xl text-left font-mono">Eredmény</th>
                        <th class="py-3 text-xl text-left font-mono rounded-tr-xl">Medál</th>
                    </tr>
                </thead>
                    <tbody>
                        {
                            for $game in $games
                            let $results := $game?results?*
                            for $result in $results
                            order by $game?year descending
                            return
                                <tr class="border-b border-violet-200 last:border-b-4 last:border-violet-500 even:bg-violet-100 hover:text-violet-600 hover:font-bold">
                                    <td class="py-2 pl-3 text-lg">{$game?year}</td>
                                    <td>{$result?name}</td>
                                    <td>{$result?nationality}</td>
                                    <td>{$result?result}</td>
                                    <td>{$result?medal}</td>
                                </tr>
                        }
                    </tbody>
                </table>
        </div>
        </body>
    </html>
}
```
## Képernyőmentés
Desktop:
![FullScreen](./html/London.PNG)
