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

A lekérdezés visszaadja, hogy melyik években voltak olimpiai játékok.

```xquery
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

let $json := fn:json-doc("./olympic_results.json")?*

return array {
    distinct-values(
        for $year in $json?games?*
            return $year?year
    )
}
```
**Eredmény:**
```json
[
        2016,
        2008,
        2000,
        1992,
        1984,
        1976,
        1968,
        1960,
        1952,
        1936,
        1928,
        1920,
        2012,
        2004,
        1996,
        1980,
        1972,
        1964,
        1956,
        1948,
        1932,
        1924,
        1912,
        1908,
        1900,
        1904,
        1896,
        1988
    ]
```

**4. lekérdezés:**

A lekérdezés visszaadja, hogy egy adott évben hány arany érmet szerzett az USA.

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
