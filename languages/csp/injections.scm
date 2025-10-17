; Injections for CSP pages (HTML base)

; 1) Server-side Cache/ObjectScript script blocks
(script_element
  (start_tag
    (attribute
      (attribute_name) @_n1 (#match? @_n1 "^[Ll]anguage$")
      (quoted_attribute_value (attribute_value) @_v1 (#match? @_v1 "^[\"']([Cc]ache|[Oo]bject[Ss]cript)[\"']$"))
    )
  )
  (raw_text) @injection.content
  (#set! injection.language "objectscript_core")
  (#set! injection.include-children "true")
)

; 1b) Alternative server-side marker: runat="server"
(script_element
  (start_tag
    (attribute
      (attribute_name) @_n2 (#match? @_n2 "^[Rr]unat$")
      (quoted_attribute_value (attribute_value) @_v2 (#match? @_v2 "^[\"']server[\"']$"))
    )
  )
  (raw_text) @injection.content
  (#set! injection.language "objectscript_core")
  (#set! injection.include-children "true")
)

; 2) CSP namespaced tags: treat attribute values as ObjectScript expressions
(element
  (start_tag
    (tag_name) @_tn (#match? @_tn "^[Cc][Ss][Pp]:")
    (attribute (quoted_attribute_value (attribute_value) @injection.content))
  )
  (#set! injection.language "objectscript_core")
)

; 3) Server directives in attribute values across any tag (e.g., src="#(%session.Data(\"SRC\"))#file.js")
(attribute
  (quoted_attribute_value (attribute_value) @injection.content)
  (#match? @injection.content "#\(|##\(|#(server|call)\(")
  (#set! injection.language "objectscript_core")
)
