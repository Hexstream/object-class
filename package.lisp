(cl:defpackage #:object-class
  (:use #:cl)
  (:shadow #:class)
  (:shadowing-import-from #:enhanced-find-class #:find-class)
  (:export #:class
           #:object-class
           #:push-back-to-target

           #:autosuperclass))
