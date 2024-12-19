Function EnglishVersion {
    param(
        [string]$MainF, #Eat
        [string]$PastF, #Ate
        [string]$ContF, #Eating,
        [string]$PerfF, #Eaten
        [string]$Time, # PrCon, PtCon, PrSim, PtSim, FtSim, FtCon
        [int]$Person, # 1, 2, 3, 4, 10, 11, 12
        [bool]$Negative = $False,
        [bool]$Question = $False
    )

    $output = $null

    $conParts = @("I am", "You are", "She is", "He is", "It is", "We are", "You are", "They are")
    $conPartsQ = @("Am I", "Are you", "Is he", "Is she", "Is it", "Are we", "Are you", "Are they")
    $conPastParts = @("I was", "You were", "She was", "He was", "It was", "We were", "You were", "They were")
    $conPastPartsQ = @("Was I", "Were you", "Was she", "Was he", "Was it", "Were we", "Were you", "Were they")
    $simParts = @("I", "You", "She", "He", "It", "We", "You", "They")
    
    switch ($Time) {

        "PrCon" {
            if ($Question) {
                $output += $conPartsQ[$Person-1]
            } else {
                $output += $conParts[$Person-1]
            }

            if ($Negative) {
                $output += " not"
            }

            $output += " $ContF"
        }
        "PtCon" {
            if ($Question) {
                $output += $conPastPartsQ[$Person-1]
            } else {
                $output += $conPastParts[$Person-1]
            }

            if ($Negative) {
                $output += " not"
            }

            $output += " $ContF"
        }
        "prSim" {
            if ($Question) {

                $verb = "Do"
                $mVerb = $MainF

                if ($Person -ge 3 -And $Person -le 5) {
                    $verb += "es"
                    #$mVerb += "s"
                }

                if ($Negative) {
                    $output += "$($verb)n't"
                } else {
                    $output += $verb
                }

                $output += " $($simParts[$Person-1])"
                $output += " $mVerb"

            } else {
                $verb = "Do"
                if ($Person -ge 3 -And $Person -le 5) {
                    $verb += "es"
                }

                $output += $($simParts[$Person-1])

                if ($Negative) {
                    $output += " $($verb)n't".ToLower()
                }

                $output += " $($MainF)"
            }
        }
        "ptSim" {
            if ($Question) {

                $verb = "Did"
                $mVerb = $MainF

                if ($Negative) {
                    $output += "$($verb)n't"
                } else {
                    $output += $verb
                }

                $output += " $($simParts[$Person-1])"
                $output += " $mVerb"

            } else {
                $verb = "Did"
                $mVerb = $PastF

                $output += $($simParts[$Person-1])

                if ($Negative) {
                    $mVerb = $MainF
                    $output += " $($verb)n't".ToLower()
                }

                $output += " $($mVerb)"
            }
        }
        "ftSim" {
            if ($Question) {
                $output += "Will $($simParts[$Person-1])"
            } else {
                $output += "$($simParts[$Person-1]) will"
            }
            if ($negative) {
                $output += " not"
            }
            $output += " $MainF"
        }
        "Perf" {
            if ($Question) {
                $output += "is it eaten"
            }
        }
    }

    return $output
}

EnglishVersion "eat" "ate" "eating" "ftSim" 6 $true $false