for $result in fn:doc("resume.xml")//resume
where count($result//skill) > 2
return $result/@rID