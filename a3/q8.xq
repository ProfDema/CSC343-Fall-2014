(:find rID of each person being interviewed and report their degree of match
and report the average of the assessment scores:)

let $interviews := (
	for $interview in fn:doc("interview.xml")//interview
		return $interview
)

let $returnInterview := (
	for $interview in $interviews
		(:the posting and resume in this specific interview:)
		let $posting := (
			for $postings in fn:doc("posting.xml")//posting
				where $postings/@pID = $interview/@pID
				return $postings
		)

		let $resume := (
			for $resumes in fn:doc("resume.xml")//resume
				where $resumes/@rID = $interview/@rID
				return $resumes
		)

		(:the assessmentAverageScore for this specific rID:)
		let $assessmentAverageScore := avg((
				$interview//assessment/collegiality,
				$interview//assessment/techProficiency,
				$interview//assessment/communication,
				$interview//assessment/enthusiasm,
				$interview//answer
				))


		(:the degree of match for this specific interview:)
		let $seqSkillsPossessed := (
			for $skill in $resume//skill
				return $skill/@what
		)

		let $seqDegreeOfMatch := (
			for $posting_skill in $posting//reqSkill

				let $resume_skill := (
					for $_skill in $resume//skill
						where $posting_skill/@what = $_skill/@what
						return $_skill
				)

				return 
					if (exists(index-of($seqSkillsPossessed, $posting_skill/@what)))

					then (:if resume has a skill that is required:)
						if ($resume_skill/@level >= $posting_skill/@level)
						then
							$posting_skill/@importance
						else
							$posting_skill/@importance * -1
					
					else (:if resume didn't have this particular skill:)
						$posting_skill/@importance * -1
		)			

		let $degreeOfMatch := sum($seqDegreeOfMatch)

	(:	return {(string($resume/@rID), string($posting/@pID), $degreeOfMatch)} :)


		return 
				<interview>

					<who rID = "{string($interview/@rID)}" 
						forename = "{string($resume//forename)}" 
						surname = "{string($resume//surname)}"
					/>					
					
					<position>{string($interview/@pID)}</position>
					<match>{data($degreeOfMatch)}</match>
					<average>{data($assessmentAverageScore)}</average>
				</interview>
)

return
	<report>
		{$returnInterview}
	</report>
(:

<who 
					rID = data($interview/@rID) 
					forename = data($resume//forename) 
					surname = data($resume//surname)
				/>
				


<!ELEMENT report (interview*)>
<!ELEMENT interview (who, position, match, average)>
<!ELEMENT who EMPTY>
<!ATTLIST who rID CDATA #REQUIRED
              forename CDATA #REQUIRED
              surname CDATA #REQUIRED>
<!ELEMENT position (#PCDATA)>
<!ELEMENT match (#PCDATA)>
<!ELEMENT average (#PCDATA)>

yukichankawawiiii
:)