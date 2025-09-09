;; extends
((generic_command
  command: (command_name) @_name
  arg: (curly_group
    (_) @nospell))
  (#any-of? @_name "\\texttt" "\\Recocouverte" "\\Cref"))

(generic_environment
  (begin
    name: (curly_group_text
      (text) @label)
    (#any-of? @label "VulnBloc" "Reco"))
  .
  (curly_group
    (text) @nospell))

(generic_environment
  (begin
    name: (curly_group_text
      (text) @label)
    (#any-of? @label "extract"))
  .
  (curly_group
    (text) @spell)
  .
  (curly_group
    (text) @nospell))


