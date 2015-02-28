for $result in fn:doc("interview.xml")//interview
where not(fn:exists($result//collegiality))
return $result//@sID