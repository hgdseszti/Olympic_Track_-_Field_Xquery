(: Ez a lekérdezés megszámolja hány olimpiai játék volt 1896 és 2016 között. :)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

let $json := fn:json-doc("../olympic_results.json")?*

return fn:count($json?games)
