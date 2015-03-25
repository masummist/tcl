#!/usr/bin/wish

proc piechart {w x y width height data} {
	set coords [list $x $y [expr {$x+$width}] [expr {$y+$height}]]
	set xm [expr {$x+$width/2.}]
	set ym [expr {$y+$height/2.}]
	set rad [expr {$width/2.+20}]
	set sum 0
	foreach item $data {set sum [expr {$sum + [lindex $item 1]}]}
	set start 270
	foreach item $data {
		foreach {name n color} $item break
		set extent [expr {$n*360./$sum}]
		$w create arc $coords -start $start -extent $extent -fill $color
		set angle [expr {($start-90+$extent/2)/180.*acos(-1)}]
		set tx [expr $xm-$rad*sin($angle)]
		set ty [expr $ym-$rad*cos($angle)]
		$w create text $tx $ty -text $name:$n -tag txt
		set start [expr $start+$extent]

	}
	$w raise txt
}

pack [canvas .c -bg white]
piechart .c 50 50 150 150 {
	{PnR             8 red}
	{CustomLayout   18 gray}
	{PCB             5 blue}
	{Verification    6 yellow}
	{AMD            12 red}
	{NonAMD          5 purple}
}

