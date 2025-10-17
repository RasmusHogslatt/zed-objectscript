; JS injection for event handler attributes in HTML contexts
(attribute
  (attribute_name) @_attr (#match? @_attr "^[Oo][Nn][A-Za-z]+$")
  (quoted_attribute_value (attribute_value) @injection.content)
  (#set! injection.language "javascript")
)
