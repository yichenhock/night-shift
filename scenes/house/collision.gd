tool
extends StaticBody2D
export(int,0,300) var bordersizeL setget set_bordersizeL
export(int,0,300) var bordersizeR setget set_bordersizeR

func set_bordersizeL(size):
	bordersizeL = size
	$shapeLeft.shape = $shapeLeft.shape.duplicate(true)
	$shapeLeft.shape.extents.x = bordersizeL
	
func set_bordersizeR(size):
	bordersizeR = size
	$shapeRight.shape = $shapeRight.shape.duplicate(true)
	$shapeRight.shape.extents.x = bordersizeR

