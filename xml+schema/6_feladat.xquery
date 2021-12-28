(: A lekérdezés egy XML dokumentumot állít elő, amely abc sorrendben tartalmazza az összes versenyző nevét, aki érmet
szerzett valaha az olimpián. :)

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