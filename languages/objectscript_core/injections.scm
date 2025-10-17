; Injections for INT routines (aliasing UDL grammar)

; Treat comments as comment language for consistent styling
[
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (block_comment)
  (documatic_line)
] @injection.content
  (#set! injection.language "comment")

; SQL blocks if present
(embedded_sql
  (_
    (paren_fenced_text) @injection.content
  )
  (#set! injection.language "sql")
  (#set! injection.include-children "true")
)

; Heuristic: HTML inside ObjectScript string literals
(string_literal) @injection.content
  (#match? @injection.content "<\\s*\\w+(\\s|/?>)")
  (#set! injection.language "html")

; Heuristic: JavaScript-like content inside string literals
(string_literal) @injection.content
  (#match? @injection.content "^(?:\\s*)?(function\\s|var\\s|let\\s|const\\s|\\$\\()")
  (#set! injection.language "javascript")
