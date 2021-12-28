(: A lekérdezés egy olyan XML dokumentumot állít elő, amely visszaadja, hogy Usain Bolt melyik olimpián szerepelt és milyen eredménnyel. :)

xquery version "3.1";

import schema default element namespace "" at "9_feladat.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:indent "yes";
let $json := fn:json-doc("../olympic_results.json")?*,
    $result_of_games := for $game in $json?games?*
                            for $result in $game?results?*
                                return $result[?name eq "Usain BOLT"]
                                
let $data_of_games :=   for $game in $json?games?*
                            for $result in $game?results?*
                            where $result?name eq "Usain BOLT"
                            return $game    

return validate {document {
                <USAIN>
                    {
                    <COUNT ALL="{fn:count($result_of_games)}">
                        {
                            for $game in $data_of_games
                            return <GAME LOCATION="{$game?location}" YEAR="{$game?year}">
                            {
                                for $result in $game?results?*
                                where $result?name eq "Usain BOLT"
                                return <RESULT NAME="{$result?name}" RESULT="{$result?result}" MEDAL="{$result?medal}"/>
                            }
                            </GAME>   
                        }
                    </COUNT>
                    }
               </USAIN>
        }}