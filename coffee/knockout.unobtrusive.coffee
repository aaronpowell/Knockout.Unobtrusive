###
Knockout.Unobtrusive v0.1

Copyright (C)2011 Brandon Satrom, Carrot Pants Studios
Distributed Under MIT License

Documentation and Full license Available at:
http://github.com/bsatrom/knockout.unobtrusive

----------------------------
Knockout.Unobtrusive
----------------------------
###
ko.unobtrusive = {
  createBindings: (bindings) ->
    if not bindings
      bindings = ko.unobtrusive.bindings
      
    getElement = (id) ->
      el = document.getElementById(id) or document.getElementsByName(id)[0]
      
      if not el
        id = id.charAt(0).toUpperCase() + id.slice 1
        el = document.getElementById id
    
      return el
    
    setElementBinding = (id, value) ->
      el = getElement id;
      if el
        existing = el.getAttribute "data-bind"
        
        if existing
          value = "#{existing}, #{value}"
          
        el.setAttribute "data-bind", value
    
    createElementBinding = (element, koBinding) ->
      if typeof element is "object"
        for own key, value of element
          setElementBinding key, "#{koBinding}: #{element[key]}"
      else
        if koBinding.indexOf(":") > 0
          setElementBinding element, koBinding
        else
          setElementBinding element, "#{koBinding}: #{element}"
    
    for own valueKey, value of bindings.value
      createElementBinding bindings.value[valueKey], "value"
      
    for own textKey, value of bindings.text
      createElementBinding bindings.text[textKey], "text"
      
    for own optionsKey, value of bindings.options
      createElementBinding bindings.options[optionsKey], "options" 
    
    for own checkedKey, value of bindings.checked
      createElementBinding bindings.checked[checkedKey], "checked"
    
    for own customKey, value of bindings.custom
      createElementBinding customKey, bindings.custom[customKey]
}

ko.unobtrusive.bindings = {
  value: []
  text: []
  options: []
  checked: []
  custom: {}
}