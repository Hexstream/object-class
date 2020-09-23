(cl:defpackage #:object-class_tests
  (:use #:cl #:parachute)
  (:import-from #:object-class #:push-back-to-target))

(cl:in-package #:object-class_tests)

(defclass my-object-class ()
  ((%my-slot :reader my-slot
             :initform 'my-value))
  (:metaclass object-class:object-class))

(defclass my-metaclass (object-class:autosuperclass object-class:class)
  ()
  (:metaclass compatible-metaclasses:standard-metaclass))

(defclass my-other-metaclass (my-metaclass)
  ()
  (:metaclass compatible-metaclasses:standard-metaclass)
  (:validate-as my-metaclass))

(defmethod object-class:autosuperclass ((class my-metaclass))
  (list (find-class 'my-object-class)))

(defclass my-class ()
  ()
  (:metaclass my-metaclass))

(defclass my-other-class (my-class)
  ()
  (:metaclass my-other-metaclass))

(defclass my-normal-class (my-class)
  ())

(define-test "main"
  (is eq 'my-value (my-slot (make-instance 'my-class)))
  (is eq 'my-value (my-slot (make-instance 'my-other-class)))
  (is eq 'my-value (my-slot (make-instance 'my-normal-class)))
  (is equal '(a b e f 3 4 nil t 9)
      (push-back-to-target '(a b 3 4 e f nil t 9)
                           #'integerp
                           #'null))
  (is equal '(a b e f 4 3 nil t 9)
      (push-back-to-target '(a b 3 4 e f nil t 9)
                           #'integerp
                           #'null
                           #'nconc))
  (is equal '(a b e f nil t 3 4)
      (push-back-to-target '(a 3 b 4 e f nil t)
                           #'integerp
                           #'characterp))
  (is equal '(a b e f 3 4 nil t)
      (push-back-to-target '(a b 3 4 e f nil t)
                           #'integerp
                           #'null))
  (is equal '(a b 3 nil 4 e f nil t)
      (push-back-to-target '(a b 3 nil 4 e f nil t)
                           #'integerp
                           #'null))
  (is equal '(a b c)
      (push-back-to-target '(a b c)
                           #'integerp
                           #'null))
  (is equal '(a b c nil)
      (push-back-to-target '(a b c nil)
                           #'integerp
                           #'null))
  (is equal '(a b c)
      (push-back-to-target '(a b c)
                           #'symbolp
                           #'integerp)))
