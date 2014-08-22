mod = darlingjs.m "control"

mod.$c 'controllable',
  keyBindings: {}


mod.$s 'control',
  $require: ['controllable']
  _keyToEntities: {}
  _keyDownHandler: null
  _keyUpHandler: null
  $added: () ->
    self = this

    @_keyDownHandler = (e) -> self.onKeyDown e
    @_keyUpHandler = (e) -> self.onKeyUp e

    document.addEventListener 'keydown', @_keyDownHandler
    document.addEventListener 'keyup', @_keyUpHandler

  $removed: () ->
    document.removeEventListener 'keydown', @_keyDownHandler
    document.removeEventListener 'keyup', @_keyUpHandler


  addKeyWatch: (keyCode, $entity, binding) ->
    if not @_keyToEntities[keyCode]
      @_keyToEntities[keyCode] = []

    @_keyToEntities[keyCode].push [$entity, binding]

  removeKeyWatch: (keyCode, $entity, binding) ->
    entities = @_keyToEntities[keyCode]
    index = entities.indexOf [$entity, binding]
    entities.splice index, 1

  $addEntity: ($entity) ->
    for keyCode, binding of $entity.controllable.keyBindings
      @addKeyWatch keyCode, $entity, binding

  $removeEntity: ($entity) ->
    for keyCode, binding of $entity.controllable.keyBindings
      @removeKeyWatch keyCode, $entity, binding

  onKeyDown: (e) ->
    entities = @_keyToEntities[e.keyCode]
    if ((not entities) or entities.length == 0) then return false

    for [$entity, binding] in entities
      $entity.$add binding

    e.preventDefault()
    false

  onKeyUp: (e) ->
    entities = @_keyToEntities[e.keyCode]
    if ((not entities) or entities.length == 0) then return false

    for [$entity, binding] in entities
      $entity.$remove binding
