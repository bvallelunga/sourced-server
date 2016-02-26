$.fn.extend
   vAlign: (position)->
   	return @each (i)->
       	h = $(@).height()
       	oh = $(@).outerHeight()
       	mt = (h + (oh - h)) / 2
       	$(@).css "margin-top", "-#{mt}px"
       	$(@).css "top", "50%"
       	$(@).css "position", if position then position else "absolute"


   hAlign: (position)->
   	return @each (i)->
       	w = $(@).width();
       	ow = $(@).outerWidth();
       	ml = (w + (ow - w)) / 2;
       	$(@).css "margin-left", "-#{ml}px"
       	$(@).css "left", "50%"
       	$(@).css "position", if position then position else "absolute"
