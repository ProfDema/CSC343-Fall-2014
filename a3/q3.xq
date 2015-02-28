for $skill in fn:doc("posting.xml")//posting
let $c := max($skill/reqSkill//@importance)
let $d := ($skill/reqSkill[@importance = $c])
return $d