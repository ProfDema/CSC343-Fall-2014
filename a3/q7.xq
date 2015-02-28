(:
Generate an XML document called skills.xml that reports, for each skill listed in any posting,
the number of resumes that list that skill at level 1, at level 2, and so on. Your XML output
must validate against the DTD in file skills.dtd.
:)


let $seqPostingSkills := (
	for $skillName in fn:doc("posting.xml")//reqSkill/@what
		return $skillName
)

let $seqResumeSkills := (
	for $skill in fn:doc("resume.xml")//skill
		return $skill
)

let $skillsRequired := distinct-values($seqPostingSkills)
(: let $skillsPossessed := distinct-values($seqResumeSkills) :)

let $skillNameAndLevelCount := (
	for $skill in $skillsRequired
		return
			<skill name = "{data($skill)}">

			{
				for $level in (1 to 5)
					return 
						<count
							level = "{data($level)}"
							n = "{
								data(count(
									$seqResumeSkills[@what = $skill and @level = $level]
									(:
									for $resumeSkill in fn:doc("resume.xml")//skill
										where $resumeSkill/@what = $skill
										and data($resumeSkill/@level) = $level
										return $resumeSkill
									:)
								))
							}"
						/>
			}
			</skill>
)

return 
	<skills>
		{$skillNameAndLevelCount}
	</skills>



(:
<!ELEMENT skills (skill*)>
<!ELEMENT skill (count+)>
<!ATTLIST skill name CDATA #REQUIRED>
<!ELEMENT count EMPTY>
<!ATTLIST count level CDATA #REQUIRED>
<!ATTLIST count n CDATA #REQUIRED>

<skills>
	<skill name="what">
		<count level=1 n=2> </count>
	</skill>
</skills>
:)