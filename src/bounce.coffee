mod = darlingjs.m("bounce")

mod.$c 'bounce',
	xRadius: 0
	yRadius: 0
	xSpeed: 0
	ySpeed: 0
	rotSpeed: 0
	rotSize: 0
	rotOffset: 0

mod.$s 'bounceSystem',
	$require: ['ng2D', 'ng2DRotation', 'bounce']

	_timer: 0

	$update: ['$entity', '$time', ($entity, $time) ->
		ng2D = $entity.ng2D
		ng2DRotation = $entity.ng2DRotation
		bounce = $entity.bounce

		this._timer += $time

		ng2D.x += bounce.xRadius * Math.cos(this._timer * bounce.xSpeed)
		ng2D.y -= bounce.yRadius * Math.sin(this._timer * bounce.ySpeed)

		ng2DRotation.rotation = bounce.rotSize * Math.sin(this._timer * bounce.rotSpeed) + bounce.rotOffset

	]

