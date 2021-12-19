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
