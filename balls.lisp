(defun spawn-threads (thread-count)
  (let ((i 0))
    (while (< i thread-count)
      ; Call RUN-THREAD inside a continuation delimited by the default prompt
      (push-default-prompt
        (run-thread thread-count))
      (incf i))))

(defun run-thread (thread-id)
  (let ((ball (js-object :x (+ 300 ($random_offset 200))
                         :y (+ 240 ($random_offset 100))
                         :radius 5
                         :color "#ff0000"
                         :dx ($random_offset 3)
                         :dy ($random_offset 3)
                         :id thread-id)))
    (@push $BALLS ball) ; add ball to global array, defined in JS, below
    (loop               ; do forever
      ($move_ball ball) ; call JS function to perform "heavy lifting"
      (sleep))))        ; at this point, we yield back to the default prompt

(defun sleep ()
  ; Abort back up to the default prompt and schedule future resumption
  ; of the suspended continuation.
  (take-default-subcont k
    ($setImmediate (js-lambda #ign
                     (push-default-subcont k)))))

(spawn-threads 15)
