$word = "abi"

Function addPastSimpleDef {
    param([string]$word)

    #gezdim
    $vowels = "aeıioöuü"
}

Function addPastContDef {
    param([string]$word)﻿# create ExceptionHandler.ps1
# create lists of exceptions in ExceptionHandler.ps1
# handle consonant change
# handle vocal exceptions

$word = "abi"

class NounObj {
    [string]$word
    [bool]$ldExc # letter drop
    [bool]$ccExc # consonant change (pb, cc, kg, td)
    [bool]$veExc # vocal exceptions
    [bool]$yExc # su, suyu
}

Function anayzeWord {
    param($word)

    $vowels = "aeıioöuü"


}

Function addCa {
    param([string]$word)

    $vowels = "aeıioöuü"
}

Function addPastSimpleDef {
    param([string]$word)

    #gezdim
    $vowels = "aeıioöuü"
}

Function addPastContDef {
    param([string]$word)

    # geziyordum
    $vowels = "aeıioöuü"
}

Function addFutureDef {
    param([string]$word)

    # gezecegim, bilecegim
    $vowels = "aeıioöuü"
}

Function addPresentContDef {
    param([string]$word)
    # geziyorum, kesiyorum, yuzuyorum, koyuyorum, biliyorum

    $vowels = $vowels = "aeıioöuü"
}

Function addAoristDef {
    param([string]$word)
    # gezebilirim, yuzebilirim, gidebilirim, gelebilirim, bilebilirim

    $vowels = $vowels = "aeıioöuü"
}

Function addInperative {
    # a, in
}

Function addCanDef {
    param($word)
}

Function addDative {
    # (y)a / (y)e
}

Function addLocative {
    # da, de, ta, te
}

Function addAblative {
    # dan, den, tan, ten
}

Function addGenitive {
    # (n)ın, (n)in, (n)un, (n)ün
}

Function addInstrumental {
    # (y)le, (y)lar
}

Function plural {
    # ler, lar
}

Function kkenDef {
    # when I was
}

Function bagliDef {
    
}

Function ragmenDef {
    # bamamana ragmen
}

Function addDef {
    param([string]$word)

    $wordArr = $word.ToCharArray()
    $output = $null
    $suffix = $null

    # ZAMIANA LITER
    # sehir -> sehri, nehir, nehri
    $irExc = @("boyun", "emir", "fikir", "hayır", "kadir", "nehir", "şehir", "şekir", "şükür", "zikir")

    # GLOSSAL HARMONY BY CONSONANT EXCEPTIONS 
    # ç c  p b  g ğ  t d (bez jednosylab., internet, robot, market, reset, set, devlet, saat, seyahat)  k g (a, e, o, ö)  k ğ (u, ü, ı, i)
    $tExc = @("cumhuriyet", "devlet", "internet", "market", "reset", "robot", "saat", "set", "seyahat")
    # + all one syllable

    $pExc = @("sap")
    # + all one syllable

    $kExc = @("ak", "ek")
    # + all one syllable

    # GLOSSAL HARMONY EXCEPTIONS
    $iexc = @("alkol", "hayal", "kalp", "saat", "seyahat")

    $cExc = @("saç", "")
    # + all one syllable

    $ueExc = @("alkol") # -> ü

    # ENCEPTION Y INSTEAD S
    $yExc = @("su")

    # CHANGING 

    $vowels = "aeıioöuü"
    $lastVowel = $null

    foreach ($l in $wordArr) {
        Write-Host "Letter $l"
        if ($vowels.Contains($l)) {
            $lastVowel = $l
            #$index = $i
        }
    }

    $lastLetter = $word.Substring($word.Length-1,1)
    $addS = ""

    if ($vowels.Contains($lastLetter)) {

        $addS = "s"
        if ($yExc.Contains($word)) {
            $addS = "y"
        }

    }

    Write-Host "last vowel: $lastVowel"


    switch($lastVowel) {
        { @("a", "ı") -contains $_ } {
            $suffix = "ı"
            break;
        }
        { @("e", "i") -contains $_ } {
            $suffix = "i"
            break;
        }
        { @("o", "u") -contains $_ } {
            $suffix = "u"
            break;
        } 
        { @("ö", "ü") -contains $_} {
            $suffix = "ü"
            break;
        }
        default {
            Write-Host "def"
        }
    }

    if ($iExc.Contains($word)) {
        $suffix = "i"
    }

    Write-Host "suffix $suffix"

    $output = "$($word)$($addS)$($suffix)"

    <#
    switch($lastVowel) {
        "a" {
            $output = "ı"
            break;
        }
        "e" {
            $output = "i"
            break;
        }
        "u" {
            $output = "u"
            break;
        }
        "ü" {
            $output = "ü"
            break;
        }
        "ı" {
            $output = "ı"
            break;
        }
        "i" {
            $output = "i"
            brake;
        }
        "o" {
            $output = "u"
            brake;
        }
        "ö" {
            $output = "ü"
        }
        
    }
    #>

    return $output
}

function getSyllables {
    param([string]$word)

    $vowels = "aeıioöuü"

    $getLetters = $word.ToCharArray()
    $consIndexes = @()
    $syllables = @()
    $lastIsCons = $false
    $isCons = $false
    $syllable = $null

    for ($i = 0; $i -lt $getLetters.Length; $i++) {
        $prevLetter = if ($i -gt 0) {$getLetters[$i-1]} else {$null}
        $currentLetter = $getLetters[$i]
        $nextLetter = $getLetters[$i+1]

        Write-Host "cl $currentLetter"
        Write-Host "pl $prevLetter"

        if ($i -gt 0 -And (!$vowels.Contains($currentLetter) -And $vowels.Contains($nextLetter) -And $nextLetter)) {
            $syllables += $syllable
            Write-Host "full: $syllable"
            $syllable = $getLetters[$i]
            Write-Host "syl: $syllable"
        } else {
            $syllable += $getLetters[$i]
            Write-Host "add: $syllable"
        }
    }

    $syllables += $syllable

    $syllables

    <#
    foreach ($l in $getLetters) {
        if ($isCons -And $lastIsCons -And $syllable) {
            $syllables += $syllable
            Write-Host $syllable
            $syllable = ""
        } else {
            $syllable += $l
            Write-Host $syllable
        }
    }
    #>
}

getSyllables "Ilac"

#addDef "saat"



<#

$specifiedSuffixes = @(
    ("a", "ı"),
    ("e", "i"),
    ("u", "u"),
    ("ü", "ü"),
    ("i", "i")
)

$nounFormats = @(
    @("benim", "im", "ım", "um", "üm, m, m, m, m"),
    @("senin", "in", "ın", "un", "ün, n, n, n, n"),
    @("onun", "i", "ı", "u", "ü", "si", "sı", "su", "sü")  # x like i, u
    @("bizim", "iz", "ız", "uz", "üz", "miz", "mız", "muz", "müz")
    @("sizin", "iniz", "ınız", "unuz", "ünüz", "niz", "nız", "nuz", "nüz")
    @("onların", "i", "ı", "u", "ü", "si", "sı", "su", "sü")
)

$cFormats = @(
    @("i", "in"),
    @("ı", "ın"),
    @("u", "un"),
    @("ü", "ün")
)

$dFormats = @(
    @("i", "i"),
    @("ı", "ı"),
    @("u", "u"),
    @("ü", "ü")
)

$mFormats = @(
    @("i", "ler"),
    @("ı", "lar"),
    @("u", "lar"),
    @("ü", "ler")
)

$nounForms = @(
    @("rzecz", "w"),
    @("rzeczy", "wc"),
    @("moja rzecz", "wf")
    @("mojej rzeczy", "wfc")
    @("twoja rzecz", "wfd")
    @("jego rzecz", "wfd")
    @("jej rzecz", "wfd")
    @("nasza rzecz", "wfd"),
    @("wasza rzecz", "wfd"),
    @("ich rzecz", "wfd")
)

#>

    # geziyordum
    $vowels = "aeıioöuü"
}

Function addFutureDef {
    param([string]$word)

    # gezecegim, bilecegim
    $vowels = "aeıioöuü"
}

Function addPresentContDef {
    param([string]$word)
    # geziyorum, kesiyorum, yuzuyorum, koyuyorum, biliyorum

    $vowels = $vowels = "aeıioöuü"
}

Function addAoristDef {
    param([string]$word)
    # gezebilirim, yuzebilirim, gidebilirim, gelebilirim, bilebilirim

    $vowels = $vowels = "aeıioöuü"
}

Function addInperative {
    # a, in
}

Function addCanDef {
    param($word)
}

Function addDative {
    # (y)a / (y)e
}

Function addLocative {
    # da, de, ta, te
}

Function addAblative {
    # dan, den, tan, ten
}

Function addGenitive {
    # (n)ın, (n)in, (n)un, (n)ün
}

Function addInstrumental {
    # (y)le, (y)lar
}

Function plural {
    # ler, lar
}

Function kkenDef {
    # when I was
}

Function bagliDef {
    
}

Function ragmenDef {
    # bamamana ragmen
}

Function addDef {
    param([string]$word)

    $wordArr = $word.ToCharArray()
    $output = $null
    $suffix = $null

    # ZAMIANA LITER
    # sehir -> sehri, nehir, nehri

    # GLOSSAL HARMONY BY CONSONANT EXCEPTIONS 
    # ç c  p b  g ğ  t d 

    # GLOSSAL HARMONY EXCEPTIONS
    $iexc = @("saat", "kalp", "hayal", "alkol", "seyahat")
    $ueExc = @("alkol") # -> ü

    # ENCEPTION Y INSTEAD S
    $yExc = @("su")

    # CHANGING 

    $vowels = "aeıioöuü"
    $lastVowel = $null

    foreach ($l in $wordArr) {
        Write-Host "Letter $l"
        if ($vowels.Contains($l)) {
            $lastVowel = $l
            #$index = $i
        }
    }

    $lastLetter = $word.Substring($word.Length-1,1)
    $addS = ""

    if ($vowels.Contains($lastLetter)) {

        $addS = "s"
        if ($yExc.Contains($word)) {
            $addS = "y"
        }

    }

    Write-Host "last vowel: $lastVowel"


    switch($lastVowel) {
        { @("a", "ı") -contains $_ } {
            $suffix = "ı"
            break;
        }
        { @("e", "i") -contains $_ } {
            $suffix = "i"
            break;
        }
        { @("o", "u") -contains $_ } {
            $suffix = "u"
            break;
        } 
        { @("ö", "ü") -contains $_} {
            $suffix = "ü"
            break;
        }
        default {
            Write-Host "def"
        }
    }

    if ($iExc.Contains($word)) {
        $suffix = "i"
    }

    Write-Host "suffix $suffix"

    $output = "$($word)$($addS)$($suffix)"

    <#
    switch($lastVowel) {
        "a" {
            $output = "ı"
            break;
        }
        "e" {
            $output = "i"
            break;
        }
        "u" {
            $output = "u"
            break;
        }
        "ü" {
            $output = "ü"
            break;
        }
        "ı" {
            $output = "ı"
            break;
        }
        "i" {
            $output = "i"
            brake;
        }
        "o" {
            $output = "u"
            brake;
        }
        "ö" {
            $output = "ü"
        }
        
    }
    #>

    return $output
}

addDef "saat"



<#

$specifiedSuffixes = @(
    ("a", "ı"),
    ("e", "i"),
    ("u", "u"),
    ("ü", "ü"),
    ("i", "i")
)

$nounFormats = @(
    @("benim", "im", "ım", "um", "üm, m, m, m, m"),
    @("senin", "in", "ın", "un", "ün, n, n, n, n"),
    @("onun", "i", "ı", "u", "ü", "si", "sı", "su", "sü")  # x like i, u
    @("bizim", "iz", "ız", "uz", "üz", "miz", "mız", "muz", "müz")
    @("sizin", "iniz", "ınız", "unuz", "ünüz", "niz", "nız", "nuz", "nüz")
    @("onların", "i", "ı", "u", "ü", "si", "sı", "su", "sü")
)

$cFormats = @(
    @("i", "in"),
    @("ı", "ın"),
    @("u", "un"),
    @("ü", "ün")
)

$dFormats = @(
    @("i", "i"),
    @("ı", "ı"),
    @("u", "u"),
    @("ü", "ü")
)

$mFormats = @(
    @("i", "ler"),
    @("ı", "lar"),
    @("u", "lar"),
    @("ü", "ler")
)

$nounForms = @(
    @("rzecz", "w"),
    @("rzeczy", "wc"),
    @("moja rzecz", "wf")
    @("mojej rzeczy", "wfc")
    @("twoja rzecz", "wfd")
    @("jego rzecz", "wfd")
    @("jej rzecz", "wfd")
    @("nasza rzecz", "wfd"),
    @("wasza rzecz", "wfd"),
    @("ich rzecz", "wfd")
)

#>