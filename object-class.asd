(asdf:defsystem #:object-class

  :author "Jean-Philippe Paradis <hexstream@hexstreamsoft.com>"

  :license "Unlicense"

  :description "Ensures that special subclasses of standard-object cluster right in front of standard-object in the class precedence list."

  :depends-on ("closer-mop"
               "compatible-metaclasses"
               "enhanced-find-class")

  :version "1.0"
  :serial cl:t
  :components ((:file "package")
               (:file "main")
               (:file "autosuperclass"))

  :in-order-to ((asdf:test-op (asdf:test-op #:object-class_tests))))
