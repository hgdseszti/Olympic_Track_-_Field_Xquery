(: A lekérdezés egy olyan XML dokumentumot állít elő, amely kilistázza, hogy melyik versenyző, hányszor
vett részt az olimpián. :)

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