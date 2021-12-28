(: A lekérdezés egy olyan XML dokumentumot állít elő, amely visszaadja a női versenyszámok nevét, illetve a versenyszám aranyérmesének adatait, olimpiánként. :)

xquery version "3.1";

import schema default element namespace "" at "8_feladat.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:indent "yes";

let $json := fn:json-doc("../olympic_results.json")?*
let $events := distinct-values($json?name)
let $items := for $item in $json
                return $item
                
return validate {document {
            <EVENTS ALL="{fn:count($events)}">
                {
                    for $item in $items
                    where fn:contains($item?name, "Women")
                    return <EVENT NAME="{$item?name}">
                    { 
                      for $game in $item?games?*
                      return <GAME YEAR="{$game?year}" LOCATION="{$game?location}">
                        { 
                            for $result in $game?results?*
                            where $result?medal eq "G"
                            return <PLAYER NAME="{$result?name}" RESULT="{$result?result}" NATIONALITY="{$result?nationality}"/>
                        }
                        </GAME>
                    }
                    </EVENT>
                }
            </EVENTS>
        }}