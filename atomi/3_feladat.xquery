(: Ez a legkérdezés visszaadja, hogy a 2016-os olimpiai játékokon milyen nemzetiségek vettek részt. :)

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
