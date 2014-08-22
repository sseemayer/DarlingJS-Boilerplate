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


    console.log 'added'

    @_keyDownHandler = (e) -> self.onKeyDown e
    @_keyUpHandler = (e) -> self.onKeyUp e

    document.addEventListener 'keydown', @_keyDownHandler
    document.addEventListener 'keyup', @_keyUpHandler

  $removed: () ->
    document.removeEventListener 'keydown', @_keyDownHandler
    document.removeEventListener 'keyup', @_keyUpHandler


  addKeyWatch: (keyCode, $entity, binding) ->
    console.log("Watching for #{keyCode} on #{$entity} (bound to '#{binding}')")
    if not @_keyToEntities[keyCode]
      @_keyToEntities[keyCode] = []

    @_keyToEntities[keyCode].push [$entity, binding]

  removeKeyWatch: (keyCode, $entity, binding) ->
    entities = @_keyToEntities[keyCode]
    index = entities.indexOf [$entity, binding]
    entities.splice index, 1

  $addEntity: ($entity) ->
    console.log "Add entity #{$entity}"
    for keyCode, binding of $entity.controllable.keyBindings
      @addKeyWatch keyCode, $entity, binding

  $removeEntity: ($entity) ->
    console.log "Remove entity #{entity}"
    for keyCode, binding of $entity.controllable.keyBindings
      @removeKeyWatch keyCode, $entity, binding

  onKeyDown: (e) ->
    entities = @_keyToEntities[e.keyCode]
    if ((not entities) or entities.length == 0) then return false

    for [$entity, binding] in entities
      console.log "adding #{binding} on #{$entity}"
      $entity.$add binding

    e.preventDefault()
    false

  onKeyUp: (e) ->
    entities = @_keyToEntities[e.keyCode]
    if ((not entities) or entities.length == 0) then return false

    for [$entity, binding] in entities
      console.log "removing #{binding} on #{$entity}"
      $entity.$remove binding
