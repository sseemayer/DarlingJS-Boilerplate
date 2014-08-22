LD = {}

width = 800
height = 600

LD.world = darlingjs.w 'ld30', [
  'ngFlatland'
  'ngPixijsAdapter'
  'ngStats'
  'control'
  'carControl'
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

LD.world.$add 'control'
LD.world.$add 'carControlRotateCCW'
LD.world.$add 'carControlRotateCW'
LD.world.$add 'carControlForward'
LD.world.$add 'carControlReverse'

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

  carControl: {}
  controllable:
    keyBindings:
      37: 'carControlRotateCCW'
      39: 'carControlRotateCW'

      38: 'carControlForward'
      40: 'carControlReverse'


console.log plane
console.log LD.world

LD.world.$start()
