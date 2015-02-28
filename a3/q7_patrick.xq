let $levels := (1,2,3,4,5)
let $desiredSkills := distinct-values(fn:doc("posting.xml")//posting//reqSkill/@what)
let $availableSkills := fn:doc("resume.xml")//skill
let $skillLevelN :=
	for $skill in $desiredSkills
	return <skill name = "{data($skill)}">
	{
		for $level in $levels
		return <count level = "{string($level)}" n = "{data(count($availableSkills[@what=$skill and @level=$level]))}"/>
	}
	</skill>

return <skills>
{
$skillLevelN
}
</skills>