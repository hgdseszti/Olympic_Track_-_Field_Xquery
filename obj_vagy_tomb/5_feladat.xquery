(: Ez a lekérdezés megmutatja, hogy hány arany érmet szereztek összesen az adott helyeken. :)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:indent "yes";

declare function local:get-games() {
    let $json := fn:json-doc("../olympic_results.json")?*
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
        "Gold-medals": local:get-gold-medal-count($location)
    }
})