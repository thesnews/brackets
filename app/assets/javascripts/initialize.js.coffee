initializers = []

$ ->
  for [selector, action] in initializers
    if not selector? or $(selector).length > 0
      action.call $(selector)

window.initialize = (selector, action) ->
  if not action?
    action = selector
    selector = undefined
  initializers.push [selector, action]
