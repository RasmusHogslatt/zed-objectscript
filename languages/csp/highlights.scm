; Highlight CSP namespaced tags prominently
(start_tag (tag_name) @keyword.directive
  (#match? @keyword.directive "^[Cc][Ss][Pp]:"))
(end_tag (tag_name) @keyword.directive
  (#match? @keyword.directive "^[Cc][Ss][Pp]:"))
