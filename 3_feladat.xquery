(: Ez a lekérdezés megmutatja, hogy melyik években voltak olimpiai játékok. :)

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
