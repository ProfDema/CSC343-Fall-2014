let $plusskills := (
for $result in fn:doc("resume.xml")//resume
where count($result//skill) > 2
return $result
)

for $rID_1 in $plusskills
for $rID_2 in $plusskills

where
	$rID_1 != $rID_2  (: get rid of duplicates :)
	and
	every $skill in $rID_1//skill  (: subset of eachother :)
	satisfies 
		$rID_2//skill/@level = $skill/@level
		and
		$rID_2//skill/@what = $skill/@what
	and
	count($rID_1//skill) = count($rID_2//skill)  (:to prevent one being of the other:)

return 
		if ($rID_1/@rID < $rID_2/@rID)  (:prevents opposite pairs, ie 2,5 and 5,2:)
		then
			<rIDpair> 
				{$rID_1/@rID} 
				<paired_with> {$rID_2/@rID} </paired_with>
			</rIDpair>
		else
			()
