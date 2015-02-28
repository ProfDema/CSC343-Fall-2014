(:
Find postings that have a required skill such that 
(a) fewer than half the resumes include that skill
or 
(b) of the resumes that include the skill, fewer than half list it at a level above 3. 
(This is an inclusive or; postings that satisfy both (a) and (b) should be included.) 

Report the pID.
:)

let $halfResumeCount := count(fn:doc("resume.xml")//resume) * 0.5

(:a resume won't post the same skill twice so the number of resumes that include 
	that skill are the count of thatt skill in this sequence:)
let $seqResumeSkillNames := (
	for $skill in fn:doc("resume.xml")//skill
		return $skill/@what
)

let $seqResumeSkillNamesAboveLevel3 := (
	for $skill in fn:doc("resume.xml")//skill
		where data($skill/@level) > 3
		return $skill/@what
)

let $returnSeq1 := (
	for $posting in fn:doc("posting.xml")//posting
		for $skill in $posting//reqSkill/@what
			where count($seqResumeSkillNames[. = $skill]) < $halfResumeCount
			(:this required skill occurs in less than half the resumes:)
			return $posting/@pID
)

let $returnSeq2 := (
	for $posting in fn:doc("posting.xml")//posting
		for $skill in $posting//reqSkill/@what
			where count($seqResumeSkillNamesAboveLevel3[. = $skill]) < $halfResumeCount
			(:this required skill occurs in less than half the resumes:)
			return $posting/@pID
)

return distinct-values($returnSeq1 union $returnSeq2)
