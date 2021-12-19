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
