LD = {}

width = 800
height = 600

LD.world = darlingjs.w 'ld30', [
	'ngFlatland'
	'ngPixijsAdapter'
	'ngStats'
	'bounce'
]

LD.world.$add 'ngStatsBegin'


LD.viewport = LD.world.$add 'ng2DViewPort',
	lookAt:
		x: width / 2
		y: height / 2
	
	width: width
	height: height

LD.stage = LD.world.$add 'ngPixijsStage',
	domId: 'main'
	width: width
	height: height

LD.world.$add 'ngPixijsSpriteFactory'
LD.world.$add 'ngPixijsPositionUpdateCycle'
LD.world.$add 'ngPixijsRotationUpdateCycle'
LD.world.$add 'ngPixijsViewPortUpdateCycle'

LD.world.$add 'ngStatsEnd', domId: 'main'

LD.world.$add 'bounceSystem'

plane = LD.world.$e 'box',
	ng2D:
		x: width / 2
		y: height * 0.70

	ng2DRotation:
		rotation: -3.14 / 4

	ng2DSize:
		width: 10
		height: 10

	ngSprite:
		name: 'plane.png'
		spriteSheetUrl: 'assets/spritesheets/main.json'

	bounce:
		xRadius: 0.3
		yRadius: 2
		xSpeed: 0.004
		ySpeed: 0.001
		rotSpeed: 0.001
		rotSize: -3.14/4

console.log plane


LD.world.$start()
