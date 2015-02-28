let $resumeskills := (for $rskill in fn:doc("resume.xml")//skill
     return $rskill)
let $reqskills := (for $rskill in fn:doc("posting.xml")//reqSkill
     return $rskill)

let $d := (for $resumeskill in $resumeskills, $reqskill in $reqskills 
where ($reqskill//@what = $resumeskill//@what
and $reqskill//@level > $resumeskill//@level) 
return $reqskill/@what)
(: return $reqskill/..//@pID) :)

return $d

(:
let $k := (for $reqskill in $reqskills
where fn:doc("resume.xml")//skills[contains(skill, {$reqskill})]
return {$reqskill}/..//@pID)

return {$k}

:)