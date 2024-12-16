Function GetVocalHarmonyMain {
    param([string]$char)

    $addSuffix = $null

    switch ($char) {
        {$_ -eq "a" -or $_ -eq "ı"} {
            $addSuffix = "ı"
            break;
        }
        {$_ -eq "e" -or $_ -eq "i"} {
            $addSuffix = "i"
            break;
        }
        {$_ -eq "o" -or $_ -eq "u"} {
            $addSuffix = "u"
            break;
        }
        {$_ -eq "ö" -or $_ -eq "ü"} {
            $addSuffix = "ü"
            break;
        }
    }

    return $addSuffix
}

Function GetVocalHarmonyAE {
    param(
        [char]$char
    )

    $eGroup = @("e", "i", "ö", "ü")
    $aGroup = @("a", "ı", "o", "u")

    if ($eGroup.Contains($char.ToString())) {
        return "e"
    } else {
        return "a"
    }
}

Function GetVocalHarmonyI {
    param(
      [char]$char  
    )

    $eGroup = @("e", "i", "ö", "ü")
    $aGroup = @("a", "ı", "o", "u")

    if ($eGroup.Contains($char.ToString())) {
        return "i"
    } else {
        return "ı"
    }
}

Function IsFistikci {
    param (
        [string]$Word
    )

    $chars = $("f", "s", "t", "k", "ç", "ş", "h", "p")

    $lastLetter = GetLastLetter $Word

    if ($chars.Contains($lastLetter)) {
        return $true
    } else {
        return $false
    }
}

Function VerbFunction {
    param(
        [string]$MainF,
        [string]$MinF,
        [string]$PresentF,
        [string]$AoristS,
        [string]$Symbol = "ALX",
        [string]$Case = "A" # Accusative - A (I), Ablative B (DAN), Locative - L (DA), Instrumental - I (LA), Dative - D (A)
    )

    $mainFLV = GetLastVowel $MainF
    $mainFVH = GetVocalHarmonyMain $mainFLV
    $mainFVH2 = GetVocalHarmonyAE $mainFLV
    $mainFVH3 = GetVocalHarmonyI $mainFLV

    $mainSuffixes = @("xm", "sxn", "", "xz", "sxnxz", "lxr")
    $mainSuffixesQ = @("yxm", "sxn", "", "yxz", "sxnxz", "lxr")

    $no = 0
    # MAIN FORM
    $m = "$($MainF)m$($mainFVH2)k"
    Write-Host "V-$($Symbol)-$($no),$m,$m,Infinitive,Main,$MainF,,mak,,,,,,,,$Case"

    # PRESENT CONTINOUS
    $prCon = "$($PresentF)yor"
    $pcConLV = GetLastVowel $prCon
    $pcConVH = GetVocalHarmonyMain $pcConLV
    $pcConVH2 = GetVocalHarmonyAE $pcConLV

    # Present Continuous - Main

    $no = 100

    foreach ($s in $mainSuffixes) {

        $suffix = $null
        
        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
        } else {
            $suffix = $s.Replace("x", $pcConVH)
        }
        
        Write-Host "V-$($Symbol)-$($no),$($prCon)$($suffix),$m,Present Continuous,Main,$MinF,,$($PresentF.Substring($PresentF.Length-1, 1))yor,,,,,,$suffix,,$Case"
        
        $no++
    }

    $no = 110

    # Present Continuous - Negative
    $prConN  = "$($MainF)m$($mainFVH)yor"

    foreach ($s in $mainSuffixes) {

        $suffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
        } else {
            $suffix = $s.Replace("x", $pcConVH)
        }

        Write-Host "V-$($Symbol)-$($no),$($prConN)$($suffix),$m,Present Continuous,Negative,$MainF,m$($mainFVH),yor,,,,,,$suffix,,$Case"

        $no++
    }

    $no = 120

    # Present Continuous - Main Question
    foreach ($s in $mainSuffixesQ) {

        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $plural = $suffix 
            $q = "m$($sVH)"
            $suffix = "$($suffix) m$($sVH)"
        } else {
            $suffix = $($s.Replace("x", $pcConVH))
            $eSuffix = $suffix
            $suffix = " m$($pcConVH)$($suffix)"
            $q = "m$($pcConVH)"
        }

        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null

        Write-Host "V-$($Symbol)-$($no),$($prCon)$($suffix),$m,Present Continuous,Main Question,$MinF,,$($PresentF.Substring($PresentF.Length-1, 1))yor,,$plural,$q,,,$eSuffix,,$Case"

        $no++
    }

    $no = 130

    # Present Continuous - Negative Question
    foreach ($s in $mainSuffixesQ) {

        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $plural = $suffix 
            $q = "m$($sVH)"
            $suffix = "$($suffix) m$($sVH)"
        } else {
            $suffix = $($s.Replace("x", $pcConVH))
            $eSuffix = $suffix
            $suffix = " m$($pcConVH)$($suffix)"
            $q = "m$($pcConVH)"
        }

        Write-Host "V-$($Symbol)-$($no),$($prConN)$($suffix),$m,Present Continuous,Negative Question,$MainF,m$($mainFVH3),yor,,$plural,$q,,,$eSuffix,,$Case"

        $no++ 
    }

    # PAST CONTINUOUS

    $ptConSuffixes = @("m", "n", "", "k", "nxz", "lxr")
    $ptConSuffixesQ = @("m", "n", "", "k", "nxz", "lxr")

    $no = 200

    # Past Continuous - Main
    foreach ($s in $ptConSuffixes) {

        $suffix = $null
        $eSuffix = $null
        
        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
        } else {
            $suffix = $s.Replace("x", $pcConVH)
        }



        $eSuffix = $suffix
        $suffix = "d$($pcConVH)$suffix"

        Write-Host "V-$($Symbol)-$($no),$($prCon)$($suffix),$m,Past Continuous,Main,$MinF,,$($PresentF.Substring($PresentF.Length-1, 1))yor,d$($pcConVH),,,,,$eSuffix,,$Case"

        $no++
    }

    # Past Continuous - Negative"

    $no = 210

    foreach ($s in $ptConSuffixes) {

        $suffix = $null
        $eSuffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
        } 

        $eSuffix = $suffix
        $suffix = "d$($pcConVH)$suffix"

        Write-Host "V-$($Symbol)-$($no),$($prConN)$($suffix),$m,Past Continuous,Negative,$MainF,m$($mainFVH),yor,d$($pcConVH),,,,,$eSuffix,,$Case"

        $no++
    }

    # Past Continuous - Main Question

    $no = 220

    foreach ($s in $ptConSuffixesQ) {
        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null
        $pastSuffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $plural = $suffix 
            $q = "m$($sVH)"
            $pastSuffix = "d$($sVH)"
            $suffix = "$($suffix) m$($sVH)yd$($sVH)"
        } else {
            $suffix = $($s.Replace("x", $pcConVH))
            $eSuffix = $suffix
            $pastSuffix = "d$($pcConVH)"
            $suffix = " m$($pcConVH)yd$($pcConVH)$($suffix)"
            $q = "m$($pcConVH)"
        }

        Write-Host "V-$($Symbol)-$($no),$($prCon)$($suffix),$m,Past Continuous,Main Question,$MinF,,$($PresentF.Substring($PresentF.Length-1, 1))yor,,$plural,$q,y,$($pastSuffix),$eSuffix,,$Case"

        $no++
    }

    $no = 230

    # Past Continuous - Negative Question
    foreach ($s in $ptConSuffixesQ) {
        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null
        $pastSuffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $pcConVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $plural = $suffix 
            $q = "m$($sVH)"
            $pastSuffix = "d$($sVH)"
            $suffix = "$($suffix) m$($sVH)yd$($sVH)"
        } else {
            $suffix = $($s.Replace("x", $pcConVH))
            $eSuffix = $suffix
            $pastSuffix = "d$($pcConVH)"
            $suffix = " m$($pcConVH)yd$($pcConVH)$($suffix)"
            $q = "m$($pcConVH)"
        }

        Write-Host "V-$($Symbol)-$($no),$($prConN)$($suffix),$m,Past Continuous,Negative Question,$MainF,m$($mainFVH3),yor,,$plural,$q,y,$($pastSuffix),$eSuffix,,$Case"

        $no++
    }

    # AORIST
    $ao = "$($MinF)$($AoristS)"
    $aoN = $MainF
    $aoLV = GetLastVowel $ao
    $aoVH = GetVocalHarmonyMain $aoLV
    $aoVH2 = GetVocalHarmonyAE $aoLV
    $aoNLV = GetLastVowel $MainF
    $aoVHN = GetVocalHarmonyAE $aoNLV
    $aoNN = "$($MainF)m$($aoVHN)z"

    $aoSuffixes = @("xm", "sxn", "", "xz", "sxnxz", "lxr")
    $aoSuffixesN = @("xm", "sxn", "", "yxz", "sxnxz", "lxr")

    $no = 300

    # Aorist - Main
    foreach ($s in $aoSuffixes) {

        $suffix = $null
        
        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
        } else {
            $suffix = $s.Replace("x", $aoVH)
        }

        

        #Write-Host "$($ao)$($suffix)"

        Write-Host "V-$($Symbol)-$($no),$($ao)$($suffix),$m,Aorist,Main,$MinF,,$($AoristS),,,,,,$suffix,,$Case"

        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, tense1, tense2, question_plural, question, question_join, question_tense, decl, case

        $no++
    }

    $no = 310

    # Aorist - Nagative
    foreach ($s in $aoSuffixesN) {

        $suffix = $null
        $mSuffix = $null
        $eSuffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
        } else {
            $suffix = $s.Replace("x", $aoVH)
        }

        $eSuffix = $($suffix)

        if ($s -eq "sxn" -Or $s -eq "" -Or $s -eq "sxnxz", $s -eq "lxr") {
            $mSuffix = "m$($aoVH2)z"
            $suffix = "m$($aoVH2)z$($suffix)"
        } else {
            $mSuffix = "m$($aoVH2)"
            $suffix = "m$($aoVH2)$($suffix)"
        }

        Write-Host "V-$($Symbol)-$($no),$($aoN)$($suffix),$m,Aorist,Negative,$MainF,,$mSuffix,,,,,,$eSuffix,,$Case"

        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, tense1, tense2, question_plural, question, question_join, question_tense, decl, case

        $no++
    }

    $no = 320

    # Aorist - Main Question
    foreach ($s in $mainSuffixesQ) {

        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null
        $j = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
            $plural = $suffix
            $q = "m$($mainFVH3)"
            $suffix = "$($suffix) m$($mainFVH3)"
        } else {
            $suffix = $($s.Replace("x", $aoVH))
            $eSuffix = $suffix
            $suffix = " m$($mainFVH3)$($suffix)"
            $q = "m$($mainFVH3)"
        }

        if ($s -eq "xm" -Or $s -eq "xz") {
            $j = "y"
            $suffix = "m$($aoVH2)y$($suffix)"        
        }

        Write-Host "V-$($Symbol)-$($no),$($ao)$($suffix),$m,Aorist,Main Question,$MinF,,$($AoristS),,$plural,$q,$j,,$eSuffix,,$Case"

        $no++
    }

    $no = 330

    # Aorist - Negative Question
    foreach ($s in $mainSuffixesQ) {

        $suffix = $null
        $eSuffix = $null
        $mSuffix = $null
        $plural = $null
        $q = $null
        $j = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
            $plural = $suffix
            $q = "m$($mainFVH3)"
            $suffix = "$($suffix) m$($mainFVH3)"
        } else {
            $suffix = $($s.Replace("x", $aoVH))
            $eSuffix = $suffix
            $suffix = " m$($mainFVH3)$($suffix)"
            $q = "m$($mainFVH3)"
        }

        $mSuffix = "m$($aoVH2)z"

        Write-Host "V-$($Symbol)-$($no),$($aoNN)$($suffix),$m,Aorist,Main Question,$MinF,,$($mSuffix),,$plural,$q,$j,,$eSuffix,,$Case"

        $no++
    }

    # PAST SIMPLE
    #$ptSimSuffixes = @("dxm", "dxn", "dx", "dxk", "dxnxz", "dxlqr")
    $ptSimSuffixes = @("m", "n", "", "k", "nxz", "lxr")
    $ptSim = "$($MainF)"
    $ptSimN = "$($MainF)m$($mainFVH2)"

    $no = 400

    # Past Simple - Main
    foreach ($s in $ptSimSuffixes) {
        $eSuffix = $suffix
        $d = "d$($mainFVH)"
        if ($s -eq "lxr") {
            $eSuffix = $($s.Replace("x", $mainFVH2))
            #$suffix = "$($suffix.Replace("x", $mainFVH2))"
        } else {
            $eSuffix = $s.Replace("x", $mainFVH)
        }

        $suffix = "$($d)$eSuffix"

        Write-Host "V-$($Symbol)-$($no),$($ptSim)$suffix,$m,Aorist,Main Question,$MainF,,$d,,,,$j,,$eSuffix,,$Case"

        $no++
    }

    $no = 410

    # Past Simple - Negative
    foreach ($s in $ptSimSuffixes) {
        $eSuffix = $suffix
        $d = "d$($mainFVH)"
        if ($s -eq "lxr") {
            $eSuffix = $($s.Replace("x", $mainFVH2))
            #$suffix = "$($suffix.Replace("x", $mainFVH2))"
        } else {
            $eSuffix = $s.Replace("x", $mainFVH)
        }

        $suffix = "$($d)$eSuffix"

        Write-Host "V-$($Symbol)-$($no),$($ptSimN)$suffix,$m,Aorist,Negative,$MainF,m$($mainFVH2),$d,,,,$j,,$eSuffix,,$Case"

        $no++
    }

    $no = 420

    # Past Simple - Main Question
    foreach ($s in $ptSimSuffixes) {
        $eSuffix = $null
        $d = "d$($mainFVH)"
        if ($s -eq "lxr") {
            $suffix = $($s.Replace("x", $mainFVH2))
        } else {
            $eSuffix = $s.Replace("x", $mainFVH)
            $suffix = $s.Replace("x", $mainFVH)
        }

        $suffix = "$($d)$suffix"

        Write-Host "V-$($Symbol)-$($no),$($ptSim)$suffix m$($mainFVH),$m,Aorist,Main Question,$MainF,,$d,,$plural,,,,$eSuffix,m$($mainFVH),$Case"

        $no++
    }

    $no = 430

    # Past Simple - Negative Question
    foreach ($s in $ptSimSuffixes) {
        $eSuffix = $suffix
        $d = "d$($mainFVH)"
        if ($s -eq "lxr") {
            $eSuffix = $($s.Replace("x", $mainFVH2))
        } else {
            $eSuffix = $s.Replace("x", $mainFVH)
        }

        $suffix = "$($d)$eSuffix"

        Write-Host "V-$($Symbol)-$($no),$($ptSimN)$suffix m$($mainFVH),$m,Aorist,Negative Question,$MainF,m$($mainFVH2),$d,,,,,,$eSuffix,m$($mainFVH),$Case"

        $no++
    }

    $no = 500

    # NOT DEFINED PAST CONTINUOUS
    $npCon = "$($MainF)m$($mainFVH)ş"
    $npConN = "$($MainF)m$($mainFVH2)m$($mainFVH)ş"

    $npConLV = GetLastVowel $npCon
    $npConVH = GetVocalHarmonyMain $npConLV
    $npConVH2 = GetVocalHarmonyAE $npConLV

    # Not Defined Past Continuous - Main
    foreach ($s in $mainSuffixes) {

        $suffix = $null
        
        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $npConVH2)
        } else {
            $suffix = $s.Replace("x", $npConVH)
        }

        Write-Host "V-$($Symbol)-$($no),$($npCon)$($suffix),$m,Not Defined Past Continuous,Main,$MainF,,m$($mainFVH)ş,,,,,,$suffix,,$Case"

        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, tense1, tense2, question_plural, question, question_join, question_tense, decl, question_past, case

        $no++
    }

    $no = 510

    # Not Defined Past Continuous - Negative
    foreach ($s in $mainSuffixes) {

        $suffix = $null
        
        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $npConVH2)
        } else {
            $suffix = $s.Replace("x", $npConVH)
        }

        Write-Host "V-$($Symbol)-$($no),$($npConN)$($suffix),$m,Not Defined Past Continuous,Negative,$MainF,m$($mainFVH2),,m$($mainFVH)ş,,,,,,$suffix,,$Case"

        $no++
    }

    $no = 520

    # Not Defined Past Continuous - Main Question

    foreach ($s in $mainSuffixesQ) {
        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null
        $j = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
            $plural = $suffix
            $q = "m$($mainFVH3)"
            $suffix = "$($suffix) m$($mainFVH3)"
        } else {
            $suffix = $($s.Replace("x", $aoVH))
            $eSuffix = $suffix
            $suffix = " m$($mainFVH3)$($suffix)"
            $q = "m$($mainFVH3)"
        }

        Write-Host "V-$($Symbol)-$($no),$($npCon)$($suffix),$m,Not Defined Past Continuous,Main Question,$MainF,,,m$($mainFVH)ş,,$plural,$q,$j,,$eSuffix,,$Case"

        $no++
    }  
    
    $no = 530

    # Not Defined Past Continuous - Negative Question

    foreach ($s in $mainSuffixesQ) {
        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null
        $j = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
            $plural = $suffix
            $q = "m$($mainFVH3)"
            $suffix = "$($suffix) m$($mainFVH3)"
        } else {
            $suffix = $($s.Replace("x", $aoVH))
            $eSuffix = $suffix
            $suffix = " m$($mainFVH3)$($suffix)"
            $q = "m$($mainFVH3)"
        }

        Write-Host "V-$($Symbol)-$($no),$($npConN)$($suffix),$m,Not Defined Past Continuous,Negative Question,$MainF,m$($mainFVH2),,m$($mainFVH)ş,,$plural,$q,$j,,$eSuffix,,$Case"

        $no++
    }

    $no = 600

    # FUTURE SIMPLE
    $ftSim = "$($MainF)"
    $fMainLL = GetLastLetter $MainF
    $fMainIV = IsVowel $fMainLL
    $ftSimN = "$($MainF)m$($mainFVH2)y$($mainFVH2)c$($mainFVH2)k"
    $y = $null
    if ($fMainIV) {$ftSim = "$($ftSim)y"}
    $ftSim = "$ftSim$($mainFVH2)c$($mainFVH2)k"
    #$ftSimSuffixes = @("xm", "sxn", "", "xz", "sxnxz", "lxr")

    # Future Simple - Main
    foreach ($s in $mainSuffixes) {

        $ftSimF = $ftSim
        $acak = "$($mainFVH2)c$($mainFVH2)k"

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $mainFVH2)
        } else {
            $suffix = $s.Replace("x", $mainFVH)
        }

        if ($s -eq "xm" -Or $s -eq "xz") {
            $ftSimF = $ftSim.Replace("k", "ğ")
            $acak = $acak.Replace("k", "ğ")
        }

        $y = if ($fMainIV) {"y"} else {$null}

        Write-Host "V-$($Symbol)-$($no),$($ftSimF)$suffix,$m,Future Simple,Main,$MainF,,$y,$acak,,,,$j,,$suffix,,$Case"
        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, root_join, tense1, tense2, question_plural, question, question_join, question_tense, decl, question_past, case

        $no++
    }

    $no = 610

    # Future Simple - Negative
    foreach ($s in $mainSuffixes) {

        $ftSimF = $ftSimN
        $acak = "$($mainFVH2)c$($mainFVH2)k"

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $mainFVH2)
        } else {
            $suffix = $s.Replace("x", $mainFVH)
        }

        if ($s -eq "xm" -Or $s -eq "xz") {
            $ftSimF = $ftSimN.Replace("k", "ğ")
            $acak = $acak.Replace("k", "ğ")
        }

        Write-Host "$($ftSimN)$suffix"

        Write-Host "V-$($Symbol)-$($no),$($ftSimF)$suffix,$m,Future Simple,Negative,$MainF,m$($mainFVH2),$y,$acak,,,,$j,,$suffix,,$Case"

        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, root_join, tense1, tense2, question_plural, question, question_join, question_tense, decl, question_past, case

        $no++
    }

    $no = 620

    # Future Simple - Main Questions
    foreach ($s in $mainSuffixesQ) {

        $ftSimF = $ftSim
        $suffix = $null
        $eSuffix = $null
        $plural = $null
        $q = $null
        $j = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
            $plural = $suffix
            $q = "m$($mainFVH3)"
            $suffix = "$($suffix) m$($mainFVH3)"
        } else {
            $suffix = $($s.Replace("x", $aoVH))
            $eSuffix = $suffix
            $suffix = " m$($mainFVH3)$($suffix)"
            $q = "m$($mainFVH3)"
        }
        
        Write-Host "V-$($Symbol)-$($no),$($ftSimF)$suffix,$m,Future Simple,Main Question,$MainF,,$y,$acak,$plural,$q,,,$eSuffix,,$Case"
        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, root_join, tense1, tense2, question_plural, question, question_join, question_tense, decl, question_past, case
        $no++
    }

    $no = 630

    # Future Simple - Negative Questions
    foreach ($s in $mainSuffixesQ) {

        $suffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $aoVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $suffix = "$($suffix) m$($sVH)"
        } else {
            $suffix = " $($s.Replace("x", $aoVH))"
        }

        Write-Host "$($ftSim)$suffix"

        Write-Host "V-$($Symbol)-$($no),$($ftSimN)$suffix,$m,Future Simple,Negative Question,$MainF,m$($mainFVH2),$y,$acak,$plural,$q,,,$eSuffix,,$Case"
        #Id, Form, BasicForm, TenseName, TenseForm, root, negative, root_join, tense1, tense2, question_plural, question, question_join, question_tense, decl, question_past, case
        $no++
    }



    # OPTATIVE MODE
    $opMode = "$($MainF)"
    #$fMainLL = GetLastLetter $MainF
    #$fMainIV = IsVowel $fMainLL
    $opModeN = "$($MainF)m$($mainFVH2)"
    if ($fMainIV) {$opMode = "$($opMode)ya"; $opModeN = "$($opModeN)ya"} else {$opMode = "$($opMode)a"; $opModeN = "$($opModeN)a"}
    
    $opMode
    $opModeN
    
    $opModeSuffixes = @("yxm", "sxn", "", "yxm", "sxnxz", "lar")

    # Optative Mode - Main
    foreach ($s in $npConSuffixes) {

        $suffix = $null
        
        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $npConVH2)
        } else {
            $suffix = $s.Replace("x", $npConVH)
        }

        Write-Host "-----------"
        Write-Host "$($npCon)$($suffix)"
    }

    # Not Defined Past Continuous - Negative
    $prConN  = "$($MainF)m$($mainFVH)yor"

    foreach ($s in $npConSuffixes) {

        $suffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $npConVH2)
        } else {
            $suffix = $s.Replace("x", $npConVH)
        }

        Write-Host "$($npConN)$($suffix)"
    }

    # Not Defined Past Continuous - Main Question
    foreach ($s in $npConSuffixesQ) {

        $suffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $npConVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $suffix = "$($suffix) m$($sVH)"
        } else {
            $suffix = " $($s.Replace("x", $npConVH))"
        }

        Write-Host "$($npCon)$suffix"
    }

    # Not Defined Past Continuous - Negative Question
    foreach ($s in $npConSuffixesQ) {

        $suffix = $null

        if ($s -eq "lxr") {
            $suffix = $s.Replace("x", $npConVH2)
            $sLV = GetLastVowel $suffix
            $sVH = GetVocalHarmonyMain $sLV
            $suffix = "$($suffix) m$($sVH)"
        } else {
            $suffix = " $($s.Replace("x", $npConVH))"
        }

        Write-Host "$($npConN)$suffix"
    }


    # 
    #$ftSim = "$ftSim$($mainFVH2)c$($mainFVH2)k"
    #$ftSimSuffixes = @("xm", "sxn", "", "xz", "sxnxz", "lxr")

    <#

optative	anlayayım	anlayasın	anlaya	anlayalım	anlayasınız	anlayalar
progressive	anlamaktayım	anlamaktasın	anlamakta	anlamaktayız	anlamaktasınız	anlamaktalar
necessitative	anlamalıyım	anlamalısın	anlamalı	anlamalıyız	anlamalısınız	anlamalılar
imperative		anla	anlasın		anlayın	anlasınlar

    #>

    # NECESSITATIVE MODE
    
    $ncMode = "$($MainF)m$($mainFVH2)l$($mainFVH3)"
    $ncMode

    # IMPERATIVE MODE

    $imMode = "$($MainF)"
    $imModeSuffixes = @("", "sxn", "yxn", "sxnlqr")

    # OPTATIV - FACT

    $ofMode = "$($ao)s$($aoVH2)"
    $ofModeN = "$($aoNN)s$($aoVH2)"
    $ofMode
    $ofModeN


    # OPTATIV - WISH
    $owMode = "$($aoN)s$($aoVH2)"
    $owModeN = "$($aoN)m$($aoVH2)s$($aoVH2)"

    $owMode
    $owModeN

    #anlasa


    # ABILMEK / EBILMEK

    # past
    # present
    # future
}

Function GetLastLetter {
    param(
        [string]$Text
    )

    $LastLetter = $Text.ToCharArray() | Select -Last 1

    return $LastLetter
}

Function IsVowel {
    param(
        [string]$Char
    )

    $vowels = "aeıioöuü"

    if ($vowels.Contains($Char)) {
        return $true
    } else {
        return $false
    }
}

Function GetTextVowels {
    param(
        [string]$Text
    )

    $vowels = "aeıioöuü"

    $textVowels = @()
    $textLetters = $Text.ToCharArray()

    foreach ($l in $textLetters) {
        if ($vowels.Contains($l)) {
            $textVowels += $l
        }
    }
    
    return $textVowels
}

Function GetLastLetter {
    param(
        [string]$Text,
        [int]$Last = 1      
    )

    $textArr = GetTextVowels $Text

    $output = $null

    if ($Last -eq 1) {
        $output = $textArr | Select -Last 1
    } else {
        if ($textVowels.Length -ge $Last) {
            $output = $textArr[$textArr.Length-$Last]
        }
    }

    return $output
}

Function GetLastVowel {
    param(
        [string]$Text,
        [int]$Last = 1
    )

    $textVowels = GetTextVowels $Text

    $output = $null

    if ($Last -eq 1) {
        $output = $textVowels | Select -Last 1
    } else {
        if ($textVowels.Length -ge $Last) {
            $output = $textVowels[$textVowels.Length-$Last]
        }
    }

    return $output
}

VerbFunction "Anla" "Anl" "Anlı" "ar"

<#
Function VocalHarmony0 {
    param(
        [char]$Char
    )

    $vowels = "aeıioöuü"
}

# CONSTRUCTS

<#
Function Verb-PresentContinous {
    param(
        [string]$word,
        [string]$initroot
    )

    $output = $null

    $vowels = "aeıioöuü"
    $root = $null
    $suffix = $null

    if (!$initroot -And !$initsuffix) {
        $root = $word.Replace("mak", "")
        $root = $root.Replace("mek", "")

        $wordChars = $root.ToCharArray()
        $rootVowels = @()
        Foreach ($c in $wordChars) {if ($vowels.Contains($c)) {$rootVowels += $c}}
        $lastLetter = $wordChars | Select -Last 1
        $prevLetter = $wordChars[$wordChars.Length-2]
        $lastVowel = $rootVowels | Select -Last 1

        $isEndVowel = if ($vowels.Contains($lastLetter)) {$true} else {$false}
    
        $2lVowel = @()

        if ($isEndVowel) {
            $2lVowel = $rootVowels[$rootVowels.Length-2]
            $root = $root.Substring(0, $root.Length-1)
        }

        $defVowel = if ($2lVowel) {$2lVowel} else {$lastVowel}

        # suffix

        $suffix = $null

        $u = @("o", "u")
        $i = @("e", "i")
        $ue = @("ö", "ü")
        $iy = @("a", "ı")

        switch ($defVowel) {
            {$_ -eq "a" -or $_ -eq "ı"} {
                $suffix = "ı"
                break;
            }
            {$_ -eq "e" -or $_ -eq "i"} {
                $suffix = "i"
                break;
            }
            {$_ -eq "o" -or $_ -eq "u"} {
                $suffix = "u"
                break;
            }
            {$_ -eq "ö" -or $_ -eq "ü"} {
                $suffix = "ü"
                break;
            }
        }
    } else {
        $root = $initroot
        $wordChars = $root.ToCharArray()

        $lastLetter = $wordChars | Select -Last 1

        $isEndVowel = if ($vowels.Contains($lastLetter)) {$true} else {$false}

        if (!$isEndVowel) {
            $suffix = $lastLetter
        }
    }

    $output = $root
    $output += $suffix
    $output += "yor"

    
    $output
}
#>

<#
Function Verb-PresentContinous {
    param(
        [string]$root,
        [string]$form
    )

    $vowels = "aeıioöuü"

    $wordChars = $root.ToCharArray()
    $rootVowels = @()
    Foreach ($c in $wordChars) {if ($vowels.Contains($c)) {$rootVowels += $c}}
    $lastLetter = $wordChars | Select -Last 1
    $prevLetter = $wordChars[$wordChars.Length-2]
    $lastVowel = $rootVowels | Select -Last 1

    $isEndVowel = if ($vowels.Contains($lastLetter)) {$true} else {$false}
    
    $2lVowel = @()

    if ($isEndVowel) {
        $2lVowel = $rootVowels[$rootVowels.Length-2]
        $lastVowel = $2lVowel
    }

    $verbSuffix = "yor"
    $lastVerbVowel = $verbSuffix.ToCharArray() | Select -Last 1

    $vH2 = Get-VocalHarmony1 $lastVerbVowel

    $suffixList = @(
        "xm", "sxn", "", "xz", "sxnxz", "lxr"
    )

    $addSuffix = Get-VocalHarmony0 $lastVowel

    foreach ($s in $suffixList) {
        $suffix = $s.Replace("x", $addSuffix)
        $suffıx
        Write-Host "$($form)yor$($suffix)"
    }

    #negatıve suffıx

    #$addSuffix = $null



    foreach ($s in $suffixList) {
        $suffix = $s.Replace("x", $addSuffix)
        Write-Host "$($root)m$($addSuffix)yor$($suffix)"
    }

    # questions

    foreach ($s in $suffixList) {
        if ($s -eq "lxr") {
            if (@("e", "i", "ö", "ü").Contains($addSuffix)) {
                $suffix = "ler"
            } else {
                $suffix = "lar"
            }
        } else {
            $suffix = $s.Replace("x", $rootSuffix)
        }
    }

    foreach ($s in $suffixList) {
        if ($s -eq "lar") {
            Write-Host "$($root)m$($addSuffix)yor$($s) mu"
        } else {
            if (IsStartFromVowel $s) {
                $s = "y$($s)"
            }
            Write-Host "$($root)m$($addSuffix)yor mu$($s)"
        }
    }
}

Function Verb-PastContinous {
    param(
        [string]$root,
        [string]$form
    )

    $vowels = "aeıioöuü"

    $wordChars = $root.ToCharArray()
    $rootVowels = @()
    Foreach ($c in $wordChars) {if ($vowels.Contains($c)) {$rootVowels += $c}}
    $lastLetter = $wordChars | Select -Last 1
    $prevLetter = $wordChars[$wordChars.Length-2]
    $lastVowel = $rootVowels | Select -Last 1

    $isEndVowel = if ($vowels.Contains($lastLetter)) {$true} else {$false}
    
    $2lVowel = @()

    if ($isEndVowel) {
        $2lVowel = $rootVowels[$rootVowels.Length-2]
        $lastVowel = $2lVowel
    }

    $suffixList = @(
        "um", "sun", "", "uz", "sunuz", "lar"
    )

    foreach ($s in $suffixList) {
        Write-Host "$($form)yor$($s)"
    }

    #negatıve suffıx

    #$addSuffix = $null

    $addSuffix = Get-VocalHarmony0 $lastVowel
    $vH2 = Get-VocalHarmony1 $lastVowel

    foreach ($s in $suffixList) {
        Write-Host "$($root)m$($addSuffix)yor$($s)"
    }

    # questions

    foreach ($s in $suffixList) {
        if ($s -eq "lar") {
            Write-Host "$($form)yorlar$($s) m$($)vH2"
        } else {
            if ($s.StartsWith("u")) {
                $s = "y$($s)"
            }
            Write-Host "$($form)yor mu$($s)"
        }
    }

    foreach ($s in $suffixList) {
        if ($s -eq "lar") {
            Write-Host "$($root)m$($addSuffix)yor$($s) mu"
        } else {
            if ($s.StartsWith("x")) {
                $s = "y$($s)"
            }
            Write-Host "$($root)m$($addSuffix)yor mu$($s)"
        }
    }
}

Function Verb-Aorist {
    param(
        [string]$root,
        [string]$form
    )

    $vowels = "aeıioöuü"

    $rootChars = $root.ToCharArray()
    $formChars = $form.ToCharArray()

    $rootVowels = @()
    Foreach ($c in $rootChars) {if ($vowels.Contains($c)) {$rootVowels += $c}}
    $lastLetter = $rootChars | Select -Last 1
    $lastVowel = $rootVowels | Select -Last 1

    $isEndVowel = if ($vowels.Contains($lastLetter)) {$true} else {$false}
    
    $2lVowel = @()

    if ($isEndVowel) {
        $2lVowel = $rootVowels[$rootVowels.Length-2]
        $lastVowel = $2lVowel
    }

    $suffixList = @(
        "xm", "sxn", "", "xz", "sxnxz", "lxr"
    )

    #$rootLastLetter = 
    $rootSuffix = Get-VocalHarmony0 $lastVowel

    foreach ($s in $suffixList) {
        if ($s -eq "lxr") {
            if (@("e", "i", "ö", "ü").Contains($rootSuffix)) {
                $suffix = "ler"
            } else {
                $suffix = "lar"
            }
        } else {
            $suffix = $s.Replace("x", $rootSuffix)
        }
        Write-Host "$($form)r$suffix"
    }

    # negation

    $negSuffixList = @(
        "m", "zsxn", "z", "yxz", "zsxnxz", "zlxr"
    )

    $vH2 = Get-VocalHarmony1 $rootSuffix
    Write-Host "vh2: $vH2"

    foreach ($ns in $negSuffixList) {
        if ($ns -eq "zlxr") {
            Write-Host "Root suffix is: $($rootSuffix)"
            if (@("e", "i", "ö", "ü").Contains($rootSuffix)) {
                $ns = "zler"
            } else {
                $ns = "zlar"
            }
        } else {
            $ns = $ns.Replace("x", $rootSuffix)        
        }

        Write-Host "$($form)m$($vH2)$($ns)"
    }

    # questions

    foreach ($s in $suffixList) {
        if ($s -eq "lar") {
            Write-Host "$($form)r$($s) m$($)vH2"
        } else {
            Write-Host "$($form)r mu$($s)"
        }
    }

    foreach ($s in $suffixList) {
        if ($s -eq "lar") {
            Write-Host "$($root)m$($addSuffix)r$($s) mu"
        } else {
            if ($s.StartsWith("x")) {
                $s = "y$($s)"
            }
            Write-Host "$($root)m$($addSuffix)mez mu$($s)"
        }
    }
} 

Function IsStartFromVowel {
    param([string]$text)

    $vowels = "aeıioöuü"
    Write-Host "AAA: $text"

    $firstLetter = $text.ToCharArray() | Select -First 1

    $firstLetter

    if ($vowels.Contains($firstLetter)) {
        return $true
    } else {
        return $false
    }
}

Function Get-VocalHarmony0 {
    param([char]$char)

    Write-Host "V Input: $($char)"
    $addSuffix = $null

    switch ($char) {
        {$_ -eq "a" -or $_ -eq "ı"} {
            $addSuffix = "ı"
            break;
        }
        {$_ -eq "e" -or $_ -eq "i"} {
            $addSuffix = "i"
            break;
        }
        {$_ -eq "o" -or $_ -eq "u"} {
            $addSuffix = "u"
            break;
        }
        {$_ -eq "ö" -or $_ -eq "ü"} {
            $addSuffix = "ü"
            break;
        }
    }

    Write-Host "V Output: $addSuffix"

    return $addSuffix
}

Function Get-VocalHarmony1 {
    param(
        [char]$char
    )

    $eGroup = @("e", "i", "ö", "ü")
    $aGroup = @("a", "ı", "o", "u")

    if ($eGroup.Contains($char.ToString())) {
        return "e"
    } else {
        return "a"
    }
}

Verb-PresentContinous "ye" "yi"
Verb-Aorist "ye" "ye"

#>




#400, Anlamayasin, Nie Anlamak, Anla, ma, yaz, sin
#300, Anlamazsin, Anlamak, Anla, maz, sin

#root - Anla
#tense - maz
#osoba = sin

# root - Anla
# negative - mi
# tense - yor
# tense2 - du
# osoba

# root - Anla
# negative = ma
# tense = yacak
# sin

# root - Anla
# negative = mi
# tense1 = yor
# tense2 = du
# question = mi
# decl = sin


#Id, Form, BasicForm, TenseName, root, negative, tense1, tense2, question, decl 