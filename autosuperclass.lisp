(in-package #:object-class)

(defclass object-class:autosuperclass (class-options:options-mixin compatible-metaclasses:standard-class)
  ()
  (:metaclass compatible-metaclasses:standard-metaclass))

(defgeneric object-class:autosuperclass (class)
  (:method ((class object-class:autosuperclass))
    nil))

(defmethod class-options:canonicalize-options ((class object-class:autosuperclass)
                                               &key (direct-superclasses nil direct-superclasses-p))
  (if (or (eq (class-options:operation) 'initialize-instance)
          direct-superclasses-p)
      (let ((autosuperclass (object-class:autosuperclass class)))
        (check-type autosuperclass list)
        (if autosuperclass
            (list* :direct-superclasses (append direct-superclasses autosuperclass)
                   (call-next-method))
            (call-next-method)))
      (call-next-method)))
