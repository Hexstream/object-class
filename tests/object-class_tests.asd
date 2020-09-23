(asdf:defsystem #:object-class_tests

  :author "Jean-Philippe Paradis <hexstream@hexstreamsoft.com>"

  :license "Unlicense"

  :description "object-class unit tests."

  :depends-on ("object-class"
               "parachute"
               "compatible-metaclasses")

  :serial cl:t
  :components ((:file "tests"))

  :perform (asdf:test-op (op c) (uiop:symbol-call '#:parachute '#:test '#:object-class_tests)))
