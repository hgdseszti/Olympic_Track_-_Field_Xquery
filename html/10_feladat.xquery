(: Az olimpiai játékoknak legtöbbször London adott helyet. A lekérdezés egy olyan HTML dokumentumot állít elő, amely szemlélteti a londoni olimpián részt vett dobogós versenyzők adatait, év szerint csökkenő sorrendben. :)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $json := fn:json-doc("../olympic_results.json")?*,
    $games := for $game in $json?games?*
            return $game[?location eq "London"]
            

return document {
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title> London </title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="text-gray-700 font-medium antialiased">
        <div class="container mx-auto">
            <table class="min-w-full mb-20 bg-white drop-shadow-2xl">
        	   <br></br>
                <h1 class="text-5xl font-serif italic text-violet-500 text-center">London</h1>
                <thead class="bg-violet-500 text-white font-normal">
                	<br></br>
                    <tr>
                        <th class="py-3 pl-3 text-xl text-left font-mono rounded-tl-xl">Évszám</th>
                        <th class="py-3 text-xl text-left font-mono">Név</th>
                        <th class="py-3 text-xl text-left font-mono">Nemzetiség</th>
                        <th class="py-3 text-xl text-left font-mono">Eredmény</th>
                        <th class="py-3 text-xl text-left font-mono rounded-tr-xl">Medál</th>
                    </tr>
                </thead>
                    <tbody>
                        {
                            for $game in $games
                            let $results := $game?results?*
                            for $result in $results
                            order by $game?year descending
                            return
                                <tr class="border-b border-violet-200 last:border-b-4 last:border-violet-500 even:bg-violet-100 hover:text-violet-600 hover:font-bold">
                                    <td class="py-2 pl-3 text-lg">{$game?year}</td>
                                    <td>{$result?name}</td>
                                    <td>{$result?nationality}</td>
                                    <td>{$result?result}</td>
                                    <td>{$result?medal}</td>
                                </tr>
                        }
                    </tbody>
                </table>
        </div>
        </body>
    </html>
}