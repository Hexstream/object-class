(in-package #:object-class)

(defclass object-class:object-class (compatible-metaclasses:standard-class)
  ()
  (:metaclass compatible-metaclasses:standard-metaclass))

(defclass object-class:class (compatible-metaclasses:standard-class)
  ()
  (:metaclass compatible-metaclasses:standard-metaclass))

(defun %object-class-p (class)
  (typep class 'object-class:object-class))

(defmacro %the-class (class-name)
  `(load-time-value (find-class ',class-name)))

(defun object-class:push-back-to-target (list pushbackp targetp &optional (target-callback #'nreconc))
  (let ((to-push-back nil))
    (labels ((recurse (rest)
               (if rest
                   (let ((element (car rest)))
                     (if (funcall targetp element)
                         (funcall target-callback to-push-back rest)
                         (if (funcall pushbackp element)
                             (progn
                               (push element to-push-back)
                               (recurse (cdr rest)))
                             (cons element (recurse (cdr rest))))))
                   (funcall target-callback to-push-back nil))))
      (recurse list))))

(defmethod c2mop:compute-class-precedence-list ((class object-class:class))
  (object-class:push-back-to-target
   (call-next-method)
   #'%object-class-p
   (lambda (class)
     (or (eq class (%the-class c2mop:standard-object))
         (eq class (%the-class c2mop:funcallable-standard-object))))
   (lambda (to-push-back rest)
     (if rest
         (nreconc to-push-back rest)
         (error "Neither ~S nor ~S were found in the class precedence list."
                (%the-class c2mop:standard-object)
                (%the-class c2mop:funcallable-standard-object))))))
