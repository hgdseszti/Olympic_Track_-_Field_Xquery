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
        "location": $location,
        "gold-medals": local:get-gold-medal-count($location)
    }
})
```
**Eredmény:**
```json
[
        { 
            "gold-medals": 47,
            "location": "Rio" },
        { 
            "gold-medals": 46,
            "location": "Beijing" },
        { 
            "gold-medals": 45,
            "location": "Sydney" },
        { 
            "gold-medals": 41,
            "location": "Barcelona" },
        { 
            "gold-medals": 60,
            "location": "Los Angeles" },
        { 
            "gold-medals": 32,
            "location": "Montreal" },
        { 
            "gold-medals": 25,
            "location": "Mexico" },
        { 
            "gold-medals": 33,
            "location": "Rome" },
        { 
            "gold-medals": 31,
            "location": "Helsinki" },
        { 
            "gold-medals": 22,
            "location": "Berlin" },
        { 
            "gold-medals": 19,
            "location": "Amsterdam" },
        { 
            "gold-medals": 14,
            "location": "Antwerp" },
        { 
            "gold-medals": 83,
            "location": "London" },
        { 
            "gold-medals": 58,
            "location": "Athens" },
        { 
            "gold-medals": 43,
            "location": "Atlanta" },
        { 
            "gold-medals": 37,
            "location": "Moscow" },
        { 
            "gold-medals": 27,
            "location": "Munich" },
        { 
            "gold-medals": 34,
            "location": "Tokyo" },
        { 
            "gold-medals": 19,
            "location": "Melbourne \/ Stockholm" },
        { 
            "gold-medals": 37,
            "location": "Paris" },
        { 
            "gold-medals": 20,
            "location": "Stockholm" },
        { 
            "gold-medals": 17,
            "location": "St Louis" },
        { 
            "gold-medals": 6,
            "location": "Seoul" }
    ]
```
